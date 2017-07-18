from QuizServerClasses import QuizRequestHandler
import DatabaseHandler
import json

class QuestionsRequest(QuizRequestHandler):
    def getResponseToRequest(self, quizRequest):
        body_unicode = quizRequest.body.decode('utf-8')
        body = json.loads(body_unicode)
        questonApp = body['queston']
        print (questonApp)
        answersFromApp = body['answers']
        print (answersFromApp)
        corectAnswerFromApp = body['corectAnswer']
        print (corectAnswerFromApp)
        typeOfQuestionFromApp = body['typeOfQuestion']
        print (typeOfQuestionFromApp)
        DatabaseHandler.addingQueston(self, questonApp, answersFromApp, corectAnswerFromApp,typeOfQuestionFromApp )
        return {"val": "True"}