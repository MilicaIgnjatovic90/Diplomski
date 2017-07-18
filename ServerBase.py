from datetime import date
from tornado import httpserver
import ssl, os
import tornado.escape
import tornado.ioloop
import tornado.web
import DatabaseHandler
import QuizScenario
from QuizServerClasses import *

 
class QuestionsHandler(tornado.web.RequestHandler):
    def get(self, rest):
        req = QuizRequest(self.request, rest, "get")
        response = QuizScenario.scenario.getQuestionsResponseToRequest(req)
        self.write(response)
        
    def post(self, rest):
        req = QuizRequest(self.request, rest, "post")
        response = QuizScenario.scenario.getQuestionsResponseToRequest(req)
        self.write(response)


class GetQuestionsHandler(tornado.web.RequestHandler):
    def get(self, rest):
        req = QuizRequest(self.request, rest, "get")
        response = QuizScenario.scenario.getGetQuestionsResponseToRequest(req)
        self.write(response)

    def post(self, rest):
        req = QuizRequest(self.request, rest, "post")
        print ("1")
        response = QuizScenario.scenario.getGetQuestionsResponseToRequest(req)
        self.write(response)

class ApiHandler(tornado.web.RequestHandler):
    #ideja je da vraca pitanja niz pitanja u random dobijenih od baze random redosledom, radi i na post i na get
    def get(self, rest):
        req = QuizRequest(self.request, rest, "get")
        response = QuizScenario.scenario.getApiResponseToRequest(req)
        self.write(response)
        
    def post(self, rest):
        req = QuizRequest(self.request, rest, "post")
        response = QuizScenario.scenario.getApiResponseToRequest(req)
        self.write(response)
 
class LogHandler(tornado.web.RequestHandler):
    #handler za logovanje
    def get(self, rest):
        req = QuizRequest(self.request, rest, "get")
        response = QuizScenario.scenario.getLogResponseToRequest(req)
        self.write(response)
        
    def post(self, rest):
        req = QuizRequest(self.request, rest, "post")
        response = QuizScenario.scenario.getLogResponseToRequest(req)
        self.write(response)

class RegistreHandler(tornado.web.RequestHandler):
    #handler za registraciju
    def get(self, rest):
        req = QuizRequest(self.request, rest, "get")
        response = QuizScenario.scenario.getRegistreResponseToRequest(req)
        self.write(response)

    def post(self, rest):
        req = QuizRequest(self.request, rest, "post")
        response = QuizScenario.scenario.getRegistreResponseToRequest(req)
        self.write(response)

class ScoreHandler(tornado.web.RequestHandler):
    #handler za registraciju
    def get(self, rest):
        req = QuizRequest(self.request, rest, "get")
        response = QuizScenario.scenario.getScoreResponseToRequest(req)
        self.write(response)

    def post(self, rest):
        req = QuizRequest(self.request, rest, "post")
        response = QuizScenario.scenario.postScoreResponseToRequest(req)
        self.write(response)

application = tornado.web.Application([
    (r"/api/(.*)", ApiHandler),
    (r"/questions/(.*)", QuestionsHandler),
    (r"/getQuestions/(.*)", GetQuestionsHandler),
    (r"/login/(.*)", LogHandler),
    (r"/registre/(.*)", RegistreHandler),
    (r"/score/(.*)", ScoreHandler)
])
 

    
if __name__ == "__main__":
    application.listen(8888)
    DatabaseHandler.runDataBase()
    tornado.ioloop.IOLoop.instance().start()
    
