#!/usr/bin/python
import mysql.connector
import random
import datetime

conn = mysql.connector.connect(host = "localhost", user = "root", passwd = "", db = "asociacion_deportes")
cursor = conn.cursor()

############################ Poblamiento Tabla "Evento" ################################
#COLUMNAS DE LA TABLA EVENTO:
#id: int(10) - PK
#fecha_inicio: DATE
#fecha_termino: DATE
#nombre: VARCHAR(30)
#premio_id: int(10)
#directiva_rut: VARCHAR(20)

#Funcion para obtener fecha
def get_random_date(year):
    # try to get a date
    try:
        return datetime.datetime.strptime('{} {}'.format(random.randint(1, 366), year), '%j %Y')
    # if the value happens to be in the leap year range, try again
    except ValueError:
        print("Error")
        
# Insertar datos #
try:
    for i in range(20):
        date = get_random_date(random.randint(2000,2017))
        fecha=str(date)
        #En el insert falta agregar fechas que no sean iguales y que la de inicio sea menor a la de termino, además de agregar nombre y directiva_rut
        cursor.execute("INSERT INTO evento(id, fecha_inicio, fecha_termino, nombre, premio_id, directiva_rut) VALUES("+str(i)+",'"+str(fecha[0:10])+"',"+str(fecha[0:10])+",'nombre',"+str(i)+",'directiva_rut')")
        conn.commit()
except Exception, e:
    print (str(e))
    conn.rollback()


# Obtener datos #
try:
    #Obtiene una fecha en formato datetime en el rango de 2000 a 2017
    date = get_random_date(random.randint(2000,2017))
    #Se convierte a String
    fecha=str(date)
    dates= fecha[0:10]
    cursor.execute("SELECT * FROM evento")
    resultados = cursor.fetchall()
    for registro in resultados:
        evento_id = registro[0]
        fecha_inicio = registro[1]
        fecha_termino = registro[2]
        nombre = registro[3]
        premio_id = registro[4]
        directiva_rut = registro[5]
        print(evento_id, fecha_inicio, fecha_termino, nombre, premio_id, directiva_rut)
except Exception, e:
    print (str(e))
    conn.rollback()
        
############################ Poblamiento Tabla "Torneo" ################################
#COLUMNAS DE LA TABLA TORNEO
#evento_id: int(10) - PK

# Insertar datos #
try:
    for i in range(20):
        cursor.execute("INSERT INTO torneo(evento_id) VALUES("+str(i)+")")
        conn.commit()
except Exception, e:
    print (str(e))
    conn.rollback()

# Obtener datos #
try:
    cursor.execute("SELECT * FROM torneo")
    resultados = cursor.fetchall()
    for registro in resultados:
        evento_id = registro[0]
        print(evento_id)
except Exception, e:
    print (str(e))
    conn.rollback()

############################ Poblamiento Tabla "Campeonato" ############################
#evento_id: int(10) - PK
#numero_campeonato: int(20)unsigned
#numero_fechas: int(10)

# Insertar datos #
try:
    for i in range(20):
        #No sé con qué se llena numero_fechas
        cursor.execute("INSERT INTO campeonato(evento_id, numero_campeonato, numero_fechas) VALUES("+str(i)+","+str(i)+","+str(i)+")")
        conn.commit()
except Exception, e:
    print (str(e))
    conn.rollback()

# Obtener datos #
try:
    cursor.execute("SELECT * FROM campeonato")
    resultados = cursor.fetchall()
    for registro in resultados:
        evento_id = registro[0]
        numero_campeonato = registro[1]
        numero_fechas = registro[2]
        print(evento_id, numero_campeonato, numero_fechas)
except Exception, e:
    print (str(e))
    conn.rollback()


cursor.close()
conn.close()
