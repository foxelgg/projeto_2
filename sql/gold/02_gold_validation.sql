/* ====================================================================================================
    CAMADA GOLD - VALIDAÇÃO DE DADOS
    Esse arquivo documenta as validações realizadas na tabela gold.products, com o intuito de garantir a
    integridade e qualidade dos dados antes de serem utilizados na criação de views, relatórios e análises.
    ==================================================================================================== */

-- 1. PK não pode ser NULL
SELECT *
FROM gold.products
WHERE product_id IS NULL;

-- 2. PK deve ser única
SELECT 
    product_id,
    COUNT(*) AS pk_count
FROM gold.products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- 3. Contagem total de registros
SELECT
    COUNT(*) AS total_linhas
FROM gold.products;

-- 4. Preço final deve ser maior que zero
SELECT *
FROM gold.products
WHERE final_price < 0;

-- 5. Rating dentro do intervalo esperado
SELECT *
FROM gold.products
WHERE rating < 0 OR rating > 5;

-- 6. Estoque não pode ser negativo
SELECT *
FROM gold.products
WHERE stock < 0;

-- 7. Checagem de 'brand' nulos (mantidos - documentado)
SELECT
    COUNT(*) AS brand_nulos
FROM gold.products
WHERE brand IS NULL;

-- 8. Validar consistência de classificação de rating
SELECT *
FROM gold.products
WHERE (rating < 3 AND rating_bucket != 'Baixo')
   OR (rating >= 3 AND rating < 4 AND rating_bucket != 'Médio')
   OR (rating >= 4 AND rating < 4.5 AND rating_bucket != 'Alto')
   OR (rating >= 4.5 AND rating_bucket != 'Excelente');

-- 9. Validar consistência de classificação de preço
SELECT *
FROM gold.products
WHERE (final_price < 50 AND price_bucket != 'Baixo')
   OR (final_price >= 50 AND final_price < 500 AND price_bucket != 'Médio')
   OR (final_price >= 500 AND final_price < 2000 AND price_bucket != 'Alto')
   OR (final_price >= 2000 AND price_bucket != 'Premium');

-- 10. Validar consistência de status de estoque
SELECT *
FROM gold.products
WHERE (stock > 0 AND stock_status != 'Em estoque')
   OR (stock = 0 AND stock_status != 'Fora de estoque');