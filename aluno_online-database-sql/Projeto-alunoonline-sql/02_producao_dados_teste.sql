

INSERT INTO alunos (nome, email, cpf, data_nascimento) VALUES
('Harlen Galdino', 'harlen@email.com', '12345678900', '2003-05-10'),
('Carlos Eduardo', 'carlos@email.com', '98765432100', '2002-08-15'),
('Fernanda Lima', 'fernanda@email.com', '11122233344', '2001-03-20'),
('João Pedro', 'joao@email.com', '44455566677', '2004-11-02'),
('Ana Souza', 'ana@email.com', '99988877766', '2003-01-25');

INSERT INTO professores (nome, email, cpf) VALUES
('Carlos Mendes', 'carlos.mendes@email.com', '22233344455'),
('Fernanda Alves', 'fernanda.alves@email.com', '55566677788');

INSERT INTO cursos (nome, area) VALUES
('Sistemas para Internet', 'Tecnologia'),
('Administração', 'Gestão');

INSERT INTO disciplinas (nome, carga_horaria, curso_id, professor_id) VALUES
('Banco de Dados', 80, 1, 1),
('Engenharia de Software', 60, 1, 2),
('Gestão de Projetos', 60, 2, 2);

INSERT INTO matriculas (aluno_id, disciplina_id, data_matricula, nota, frequencia, situacao) VALUES
(1, 1, '2026-03-01', 8.50, 92.00, 'APROVADO'),
(2, 1, '2026-03-01', 5.80, 75.00, 'REPROVADO'),
(3, 2, '2026-03-05', 9.20, 95.00, 'APROVADO'),
(4, 2, '2026-03-05', 6.50, 88.00, 'RECUPERACAO'),
(5, 3, '2026-03-10', 7.00, 80.00, 'APROVADO');
