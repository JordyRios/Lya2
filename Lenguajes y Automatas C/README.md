# Lexical Syntactic Analyzer

## Description

Este comando es el que generara el ejecutable que python llamara para iniciar el analisis sintactico

```bash
bison -dt sintactico.y && flex lexico.l &&  gcc lex.yy.c sintactico.tab.c
```

El ejecutable se llamara `a.out` y este tiene que estar al mismo nivel que el archivo de 
interfaz para que el codigo pueda funcionar correctamente
