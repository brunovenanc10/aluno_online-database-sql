

CREATE OR REPLACE FUNCTION fn_atualiza_data_matricula()
RETURNS TRIGGER AS $$
BEGIN
    NEW.data_atualizacao = CURRENT_TIMESTAMP;

    IF NEW.nota IS NULL THEN
        NEW.situacao = 'SEM NOTA';
    ELSIF NEW.nota >= 7 AND NEW.frequencia >= 75 THEN
        NEW.situacao = 'APROVADO';
    ELSE
        NEW.situacao = 'REPROVADO';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_atualiza_matricula ON matriculas;

CREATE TRIGGER trg_atualiza_matricula
BEFORE INSERT OR UPDATE ON matriculas
FOR EACH ROW
EXECUTE FUNCTION fn_atualiza_data_matricula();

-- Procedure para atualizar nota e frequência de uma matrícula.
CREATE OR REPLACE PROCEDURE prc_atualizar_desempenho_matricula(
    p_matricula_id INTEGER,
    p_nota NUMERIC,
    p_frequencia NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE matriculas
    SET nota = p_nota,
        frequencia = p_frequencia
    WHERE id = p_matricula_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Matrícula % não encontrada.', p_matricula_id;
    END IF;
END;
$$;
