from QuizApiHandler import QuizApiHandler
from QuestionsRequest import QuestionsRequest
from QuizLogHandler import QuizLogHandler
from QuizRegisterHandler import QuizRegisterHandler
from QuizServerClasses import QuizRequestScenario
from QuizScoreHandler import QuizScoreHandler
from QuizGetQuestions import QuizGetQuestions

scenario = QuizRequestScenario(QuizApiHandler(), QuestionsRequest(), QuizLogHandler(), QuizRegisterHandler(), QuizScoreHandler(), QuizGetQuestions() )
