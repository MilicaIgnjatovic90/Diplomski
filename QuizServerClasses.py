
class QuizRequest:
    def __init__(self, httpRequest, restParams, reqType):
        self.requestType = reqType
        self.arguments = httpRequest.arguments
        self.body = httpRequest.body
        self.restParams = httpRequest.path.strip().strip("/").split("/")
        self.baseParam = self.restParams.pop(0)
        self.hostAddr = httpRequest.protocol + "://" + httpRequest.host + "/"
    
        
class QuizRequestHandler:
    def getResponseToRequest(self, quizRequest):
        return {}
        
class QuizRequestScenario:
    def __init__(self, apiRequestHandler, questionRequestHandler, logRequestHandler, registerRequestHandler, scoreRequestHandler, getQuestionRequestHandler):
        self.apiRequestHandler = apiRequestHandler
        self.questionRequestHandler = questionRequestHandler
        self.logRequestHandler = logRequestHandler
        self.registerRequestHandler = registerRequestHandler
        self.scoreRequestHandler = scoreRequestHandler
        self.getQuestionRequestHandler = getQuestionRequestHandler

    def getApiResponseToRequest(self, quizRequest):
        return self.apiRequestHandler.getResponseToRequest(quizRequest)
        
    def postQuestionsResponseToRequest(self, quizRequest):
        return self.questionRequestHandler.getResponseToRequest(quizRequest)

    def getGetQuestionsResponseToRequest(self, quizRequest):
        print ("2")
        return self.getQuestionRequestHandler.getResponseToRequest(quizRequest)
        
    def getLogResponseToRequest(self, quizRequest):
        return self.logRequestHandler.getResponseToRequest(quizRequest)

    def getRegistreResponseToRequest(self, quizRequest):
        return self.registerRequestHandler.getResponseToRequest(quizRequest)

    def getScoreResponseToRequest(self, quizRequest):
        return self.scoreRequestHandler.getResponseToRequest(quizRequest)

    def postScoreResponseToRequest(self, quizRequest):
        return self.scoreRequestHandler.postResponseToRequest(quizRequest)