import win32com.client
import os
import datetime
import json
import ttkbootstrap as ttk
from ttkbootstrap.constants import *
from tkinter import filedialog, messagebox

CONFIG_FILE = "config.json"

def cargar_configuracion():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            return json.load(f)
    return {
        "correos": ["xaviertaless@gmail.com"],
        "asuntos": ["Datos"],
        "carpetas": [r"D:\Produ"]
    }

def guardar_configuracion():
    # Evitar duplicados
    nuevo_correo = correo_var.get().strip()
    nuevo_asunto = asunto_var.get().strip()
    nueva_carpeta = output_folder_var.get().strip()

    if nuevo_correo and nuevo_correo not in config["correos"]:
        config["correos"].append(nuevo_correo)
    if nuevo_asunto and nuevo_asunto not in config["asuntos"]:
        config["asuntos"].append(nuevo_asunto)
    if nueva_carpeta and nueva_carpeta not in config["carpetas"]:
        config["carpetas"].append(nueva_carpeta)

    with open(CONFIG_FILE, "w") as f:
        json.dump(config, f, indent=4)

def seleccionar_carpeta():
    carpeta = filedialog.askdirectory()
    if carpeta:
        output_folder_var.set(carpeta)

def descargar_archivo():
    remitente_filtrado = correo_var.get().strip()
    asunto_filtrado = asunto_var.get().strip()
    extension_archivo = extension_var.get().strip()
    output_folder = output_folder_var.get().strip()

    if not remitente_filtrado or not asunto_filtrado or not extension_archivo or not output_folder:
        messagebox.showwarning("Campos incompletos", "Por favor, completa todos los campos.")
        return

    try:
        hoy = datetime.datetime.now().date()
        outlook = win32com.client.Dispatch("Outlook.Application").GetNamespace("MAPI")
        inbox = outlook.GetDefaultFolder(6)
        messages = inbox.Items
        messages.Sort("[ReceivedTime]", True)

        encontrado = False
        for message in messages:
            try:
                if message.ReceivedTime.date() != hoy:
                    break

                sender_email = ""
                try:
                    if message.SenderEmailType == "EX":
                        sender_email = message.Sender.GetExchangeUser().PrimarySmtpAddress
                    else:
                        sender_email = message.SenderEmailAddress
                except Exception as e:
                    print(f"Error obteniendo email del remitente: {e}")
                    continue

                if (sender_email and sender_email.lower() == remitente_filtrado.lower()
                        and asunto_filtrado.lower() in message.Subject.lower()):

                    attachments = message.Attachments
                    for attachment in attachments:
                        if attachment.FileName.endswith(extension_archivo):
                            save_path = os.path.join(output_folder, attachment.FileName)
                            attachment.SaveAsFile(save_path)
                            messagebox.showinfo("Éxito", f"Archivo guardado en:\n{save_path}")
                            encontrado = True
                    break
            except Exception as e:
                print(f"Error procesando correo: {e}")

        if not encontrado:
            messagebox.showinfo("Sin resultados", "No se encontró un correo que coincida con los filtros de hoy.")
        else:
            guardar_configuracion()
    except Exception as e:
        messagebox.showerror("Error", f"Ocurrió un error: {e}")

# Cargar configuración
config = cargar_configuracion()

# Crear ventana principal con tema moderno
ventana = ttk.Window(themename="superhero")
ventana.title("Descargar archivos de Outlook")
ventana.geometry("650x320")
ventana.resizable(False, False)

# Variables
correo_var = ttk.StringVar()
asunto_var = ttk.StringVar()
extension_var = ttk.StringVar(value=".xlsx")
output_folder_var = ttk.StringVar()

# UI
ttk.Label(ventana, text="Correo del remitente:").grid(column=0, row=0, padx=10, pady=10, sticky="w")
correo_combo = ttk.Combobox(ventana, textvariable=correo_var, values=config["correos"], width=40)
correo_combo.grid(column=1, row=0, padx=10)
correo_combo.set(config["correos"][0])

ttk.Label(ventana, text="Asunto del correo:").grid(column=0, row=1, padx=10, pady=10, sticky="w")
asunto_combo = ttk.Combobox(ventana, textvariable=asunto_var, values=config["asuntos"], width=40)
asunto_combo.grid(column=1, row=1, padx=10)
asunto_combo.set(config["asuntos"][0])

ttk.Label(ventana, text="Extensión del archivo:").grid(column=0, row=2, padx=10, pady=10, sticky="w")
ttk.Combobox(ventana, textvariable=extension_var, values=[".xlsx", ".csv"], state="readonly").grid(column=1, row=2, padx=10)

ttk.Label(ventana, text="Carpeta destino:").grid(column=0, row=3, padx=10, pady=10, sticky="w")
carpeta_combo = ttk.Combobox(ventana, textvariable=output_folder_var, values=config["carpetas"], width=40)
carpeta_combo.grid(column=1, row=3, padx=10)
carpeta_combo.set(config["carpetas"][0])
ttk.Button(ventana, text="Buscar", command=seleccionar_carpeta, bootstyle="secondary").grid(column=2, row=3, padx=5)

ttk.Button(ventana, text="Descargar archivo", command=descargar_archivo, bootstyle="warning").grid(column=1, row=4, pady=20)

ventana.mainloop()
