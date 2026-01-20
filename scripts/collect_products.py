import requests
import csv
from datetime import datetime

# 1. Endpoint da API
url = "https://dummyjson.com/products?limit=194"

# 2. Fazer a requisição GET
response = requests.get(url)

# 3. Converter a resposta para JSON
data = response.json()

# 4. Criar a data de coleta
collection_date = datetime.now().strftime("%Y-%m-%d")

# 5. Definir caminho do arquivo CSV
output_file = "../data/products_bronze.csv"

# 6. Definir campos salvos no CSV
fields = [
    "collection_date",
    "product_id",
    "title",
    "price",
    "discount_percentage",
    "brand",
    "category",
    "rating",
    "stock"
]

# 7. Abrir o CSV para escrita
with open(output_file, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow([fields])

# 8. Percorrer a lista de produtos
    for product in data["products"]:
        writer.writerow([
            collection_date,
            product.get("id"),
            product.get("title"),
            product.get("price"),
            product.get("discountPercentage"),
            product.get("brand"),
            product.get("category"),
            product.get("rating"),
            product.get("stock")
        ])

print("Arquivo Bronze gerado com sucesso:", output_file)
