-- ============================================================
-- PostgreSQL - Dados de origem do projeto
-- Data Engineering — Pipeline de Dados Automotivos
-- ============================================================

-- ------------------------------------------------------------
-- Tabela: estados
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.estados (
    id_estados INTEGER PRIMARY KEY,
    estado VARCHAR(100) NOT NULL,
    sigla VARCHAR(2) NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL
);

INSERT INTO public.estados
    (id_estados, estado, sigla, data_inclusao, data_atualizacao)
VALUES
    (1, 'Pernambuco', 'PE', '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (2, 'Bahia', 'BA', '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (3, 'Ceará', 'CE', '2025-01-01 08:00:00', '2025-01-01 08:00:00')
ON CONFLICT (id_estados) DO NOTHING;


-- ------------------------------------------------------------
-- Tabela: cidades
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.cidades (
    id_cidades INTEGER PRIMARY KEY,
    cidade VARCHAR(100) NOT NULL,
    id_estados INTEGER NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL,

    CONSTRAINT fk_cidades_estados
        FOREIGN KEY (id_estados)
        REFERENCES public.estados (id_estados)
);

INSERT INTO public.cidades
    (id_cidades, cidade, id_estados, data_inclusao, data_atualizacao)
VALUES
    (1, 'Recife', 1, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (2, 'Olinda', 1, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (3, 'Salvador', 2, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (4, 'Fortaleza', 3, '2025-01-01 08:00:00', '2025-01-01 08:00:00')
ON CONFLICT (id_cidades) DO NOTHING;


-- ------------------------------------------------------------
-- Tabela: concessionarias
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.concessionarias (
    id_concessionarias INTEGER PRIMARY KEY,
    concessionaria VARCHAR(150) NOT NULL,
    id_cidades INTEGER NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL,

    CONSTRAINT fk_concessionarias_cidades
        FOREIGN KEY (id_cidades)
        REFERENCES public.cidades (id_cidades)
);

INSERT INTO public.concessionarias
    (id_concessionarias, concessionaria, id_cidades, data_inclusao, data_atualizacao)
VALUES
    (1, 'Auto Recife', 1, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (2, 'Nordeste Motors', 2, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (3, 'Bahia Car', 3, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (4, 'Fortaleza Motors', 4, '2025-01-01 08:00:00', '2025-01-01 08:00:00')
ON CONFLICT (id_concessionarias) DO NOTHING;


-- ------------------------------------------------------------
-- Tabela: clientes
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.clientes (
    id_clientes INTEGER PRIMARY KEY,
    cliente VARCHAR(150) NOT NULL,
    endereco VARCHAR(255),
    id_concessionarias INTEGER NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL,

    CONSTRAINT fk_clientes_concessionarias
        FOREIGN KEY (id_concessionarias)
        REFERENCES public.concessionarias (id_concessionarias)
);

INSERT INTO public.clientes
    (id_clientes, cliente, endereco, id_concessionarias, data_inclusao, data_atualizacao)
VALUES
    (1, 'Ana Silva', 'Rua das Flores, 100', 1, '2025-01-02 09:00:00', '2025-01-02 09:00:00'),
    (2, 'Bruno Santos', 'Av. Recife, 250', 1, '2025-01-02 09:30:00', '2025-01-02 09:30:00'),
    (3, 'Carla Oliveira', 'Rua do Sol, 80', 2, '2025-01-03 10:00:00', '2025-01-03 10:00:00'),
    (4, 'Daniel Costa', 'Av. Central, 500', 3, '2025-01-03 10:30:00', '2025-01-03 10:30:00'),
    (5, 'Eduarda Lima', 'Rua Bahia, 120', 3, '2025-01-04 11:00:00', '2025-01-04 11:00:00'),
    (6, 'Felipe Souza', 'Av. Beira Mar, 300', 4, '2025-01-04 11:30:00', '2025-01-04 11:30:00')
ON CONFLICT (id_clientes) DO NOTHING;


-- ------------------------------------------------------------
-- Tabela: veiculos
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.veiculos (
    id_veiculos INTEGER PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL
);

INSERT INTO public.veiculos
    (id_veiculos, nome, tipo, valor, data_inclusao, data_atualizacao)
VALUES
    (1, 'Fiat Argo', 'Hatch', 85000.00, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (2, 'Toyota Corolla', 'Sedan', 145000.00, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (3, 'Jeep Compass', 'SUV', 185000.00, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (4, 'BMW 320i', 'Sedan', 310000.00, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (5, 'Mercedes-Benz C200', 'Sedan', 390000.00, '2025-01-01 08:00:00', '2025-01-01 08:00:00'),
    (6, 'Porsche Macan', 'SUV', 520000.00, '2025-01-01 08:00:00', '2025-01-01 08:00:00')
ON CONFLICT (id_veiculos) DO NOTHING;


-- ------------------------------------------------------------
-- Tabela: vendedores
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.vendedores (
    id_vendedores INTEGER PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    id_concessionarias INTEGER NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL,

    CONSTRAINT fk_vendedores_concessionarias
        FOREIGN KEY (id_concessionarias)
        REFERENCES public.concessionarias (id_concessionarias)
);

INSERT INTO public.vendedores
    (id_vendedores, nome, id_concessionarias, data_inclusao, data_atualizacao)
VALUES
    (1, 'Marcos Almeida', 1, '2025-01-02 08:00:00', '2025-01-02 08:00:00'),
    (2, 'Juliana Martins', 1, '2025-01-02 08:30:00', '2025-01-02 08:30:00'),
    (3, 'Rafael Gomes', 2, '2025-01-03 08:00:00', '2025-01-03 08:00:00'),
    (4, 'Patricia Rocha', 3, '2025-01-03 08:30:00', '2025-01-03 08:30:00'),
    (5, 'Lucas Ferreira', 4, '2025-01-04 08:00:00', '2025-01-04 08:00:00')
ON CONFLICT (id_vendedores) DO NOTHING;


-- ------------------------------------------------------------
-- Tabela: vendas
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.vendas (
    id_vendas INTEGER PRIMARY KEY,
    id_veiculos INTEGER NOT NULL,
    id_concessionarias INTEGER NOT NULL,
    id_vendedores INTEGER NOT NULL,
    id_clientes INTEGER NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    data_venda DATE NOT NULL,
    data_inclusao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL,

    CONSTRAINT fk_vendas_veiculos
        FOREIGN KEY (id_veiculos)
        REFERENCES public.veiculos (id_veiculos),

    CONSTRAINT fk_vendas_concessionarias
        FOREIGN KEY (id_concessionarias)
        REFERENCES public.concessionarias (id_concessionarias),

    CONSTRAINT fk_vendas_vendedores
        FOREIGN KEY (id_vendedores)
        REFERENCES public.vendedores (id_vendedores),

    CONSTRAINT fk_vendas_clientes
        FOREIGN KEY (id_clientes)
        REFERENCES public.clientes (id_clientes)
);

INSERT INTO public.vendas
    (
        id_vendas,
        id_veiculos,
        id_concessionarias,
        id_vendedores,
        id_clientes,
        valor_pago,
        data_venda,
        data_inclusao,
        data_atualizacao
    )
VALUES
    (1, 1, 1, 1, 1, 82000.00, '2025-01-10', '2025-01-10 10:00:00', '2025-01-10 10:00:00'),
    (2, 2, 1, 2, 2, 140000.00, '2025-01-15', '2025-01-15 11:00:00', '2025-01-15 11:00:00'),
    (3, 3, 2, 3, 3, 180000.00, '2025-02-05', '2025-02-05 09:30:00', '2025-02-05 09:30:00'),
    (4, 4, 3, 4, 4, 305000.00, '2025-02-18', '2025-02-18 14:00:00', '2025-02-18 14:00:00'),
    (5, 5, 3, 4, 5, 380000.00, '2025-03-02', '2025-03-02 15:00:00', '2025-03-02 15:00:00'),
    (6, 6, 4, 5, 6, 510000.00, '2025-03-20', '2025-03-20 16:00:00', '2025-03-20 16:00:00'),
    (7, 1, 1, 1, 1, 83000.00, '2025-04-08', '2025-04-08 10:30:00', '2025-04-08 10:30:00'),
    (8, 3, 2, 3, 3, 182000.00, '2025-04-22', '2025-04-22 13:00:00', '2025-04-22 13:00:00')
ON CONFLICT (id_vendas) DO NOTHING;