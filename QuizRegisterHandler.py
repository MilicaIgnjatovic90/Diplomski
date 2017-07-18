from QuizServerClasses import QuizRequestHandler
import DatabaseHandler
import json
from urlparse import urlparse

class QuizRegisterHandler(QuizRequestHandler):
    def __init__(self):
        self.response = 1

    def getResponseToRequest(self, quizRequest):
        body_unicode = quizRequest.body.decode('utf-8')
        body = json.loads(body_unicode)
        passwordFromApp = body['password']
        usernameFromApp = body ['username']
        emailFromApp = body ['email']
        ifExists = DatabaseHandler.checkingIfUserExists(self, usernameFromApp, passwordFromApp, emailFromApp)
        if ifExists == "user not found":
            DatabaseHandler.addingUser(self, usernameFromApp, passwordFromApp, emailFromApp)
            return {"val": "True"}
        else:
            return {"val": ifExists}
