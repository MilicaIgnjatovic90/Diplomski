from QuizServerClasses import QuizRequestHandler

class QuizApiHandler(QuizRequestHandler):
    
    def __init__(self): 
        self.questions = []
        
    def getResponseToRequest(self, pltRequest):
#mora postojati komunikacija ove klase sa klasom quizLogHandler da bi znalo da li sme da mu se dozvoli da generise pitanja ili ne 
        return self.questions
    
    #potrebna logika koja dohvata broj pitanja u bazi, zastim random dohvata 20 pitanja i salje ih aplikaciji
        
   