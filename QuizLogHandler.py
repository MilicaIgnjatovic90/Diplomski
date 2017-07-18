from QuizServerClasses import QuizRequestHandler
import DatabaseHandler
import json
from urlparse import urlparse

class QuizLogHandler(QuizRequestHandler):

    def getResponseToRequest(self, quizRequest):
        body_unicode = quizRequest.body.decode('utf-8')
        body = json.loads(body_unicode)
        passwordFromApp = body['password']
        usernameFromApp = body['username']
        ifExists = DatabaseHandler.logingUser(self,usernameFromApp, passwordFromApp)
        if ifExists == "user not found":
            return {"val": ifExists}
        else:
            return {"val": "True"}
