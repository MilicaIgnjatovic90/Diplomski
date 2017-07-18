from QuizServerClasses import QuizRequestHandler
import DatabaseHandler
import json
from urlparse import urlparse

class QuizGetQuestions(QuizRequestHandler):
    def getResponseToRequest(self, quizRequest):
        print ("call:")
        q = DatabaseHandler.returnQuestions(self)
        return {"val": q}