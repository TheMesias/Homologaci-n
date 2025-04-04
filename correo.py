import win32com.client
import os
import datetime
 
# Configuración
output_folder = r"D:\Produ"  # Cambia esta ruta
remitente_filtrado = "xaviertaless@gmail.com"
asunto_filtrado = "Datos"
extension_archivo = ".xlsx"
 
# Fecha actual
hoy = datetime.datetime.now().date()
 
# Conexión a Outlook
outlook = win32com.client.Dispatch("Outlook.Application").GetNamespace("MAPI")
inbox = outlook.GetDefaultFolder(6)  # Bandeja de entrada
messages = inbox.Items
messages.Sort("[ReceivedTime]", True)
 
# Recorrer mensajes solo de hoy
for message in messages:
    try:
        if message.ReceivedTime.date() != hoy:
            break  # Como ya están ordenados de más reciente a más antiguo, se puede cortar aquí
 
        if (message.SenderEmailAddress.lower() == remitente_filtrado.lower() and 
            asunto_filtrado.lower() in message.Subject.lower()):
            
            attachments = message.Attachments
            for attachment in attachments:
                if attachment.FileName.endswith(extension_archivo):
                    save_path = os.path.join(output_folder, attachment.FileName)
                    attachment.SaveAsFile(save_path)
                    print(f"Archivo guardado: {save_path}")
            break  # Solo procesar el primer correo válido de hoy
    except Exception as e:
        print(f"Error procesando correo: {e}")
 