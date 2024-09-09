import tkinter as tk
from tkinter import ttk
from tkinter import filedialog
import lexical_functions as lf
from tkinter import messagebox
import csv
import subprocess


class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Analisis lexico")
        self.width = self.winfo_screenwidth()
        self.height = self.winfo_screenheight()
        self.tokens = []
        self.geometry("{}x{}".format(self.width, self.height))  # tamaño de ventana inicial
        self.resizable(True, True)  # permitir que la ventana sea redimensionable
        self.columnconfigure(0, weight=1)  # configurar la columna izquierda para que se expanda
        self.columnconfigure(1, weight=1)  # configurar la columna derecha para que se expanda
        self.rowconfigure(0, weight=1)  # configurar la fila para que se expanda

        # crear widgets de la columna derecha
        self.frame2 = tk.Frame(self, bg="black")
        self.frame2.grid(row=0, column=0, sticky="nsew")
        self.frame2.columnconfigure(0, weight=1)
        self.frame2.rowconfigure(1, weight=1)

        self.button2 = tk.Button(self.frame2, text="Buscar archivo", command=self.buscar_archivo)
        self.button2.grid(row=0, column=0, padx=10, pady=10)
        self.button4 = tk.Button(self.frame2, text="Analizar sintaxis", command=self.analizar_sintaxis)
        self.button4.grid(row=0, column=1, padx=10, pady=10)

        self.textarea2 = tk.Text(self.frame2, bg="white", fg="black")
        self.textarea2.grid(row=1, column=0, sticky="nsew", padx=10, pady=10)

        # crear widgets de la columna izquierda
        self.frame1 = tk.Frame(self, bg="black")
        self.frame1.grid(row=0, column=1, sticky="nsew")
        self.frame1.columnconfigure(0, weight=1)
        self.frame1.rowconfigure(1, weight=1)

        self.button1 = tk.Button(self.frame1, text="Analizar codigo", command=self.analizar_codigo)
        self.button1.grid(row=0, column=1, padx=10, pady=10)
        self.button3 = tk.Button(self.frame1, text="Generar archivo", command=self.generar_archivo_con_csv)
        self.button3.grid(row=0, column=0, padx=10, pady=10)

        self.treeview = ttk.Treeview(self.frame1, columns=("lexema", "token","tp", "linea"), show="headings")
        self.treeview.grid(row=1, column=1, sticky="nsew", padx=10, pady=10)
        self.treeview.column("lexema", width=150)
        self.treeview.column("token", width=150)
        self.treeview.column("tp", width=150)
        self.treeview.column("linea", width=150)

        self.treeview.heading("lexema", text="Lexema")
        self.treeview.heading("token", text="Token")
        self.treeview.heading("tp", text="T.P")
        self.treeview.heading("linea", text="Línea")

     
    def buscar_archivo(self):
        self.textarea2.delete("1.0", tk.END)
        self.treeview.delete(*self.treeview.get_children())
        archivo = filedialog.askopenfilename(filetypes=[("Archivos de texto", "*.txt")])
        if archivo:
            with open(archivo, "r") as f:
                contenido = f.read()
                self.textarea2.insert(tk.END, contenido)

    def analizar_codigo(self):
        self.treeview.delete(*self.treeview.get_children())
        value = self.textarea2.get("1.0", "end-1c")
        self.tokens, self.error = lf.analizar_archivo(value)
        for lexema, token, posicion, linea in self.tokens:
            self.treeview.insert("", "end", values=(token, lexema, posicion, linea))

    def analizar_sintaxis(self):

        value = self.textarea2.get("1.0", "end-1c")
        with open('test.txt', 'w') as f:
            f.write(value)

        ejecutable = "./a.out"
        archivo_entrada = "./test.txt"
        comando = f"{ejecutable} < {archivo_entrada}"
        resultado = subprocess.run(comando, shell=True, capture_output=True, text=True)

        print(resultado.stdout)
        if "exitosamente" in resultado.stdout:
            messagebox.showinfo(message=resultado.stdout, title="Analisis sintactico")
        else:
            messagebox.showerror(message=resultado.stdout, title="Analisis sintactico")

        if resultado.stderr:
            print("Error:", resultado.stderr)

    def generar_archivo_con_csv(self):
        with open('tokens.csv', 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Token", "Lexema", "Posicion", "Linea"])
            for lexema, token, posicion, linea in self.tokens:
                writer.writerow([token, lexema, posicion, linea])
        with open('errores.csv', 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Lexema", "Linea"])
            for lexema, linea in self.error:
                writer.writerow([lexema, linea])
        messagebox.showinfo(message="Archivos generados correctamente", title="Archivos generados")





if __name__ == "__main__":
    app = App()
    app.mainloop()
