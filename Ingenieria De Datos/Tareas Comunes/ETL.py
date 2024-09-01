import pandas as pd
import requests
from sqlalchemy import create_engine

url = "http://api.weatherapi.com/v1/current.json?key=18671deec27c47f29b4124952241108&q=Bogota"

# Realizar la solicitud GET a la API
response = requests.get(url)
data = response.json()

# Normalizar los datos JSON en un DataFrame de Pandas
df = pd.json_normalize(data)

# Mostrar los datos extraídos (opcional)
print("Datos extraídos:")
print(df.head())

# Transformación de los datos
# Selección de columnas relevantes
df_transformed = df[['location.name', 'location.region', 'location.country', 'current.temp_c', 'current.condition.text']]

# Renombrar columnas para mayor claridad
df_transformed.columns = ['City', 'Region', 'Country', 'Temperature_C', 'Condition']

# Mostrar los datos transformados (opcional)
print("Datos transformados:")
print(df_transformed.head())

# Carga de los datos en una base de datos SQLite
# Crear una conexión a la base de datos SQLite
engine = create_engine('sqlite:///weather_data.db')

# Cargar los datos transformados en la base de datos
df_transformed.to_sql('weather', con=engine, if_exists='replace', index=False)

print("Datos cargados en la base de datos SQLite 'weather_data.db'.")


# Consultar los datos de la tabla 'weather'
df_loaded = pd.read_sql('weather', con=engine)

# Mostrar los datos cargados desde la base de datos
print("Datos cargados desde la base de datos:")
print(df_loaded)
