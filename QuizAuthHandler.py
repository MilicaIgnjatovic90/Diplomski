from QuizServerClasses import QuizRequestHandler

class QuizQestionHandler(QuizRequestHandler):
    def getResponseToRequest(self, quizRequest):
        apiAddr = self.createAPIEndpoint(quizRequest.hostAddr)
        response = {"access_token" : "KBAgH3pY7Nh7UUyaWplWCo2BH6i0FyfRLxuG658R8CfKbQs1Dsua_5uO3-WKq9qq",
                    "endpoints" : {
                            "api" : apiAddr,
                            "endUser" : apiAddr,
                            "logging" : apiAddr},
                    "expires_in" : 41102,
                    "scope" : "read trust write",
                    "token_type" : "bearer"}
        print(quizRequest.baseParam + ", "+ ".".join(quizRequest.restParams) + " & " + str(quizRequest.arguments))
        return response
        
    def createAPIEndpoint(self, hostAddr):
        return hostAddr + "api/v2"