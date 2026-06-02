

DROP TABLE IF EXISTS fato_desempenho_aluno CASCADE;
DROP TABLE IF EXISTS dim_tempo CASCADE;
DROP TABLE IF EXISTS dim_disciplina CASCADE;
DROP TABLE IF EXISTS dim_curso CASCADE;
DROP TABLE IF EXISTS dim_aluno CASCADE;

CREATE TABLE dim_aluno (
    sk_aluno SERIAL PRIMARY KEY,
    aluno_id INTEGER NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120),
    cpf VARCHAR(20)
);

CREATE TABLE dim_curso (
    sk_curso SERIAL PRIMARY KEY,
    curso_id INTEGER NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    area VARCHAR(80) NOT NULL
);

CREATE TABLE dim_disciplina (
    sk_disciplina SERIAL PRIMARY KEY,
    disciplina_id INTEGER NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    professor_nome VARCHAR(100),
    carga_horaria INTEGER
);

CREATE TABLE dim_tempo (
    sk_tempo SERIAL PRIMARY KEY,
    data_matricula DATE NOT NULL UNIQUE,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    nome_mes VARCHAR(20) NOT NULL
);

CREATE TABLE fato_desempenho_aluno (
    sk_fato SERIAL PRIMARY KEY,
    sk_aluno INTEGER NOT NULL REFERENCES dim_aluno(sk_aluno),
    sk_curso INTEGER NOT NULL REFERENCES dim_curso(sk_curso),
    sk_disciplina INTEGER NOT NULL REFERENCES dim_disciplina(sk_disciplina),
    sk_tempo INTEGER NOT NULL REFERENCES dim_tempo(sk_tempo),
    matricula_id INTEGER NOT NULL UNIQUE,
    nota NUMERIC(4,2),
    frequencia NUMERIC(5,2),
    aprovado INTEGER NOT NULL,
    reprovado INTEGER NOT NULL
);
