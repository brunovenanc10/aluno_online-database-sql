

CREATE OR REPLACE VIEW vw_alunos_info AS
SELECT
    a.id AS aluno_id,
    a.nome AS aluno_nome,
    a.email,
    a.cpf,
    a.data_nascimento,
    COUNT(m.id) AS qtd_matriculas,
    ROUND(AVG(m.nota), 2) AS media_geral,
    CASE
        WHEN AVG(m.nota) >= 7 THEN 'APROVADO'
        WHEN AVG(m.nota) >= 6 THEN 'RECUPERACAO'
        WHEN AVG(m.nota) < 6 THEN 'REPROVADO'
        ELSE 'SEM NOTA'
    END AS status_geral
FROM alunos a
LEFT JOIN matriculas m ON m.aluno_id = a.id
GROUP BY a.id, a.nome, a.email, a.cpf, a.data_nascimento;

CREATE OR REPLACE VIEW vw_matriculas_completa AS
SELECT
    m.id AS matricula_id,
    a.id AS aluno_id,
    a.nome AS aluno_nome,
    c.id AS curso_id,
    c.nome AS curso_nome,
    c.area AS curso_area,
    d.id AS disciplina_id,
    d.nome AS disciplina_nome,
    p.id AS professor_id,
    p.nome AS professor_nome,
    m.data_matricula,
    EXTRACT(YEAR FROM m.data_matricula)::INT AS ano,
    EXTRACT(MONTH FROM m.data_matricula)::INT AS mes,
    m.nota,
    m.frequencia,
    CASE
        WHEN m.nota >= 7 AND m.frequencia >= 75 THEN 'APROVADO'
        WHEN m.nota IS NULL THEN 'SEM NOTA'
        ELSE 'REPROVADO'
    END AS situacao_calculada
FROM matriculas m
INNER JOIN alunos a ON a.id = m.aluno_id
INNER JOIN disciplinas d ON d.id = m.disciplina_id
INNER JOIN cursos c ON c.id = d.curso_id
INNER JOIN professores p ON p.id = d.professor_id;
