

SELECT * FROM vw_alunos_info;
SELECT * FROM vw_matriculas_completa;
CALL prc_atualizar_desempenho_matricula(2, 7.50, 85.00);
SELECT * FROM vw_matriculas_completa WHERE matricula_id = 2;

CALL prc_carregar_modelo_dimensional();
SELECT * FROM dim_aluno;
SELECT * FROM dim_curso;
SELECT * FROM dim_disciplina;
SELECT * FROM dim_tempo;
SELECT * FROM fato_desempenho_aluno;

SELECT
    dc.nome AS curso,
    dd.nome AS disciplina,
    dt.ano,
    dt.mes,
    COUNT(*) AS qtd_matriculas,
    ROUND(AVG(f.nota), 2) AS media_nota,
    SUM(f.aprovado) AS total_aprovados,
    SUM(f.reprovado) AS total_reprovados
FROM fato_desempenho_aluno f
INNER JOIN dim_curso dc ON dc.sk_curso = f.sk_curso
INNER JOIN dim_disciplina dd ON dd.sk_disciplina = f.sk_disciplina
INNER JOIN dim_tempo dt ON dt.sk_tempo = f.sk_tempo
GROUP BY dc.nome, dd.nome, dt.ano, dt.mes
ORDER BY dt.ano, dt.mes, dc.nome, dd.nome;
