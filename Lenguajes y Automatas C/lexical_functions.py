import re

identificador = r'\b[a-zA-Z]+\b'
identificador_palabra = r'\b(suma|resta|edad)\b'
entero = r'[0-9]+'
real = r'[0-9]+\.[0-9]+'
operador_aritmetico = r'[\+\-\*\/\%\=]'
operador_relacional = r'<=|>=|!=|<|>|=='
operador_logico = r'!|\&\&|\|\|'
palabra_reservada = r'si|sino|read|readIn|for|then|real|cadena|logico|sino|si|entonces|hacer' \
                    r'|repetir|hasta|variables|programa|funcion|vacio|entero|real|var|leer|escribir'\
                    r'|haz|mientras|encaso|caso|default|regresar|ejecutar'
parentesis_abre = r'\('
parentesis_cierra = r'\)'
punto_y_coma = r';'
coma = r','
dos_puntos = r':'
comentario = r'//.*'
blanco = r'[ \t]'
fin_de_linea = r'\n'

tokens_titulo = {
    'identificador': identificador,
    'real': real,
    'entero': entero,
    'operador_relacional': operador_relacional,
    'operador_logico': operador_logico,
    'operador_aritmetico': operador_aritmetico,
    'identificador_palabra': identificador_palabra,
    'palabra_reservada': palabra_reservada,
    'parentesis_abre': parentesis_abre,
    'parentesis_cierra': parentesis_cierra,
    'punto_y_coma': punto_y_coma,
    'coma': coma,
    'dos_puntos': dos_puntos,
    'comentario': comentario,
    'fin_de_linea': fin_de_linea,
    'blanco': blanco,
}

tokens = {
    'palabra_reservada': {
        #'if': -1,
        'si': -1,
        'funcion':-999,
        'vacio': -999,
        'var':-999,
        'leer': -3,
        'escribir':-4,
        'haz':-999,
        'encaso':-999,
        'caso':-5,
        'default':-999,
        'regresar':-999,
        'ejecutar':-999,
        #'else': -2,
        #'read': -3,
        #'readIn': -4,
        #'for': -5,
        #'then': -6,
        'sino': -2,
        'mientras': -8,
        'repetir': -9,
        'hasta': -10,
        'entero': -11,
        'real': -12,
        'cadena': -13,
        'logico': -14,
        'variables': -15,
        'hacer': -17
    },
    'operador_aritmetico': {
        '+': -51,
        '-': -52,
        '*': -53,
        '/': -54,
        '=':-65
    },
    'operador_relacional': {
        '<': -62,
        '<=': -64,
        '>': -61,
        '>=': -63,
        '!=': -66,
        '==': 66,
    },
    'operador_logico':{
        '&&':-41,
        '!':-89,
        '||':-1010,

    },
    'identificador_palabra': {
        'suma': -41,
        'resta': -42,
        'edad': -43,
    },
    'identificador': {
      'identificador':-21
    },
    'entero': {
        'entero': -61
    },
    'real': {
        'real': -72
    },
    'logico': {
        'suma': -74,
        'resta': -75,
        'edad': -21
    },
    'parentesis': {
        '(': -83,
        ')': -84
    },
    'punto_y_coma': {
        ';': -85
    },
    'coma': {
        ',': -86
    },
    'dos_puntos': {
        ':': -87
    },
}


def tokenizar(nombre_token, token, linea):
    switch_dict = {
        'identificador': lambda token_search: (tokens['identificador']['identificador'], token_search, -2, linea),
        'identificador_palabra': lambda token_search: (tokens['identificador_palabra'][token_search], token_search, -2, linea),
        'entero': lambda token_search: (tokens['entero']['entero'], token_search, -1, linea),
        'real': lambda token_search: (tokens['real']['real'], token_search, -1, linea),
        'operador_aritmetico': lambda token_search: (tokens['operador_aritmetico'][token_search], token_search, -1, linea),
        'operador_logico': lambda token_search: (tokens['operador_logico'][token_search], token_search, -1, linea),
        'operador_relacional': lambda token_search: (tokens['operador_relacional'][token_search], token_search, -1, linea),
        'palabra_reservada': lambda token_search: (tokens['palabra_reservada'][token_search], token_search, -1, linea),
        'parentesis_abre': lambda token_search: (tokens['parentesis']['('], token_search, -1, linea),
        'parentesis_cierra': lambda token_search: (tokens['parentesis'][')'], token_search, -1, linea),
        'punto_y_coma': lambda token_search: (tokens['punto_y_coma'][';'], token_search, -1, linea),
        'coma': lambda token_search: (tokens['coma'][','], token_search, -1, linea),
        'dos_puntos': lambda token_search: (tokens['dos_puntos'][':'], token_search, -1, linea)
    }
    return switch_dict.get(nombre_token, (-100, token, -0, linea))


def analizar_archivo(codigo_fuente):
    lista_tokens = []
    lista_errores = []

    for index, linea in enumerate(codigo_fuente.splitlines()):

        linea = re.sub(comentario, '', linea)
        i = 0

        while i < len(linea):
            for nombre_token, expresion_regular in tokens_titulo.items():
                match = re.match(expresion_regular, linea[i:])
                if match:
                    token = match.group(0)
                    if nombre_token != 'blanco' and nombre_token != 'fin_de_linea':
                        lista_tokens.append(tokenizar(nombre_token, token, index+1)(token))
                    i += len(token)
                    break
            else:
                lista_errores.append((linea[i], index+1))
                i += 1

    return lista_tokens, lista_errores

