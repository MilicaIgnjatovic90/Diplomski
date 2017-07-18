from QuizServerClasses import QuizRequestHandler
import DatabaseHandler
import json
from urllib.parse import urljoin

class QuestionsRequest(QuizRequestHandler):
    def getResponseToRequest(self, quizRequest):
        body_unicode = quizRequest.body.decode('utf-8')
        body = json.loads(body_unicode)
        questonApp = body['queston']
        answersFromApp = body['answers']
        corectAnswerFromApp = body['corectAnswer']
        typeOfQuestionFromApp = body['typeOfQuestion']
        DatabaseHandler.addingQueston(self, questonApp, answersFromApp, corectAnswerFromApp,typeOfQuestionFromApp )
        return {"val": "True"}