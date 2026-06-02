

DROP TABLE IF EXISTS matriculas CASCADE;
DROP TABLE IF EXISTS disciplinas CASCADE;
DROP TABLE IF EXISTS cursos CASCADE;
DROP TABLE IF EXISTS professores CASCADE;
DROP TABLE IF EXISTS alunos CASCADE;

CREATE TABLE alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    cpf VARCHAR(20) NOT NULL UNIQUE,
    data_nascimento DATE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP
);

CREATE TABLE professores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    cpf VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    area VARCHAR(80) NOT NULL
);

CREATE TABLE disciplinas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INTEGER NOT NULL,
    curso_id INTEGER NOT NULL REFERENCES cursos(id),
    professor_id INTEGER NOT NULL REFERENCES professores(id)
);

CREATE TABLE matriculas (
    id SERIAL PRIMARY KEY,
    aluno_id INTEGER NOT NULL REFERENCES alunos(id),
    disciplina_id INTEGER NOT NULL REFERENCES disciplinas(id),
    data_matricula DATE NOT NULL DEFAULT CURRENT_DATE,
    nota NUMERIC(4,2),
    frequencia NUMERIC(5,2),
    situacao VARCHAR(30),
    data_atualizacao TIMESTAMP
);
