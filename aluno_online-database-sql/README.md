# 🎓 Aluno Online Database

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?logo=postgresql)
![SQL](https://img.shields.io/badge/SQL-Standard-orange)
![Status](https://img.shields.io/badge/Status-Completed-success)
![License](https://img.shields.io/badge/License-MIT-green)
![Made with](https://img.shields.io/badge/Made%20with-DBeaver-blue)

Projeto de banco de dados desenvolvido em PostgreSQL para gerenciamento de alunos e professores, com foco em **automação de regras de negócio diretamente no banco**, utilizando **views** e **triggers**.

---

## 📌 📖 Descrição

Este projeto foi desenvolvido como extensão de um sistema backend em Java, com o objetivo de implementar uma base de dados eficiente e inteligente, contendo:

* Estrutura relacional (tabelas)
* Views para consultas otimizadas
* Triggers para automação
* Regras de negócio no banco (status automático)
* Controle de atualização de dados

---

## 🧱 🗄️ Estrutura do Banco

### 📊 Tabelas

#### 🔹 alunos

* id
* name
* email
* cpf
* nota
* data_atualizacao

#### 🔹 professores

* id
* name
* email
* cpf

---

## 👁️ 📈 Views

### 🔹 vw_alunos_info

View responsável por exibir os dados dos alunos com uma regra de negócio aplicada diretamente no banco:

* Calcula automaticamente o **status do aluno** com base na nota

#### 📌 Regras:

* Nota ≥ 7 → **APROVADO**
* Nota < 7 → **REPROVADO**
* Nota NULL → **SEM NOTA**

---

### 🔹 vw_pessoas

View que unifica alunos e professores em uma única consulta:

* name
* email
* tipo (ALUNO / PROFESSOR)

---

## ⚙️ 🔁 Trigger

### 🔹 trg_atualiza_alunos

Trigger executada automaticamente antes de qualquer atualização na tabela `alunos`.

#### 📌 Função:

Atualizar o campo `data_atualizacao` com a data e hora atual sempre que um registro for modificado.

---

## 🧠 📊 Regras de Negócio Implementadas

✔ Status automático de aprovação/reprovação
✔ Atualização automática de data e hora
✔ Lógica aplicada diretamente no banco

---

## 🧪 🧾 Dados de Teste

O banco já inclui dados para validação:

* 7 alunos com diferentes notas
* 2 professores

---

## 🚀 ▶️ Como Executar

### 1. Criar banco

```sql
CREATE DATABASE aluno_online;
```

---

### 2. Executar o script SQL

Execute os scripts SQL na seguinte sequência:

🧱 Tabelas
👁️ Views
🔁 Trigger
🧪 Dados
🧫 Teste

---

### 3. Testar funcionalidades

```sql
SELECT * FROM vw_alunos_info;
SELECT * FROM vw_pessoas;

UPDATE alunos SET name = 'Teste' WHERE id = 1;
SELECT * FROM alunos;
```

---

## 🛠️ 🧰 Tecnologias Utilizadas

* PostgreSQL
* SQL
* DBeaver

---

## 🎯 🎓 Objetivo Acadêmico

Projeto desenvolvido para a disciplina de Banco de Dados com foco em:

* Modelagem de dados
* Views
* Triggers
* Regras de negócio no banco

---

## 👨‍💻 Autor

* Harlen
* Carlos Eduardo

---

## 📌 📎 Conclusão

Este projeto demonstra o uso do banco de dados como uma camada ativa de processamento, garantindo:

* Consistência
* Automação
* Performance
* Organização da lógica

---
