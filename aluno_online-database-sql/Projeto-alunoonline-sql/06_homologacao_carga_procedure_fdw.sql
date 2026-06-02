

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

DROP SERVER IF EXISTS srv_aluno_online_producao CASCADE;

CREATE SERVER srv_aluno_online_producao
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', dbname 'aluno_online_producao', port '5432');

CREATE USER MAPPING FOR CURRENT_USER
SERVER srv_aluno_online_producao
OPTIONS (user 'postgres', password 'postgres');

DROP SCHEMA IF EXISTS producao_fdw CASCADE;
CREATE SCHEMA producao_fdw;

IMPORT FOREIGN SCHEMA public
LIMIT TO (vw_matriculas_completa, vw_alunos_info)
FROM SERVER srv_aluno_online_producao
INTO producao_fdw;

CREATE OR REPLACE PROCEDURE prc_carregar_modelo_dimensional()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Dimensão Aluno
    INSERT INTO dim_aluno (aluno_id, nome, email, cpf)
    SELECT DISTINCT aluno_id, aluno_nome, email, cpf
    FROM producao_fdw.vw_alunos_info
    ON CONFLICT (aluno_id) DO UPDATE SET
        nome = EXCLUDED.nome,
        email = EXCLUDED.email,
        cpf = EXCLUDED.cpf;

    -- Dimensão Curso
    INSERT INTO dim_curso (curso_id, nome, area)
    SELECT DISTINCT curso_id, curso_nome, curso_area
    FROM producao_fdw.vw_matriculas_completa
    ON CONFLICT (curso_id) DO UPDATE SET
        nome = EXCLUDED.nome,
        area = EXCLUDED.area;

    -- Dimensão Disciplina
    INSERT INTO dim_disciplina (disciplina_id, nome, professor_nome, carga_horaria)
    SELECT DISTINCT disciplina_id, disciplina_nome, professor_nome, NULL::INTEGER
    FROM producao_fdw.vw_matriculas_completa
    ON CONFLICT (disciplina_id) DO UPDATE SET
        nome = EXCLUDED.nome,
        professor_nome = EXCLUDED.professor_nome;

    -- Dimensão Tempo
    INSERT INTO dim_tempo (data_matricula, ano, mes, nome_mes)
    SELECT DISTINCT
        data_matricula,
        ano,
        mes,
        TO_CHAR(data_matricula, 'TMMonth') AS nome_mes
    FROM producao_fdw.vw_matriculas_completa
    ON CONFLICT (data_matricula) DO NOTHING;

    -- Fato Desempenho
    INSERT INTO fato_desempenho_aluno (
        sk_aluno, sk_curso, sk_disciplina, sk_tempo,
        matricula_id, nota, frequencia, aprovado, reprovado
    )
    SELECT
        da.sk_aluno,
        dc.sk_curso,
        dd.sk_disciplina,
        dt.sk_tempo,
        v.matricula_id,
        v.nota,
        v.frequencia,
        CASE WHEN v.situacao_calculada = 'APROVADO' THEN 1 ELSE 0 END AS aprovado,
        CASE WHEN v.situacao_calculada = 'REPROVADO' THEN 1 ELSE 0 END AS reprovado
    FROM producao_fdw.vw_matriculas_completa v
    INNER JOIN dim_aluno da ON da.aluno_id = v.aluno_id
    INNER JOIN dim_curso dc ON dc.curso_id = v.curso_id
    INNER JOIN dim_disciplina dd ON dd.disciplina_id = v.disciplina_id
    INNER JOIN dim_tempo dt ON dt.data_matricula = v.data_matricula
    ON CONFLICT (matricula_id) DO UPDATE SET
        nota = EXCLUDED.nota,
        frequencia = EXCLUDED.frequencia,
        aprovado = EXCLUDED.aprovado,
        reprovado = EXCLUDED.reprovado;
END;
$$;

-- Executar carga:
-- CALL prc_carregar_modelo_dimensional();
