import sys
import pymysql
import errno
from pymysql.err import ProgrammingError
import random
from os import getenv

DB_NAME = 'quizdatabase'
usrTB = 'usersTb'
queTb = 'questionsTb'
server = getenv("127.0.0.1:3306")
user = getenv("root")
password = getenv("milica999")

def runDataBase():
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()

    try:
        cursor.execute("create table IF NOT EXISTS questionsTb (question_Id serial PRIMARY KEY,question varchar(1000),answers varchar(1000),corect_answer varchar(400), typeOfQue VARCHAR (20));")

        print("questionsTb")

        cursor.execute("create table IF NOT EXISTS usersTb (user_ID serial PRIMARY KEY, user_name varchar(20), password varchar(20), email varchar(30), score varchar (10));")

        cnx.commit()
        print ("usrTb")


    except ProgrammingError as err:
        if err == errno.ECONNREFUSED:
            print("already exists.")
        else:
            print(err)

    print("OK")

    cursor.close()
    cnx.close()

def addingUser(self, usernameFromApp, passwordFromApp, emailFromApp):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()
    cursor.execute("INSERT INTO usersTb (user_name, password, email, score) VALUES (%s, %s, %s, %s)", (usernameFromApp,passwordFromApp,emailFromApp, "0"))
    cnx.commit()
    cursor.close()
    cnx.close()

def checkingIfUserExists(self, usernameFromApp, passwordFromApp, emailFromApp):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()
    emailExists = 0
    usernameExists = 0
    ret = ""
    cursor.execute("SELECT count(*) as count FROM usersTb WHERE email = '%s'" % emailFromApp)
    emailExists = cursor.fetchall()

    cursor.execute("SELECT count(*) as count FROM usersTb WHERE user_name='%s'" % usernameFromApp)
    usernameExists = cursor.fetchall()

    if (emailExists[0][0] != 0):
        ret = "email is already in use"
    elif (usernameExists[0][0] != 0):
        ret = "username is already in use"
    else:
        ret = "user not found"
    cursor.close()
    cnx.close()

    return  ret

def logingUser(self,usernameFromApp, passwordFromApp):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()
    passExists = 0
    usernameExists = 0
    ret = ""
    cursor.execute("SELECT count(*) as count FROM usersTb WHERE password = '%s'" % passwordFromApp)
    passExists = cursor.fetchall()

    cursor.execute("SELECT count(*) as count FROM usersTb WHERE user_name='%s'" % usernameFromApp)
    usernameExists = cursor.fetchall()

    if (passExists[0][0] != 0) & (usernameExists[0][0] != 0):
        ret = "True"
    else:
        ret = "user not found"
    cursor.close()
    cnx.close()

    return  ret

def addingQueston(self, questionFromApp, answersFromApp, corect_answerFromApp, typeOfFromApp):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()
    print ("added new question")
    cursor.execute("INSERT INTO questionsTb (question, answers, corect_answer, typeOfQue) VALUES (%s, %s, %s, %s)", (questionFromApp, answersFromApp, corect_answerFromApp, typeOfFromApp))
    cnx.commit()
    cnx.close()

def returnQuestions(self):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()

    questions = {}
    cursor.execute("SELECT COUNT(*) FROM questionsTb")
    numOfRecords = 5
   
    index = 1

    while (index < 4):
        cursor.execute("SELECT * FROM questionsTb WHERE question_Id= '%s'"  %index)
        que = cursor.fetchall()
        questions.update({str(index):que})
        index = index + 1
    print ("questions:")
    print (questions)
    cnx.commit()
    cnx.close()

    return questions

def scoreUser(self,usernameFromApp, passwordFromApp):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()
    passExists = 0
    usernameExists = 0
    ret = ""

    cursor.execute("SELECT score FROM usersTb WHERE user_name='%s'" % usernameFromApp)
    score = cursor.fetchall()

    ret = str(score)

    cursor.close()
    cnx.close()
    print (ret)
    return ret

def addScoreUser(self,usernameFromApp, scor):
    cnx = pymysql.connect(server, user, password, "quizdatabase")
    cursor = cnx.cursor()
    cursor.execute("UPDATE usersTb SET score='%s' WHERE user_name'%s'" % scor  % usernameFromApp)
    score = cursor.fetchall()
    cursor.close()
    cnx.close()
