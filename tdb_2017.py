#!/usr/bin/python
import mysql.connector
import random
import datetime

conn = mysql.connector.connect(host = "localhost", user = "root", passwd = "", db = "tdb_2017")
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
        cursor.execute("INSERT INTO evento(id_evento,fecha) VALUES("+str(i)+",'"+str(fecha[0:10])+"')")
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
        id_evento = registro[0]
        fecha = registro[1]
        print(id_evento,fecha)
except Exception, e:
    print (str(e))
    conn.rollback()
        
############################ Poblamiento Tabla "Torneo" ################################
#COLUMNAS DE LA TABLA TORNEO
#evento_id: int(10) - PK

# Insertar datos #
try:
    for i in range(20):
        cursor.execute("INSERT INTO torneo(id_torneo,fk_evento) VALUES("+str(i)+",'"+str(i)+"')")
        conn.commit()
except Exception, e:
    print (str(e))
    conn.rollback()

# Obtener datos #
try:
    cursor.execute("SELECT * FROM torneo")
    resultados = cursor.fetchall()
    for registro in resultados:
        id_torneo = registro[0]
        fk_evento = registro[1]
        print(id_torneo,fk_evento)
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
        cursor.execute("INSERT INTO campeonato(id_campeonato,fk_evento) VALUES("+str(i)+",'"+str(i)+"')")
        conn.commit()
except Exception, e:
    print (str(e))
    conn.rollback()

# Obtener datos #
try:
    cursor.execute("SELECT * FROM campeonato")
    resultados = cursor.fetchall()
    for registro in resultados:
        id_campeonato = registro[0]
        fk_evento = registro[1]
        print(id_campeonato,fk_evento)
except Exception, e:
    print (str(e))
    conn.rollback()


cursor.close()
conn.close()
