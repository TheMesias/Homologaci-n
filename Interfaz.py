import ttkbootstrap as ttk
from ttkbootstrap.constants import *
import subprocess

# Funciones para ejecutar cada script
def ejecutar_correo():
    subprocess.Popen(["python", "correo.py"])

def ejecutar_conexion():
    subprocess.Popen(["python", "conexion.py"])

def ejecutar_inyeccion():
    subprocess.Popen(["python", "inyeccion.py"])

# Crear ventana principal
app = ttk.Window(themename="superhero")
app.title("General")
app.geometry("350x200")

# Etiqueta del título
ttk.Label(app, text="Homologacion", font=("Helvetica", 14, "bold")).pack(pady=10)

# Frame contenedor
frame = ttk.Frame(app, padding=10)
frame.pack(pady=10)

ttk.Label(frame, text="①", font=("Helvetica", 12)).grid(row=0, column=0, padx=10)
ttk.Button(frame, text="Inyeccion", command=ejecutar_inyeccion, bootstyle=WARNING).grid(row=1, column=2, padx=10, pady=5)


# Botón 2 - CONEXION
ttk.Label(frame, text="②", font=("Helvetica", 12)).grid(row=0, column=1, padx=10)
ttk.Button(frame, text="Conexion", command=ejecutar_conexion, bootstyle=INFO).grid(row=1, column=1, padx=10, pady=5)

ttk.Label(frame, text="③", font=("Helvetica", 12)).grid(row=0, column=2, padx=10)
ttk.Button(frame, text="Correo", command=ejecutar_correo, bootstyle=SUCCESS).grid(row=1, column=0, padx=10, pady=5)
app.mainloop()