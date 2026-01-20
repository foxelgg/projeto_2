-- Criação de Schemas para diferentes camadas de dados, seguindo a arquitetura Medallion.

CREATE SCHEMA IF NOT EXISTS bronze;

CREATE SCHEMA IF NOT EXISTS silver;

CREATE SCHEMA IF NOT EXISTS gold;