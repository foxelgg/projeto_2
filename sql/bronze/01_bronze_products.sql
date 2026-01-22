/* ====================================================================================================
    CAMADA BRONZE - PRODUCTS
    - Este arquivo documenta a criação da tabela bronze_products, a partir do dataset oriundo do arquivo
        'products_bronze.csv'.

    - O CSV foi coletado a partir da API pública DummyJSON, que fornece dados fictícios para testes,
    desenvolvimento e projetos educacionais. A coleta ocorreu com o uso de Python e a biblioteca 
    requests, que permite fazer requisições HTTP de forma simples e eficiente. O processo pode ser visto
    no arquivo 'collect_products.py' dentro da pasta 'scripts'.

    - Na camada bronze, os arquivos serão mantidos exatamente como estão no arquivo CSV, e a tipagem será
    por padrão TEXT, para evitar erros de ingestão e permitir a rastreabilidade dos dados originais.

    CARGA DA TABELA BRONZE_PRODUCTS
    - A carga se deu através do comando '\COPY' que é específico do psql, e portanto deve ser executado
     **EM SESSÃO PSQL**, que executei no terminal dentro do VSCode.
    - Exemplo no terminal:
        cd projeto_2
        psql -h localhost -U postgres -d projeto_2 -p 5433
    ==================================================================================================== */

-- ==================================
-- CRIAÇÃO DA TABELA BRONZE.PRODUCTS
-- ==================================

DROP TABLE IF EXISTS bronze.products;

CREATE TABLE bronze.products (
    collection_date TEXT,
    product_id TEXT,
    title TEXT,
    price TEXT,
    discount_percentage TEXT,
    brand TEXT,
    category TEXT,
    rating TEXT,
    stock TEXT
);

-- ==================================================
-- CARGA DA TABELA BRONZE.PRODUCTS VIA TERMINAL PSQL
-- ==================================================

\COPY bronze.products
FROM 'data/products_bronze.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);


