import pandas as pd
import os
import glob
 
# Ruta de la carpeta
carpeta = r"D:\Produ"
 
# Buscar el Excel más reciente
excels = glob.glob(os.path.join(carpeta, "*.xlsx"))
archivo_mas_reciente = max(excels, key=os.path.getmtime)
 
# Cargar Excel
df = pd.read_excel(archivo_mas_reciente, sheet_name="Sheet1")
 
# Limpiar encabezados
df.columns = df.columns.str.strip().str.replace('\t', '').str.replace('\n', '')
 
# Definir columnas
columnas = [
    "AtmKey", "TerminalType", "RecordTime", "SummaryDay", "NumFaults", "TotalTimeofOpSecs",
    "InServiceTimeSecs", "OutofServiceTimeSecs", "OoSDueToHWSecs", "OoSDueToSWSecs",
    "OoSDueToCommDownSecs", "OoSDueToHostDownSecs", "OoSDueToCashOutSecs", "OoSDueToSupplyOutSecs",
    "OoSDueToVandalismSecs", "OoSDueToMaintenanceSecs", "OoSDueToOtherFaultsSecs",
    "OosDueToReplenishmentSecs", "InactiveSecs", "InactiveOtherSecs", "OoSDueToRejectbinSecs"
]
 
# Columnas que deben ir como DateTime
columnas_datetime = ["RecordTime", "SummaryDay"]
 
# Función para formatear
def formatear_valor(col, val):
    if pd.isna(val):
        return "NULL"
    if col in columnas_datetime:
        return f"CAST(N'{pd.to_datetime(val).strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3]}' AS DateTime)"
    else:
        return str(int(val))
 
# Generar SQL
tabla = "[dbo].[AVL_TERMINAL_SUMMARY_NO_ATM_BLACKLIST_PARA_DESA]"
inserts = []
for _, row in df.iterrows():
    valores = [formatear_valor(col, row[col]) for col in columnas]
    sql = f"INSERT {tabla} ({', '.join(f'[{c}]' for c in columnas)}) VALUES ({', '.join(valores)});"
    inserts.append(sql)
 
# Guardar archivo
output_path = os.path.join(carpeta, "insert_resultado.sql")
with open(output_path, "w", encoding="utf-8") as f:
    f.write("\n".join(inserts))
 
print(f"Archivo generado correctamente en: {output_path}")