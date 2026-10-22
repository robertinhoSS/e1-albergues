CREATE TABLE IF NOT EXISTS albergues (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    concello VARCHAR(100) NOT NULL,
    camiño VARCHAR(100) NOT NULL,
    prazas INT NOT NULL,
    prezo_noite NUMERIC(5,2) NOT NULL
);