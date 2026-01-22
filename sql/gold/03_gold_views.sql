/* ====================================================================================================
    CAMADA GOLD - VIEWS ANALÍTICAS
    Este documento SQL visa criar views analíticas na Camada Gold, a partir dos dados presentes na tabela
    gold.products. Essas views serão otimizadas para análises específicas e facilitarão a criação de
    relatórios e dashboards no Power BI.

    Essas views serão consumidas dentro do Power BI, e usadas nos visuais desenvolvidos na ferramenta,
    com o intuito de melhorar performance e reduzir a necessidade de medidas DAX complexas.
   ==================================================================================================== */

-- ==========================================================
-- vw_products_overview: Visão geral do catálogo de produtos
-- ==========================================================
CREATE OR REPLACE VIEW gold.vw_products_overview AS
SELECT
    COUNT(*) AS total_produtos,
    AVG(price) AS preco_medio,
    AVG(final_price) AS preco_final_medio,
    AVG(discount_percentage) AS desconto_medio,
    AVG(rating) AS avaliacao_media,
    SUM(stock) AS estoque_total,
    COUNT(DISTINCT category) AS categorias_unicas,
    COUNT(DISTINCT brand) AS marcas_unicas,
    ROUND(SUM(CASE WHEN brand IS NULL THEN 1 ELSE 0 END)::numeric / COUNT(*), 4) AS proporcao_marcas_nulas 
FROM gold.products;

-- ================================================================
-- vw_products_by_category: Distribuição de produtos por categoria
-- ================================================================
CREATE OR REPLACE VIEW gold.vw_products_by_category AS
SELECT
    category,
    COUNT(*) AS total_produtos,
    AVG(price) AS preco_medio,
    AVG(final_price) AS preco_final_medio,
    AVG(rating) AS avaliacao_media,
    SUM(stock) AS estoque_total
FROM gold.products
GROUP BY category;

-- =========================================================================
-- vw_products_by_price_bucket: Distribuição de produtos por faixa de preço
-- =========================================================================
CREATE OR REPLACE VIEW gold.vw_products_by_price_bucket AS
SELECT
    price_bucket,
    COUNT(*) AS total_produtos,
    AVG(final_price) AS preco_final_medio,
    AVG(rating) AS avaliacao_media
FROM gold.products
GROUP BY price_bucket;

-- ======================================================================================
-- vw_products_by_rating_bucket: Distribuição de produtos por classificação de avaliação
-- ======================================================================================
CREATE OR REPLACE VIEW gold.vw_products_by_rating_bucket AS
SELECT
    rating_bucket,
    COUNT(*) AS total_produtos,
    AVG(final_price) AS preco_final_medio
FROM gold.products
GROUP BY rating_bucket;

-- =============================================================================
-- vw_stock_status: Resumo dos produtos que estão em estoque vs fora de estoque
-- =============================================================================
CREATE OR REPLACE VIEW gold.vw_stock_status AS
SELECT
    stock_status,
    COUNT(*) AS total_produtos
FROM gold.products
GROUP BY stock_status;