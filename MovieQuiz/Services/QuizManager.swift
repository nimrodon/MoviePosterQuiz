//
//  QuizManager.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 04/10/2024.
//

import Foundation

class QuizManager {
    
    @Published private(set) var questions: [Question] = []
    @Published private(set) var score: Int = 0
    @Published private(set) var lives: Int = 3
    @Published private(set) var currentQuestionIndex: Int = 0
    
    private(set) var isNewHighScore: Bool = false
    private(set) var currentQuestionPoints: Int = 0

    private var showQuestionTime: Date = Date.now
    private var bonusPointsPerSecond: Double = 0
    private var quizGenerator: QuizGenerator = QuizGenerator()

    
    init() {
        initScoringParameters()
    }

    public func generateNewQuiz(completion: @escaping () -> Void) {
        quizGenerator.generateQuestions(numOfQuestions: QuizConstants.numOfQuestions, completion: { questions in
            if let questions = questions {
                self.initQuiz(questions: questions)
                completion()
            }
        })
    }

    
    public func replaceCurrentQuestion(completion: @escaping () -> Void) {
        quizGenerator.generateQuestions(numOfQuestions: 1, completion: { questions in
            if let questions = questions {
                self.questions[self.currentQuestionIndex] = questions[0]
                completion()
            }
        })
    }

    
    public func handleUserAnswer(_ answerIndex: Int) -> Bool {
        let isCorrect = answerIndex == questions[currentQuestionIndex].correctAnswerIndex
        if (isCorrect) {
            currentQuestionPoints = calcQuestionPoints()
            score += currentQuestionPoints
        }
        else {
            lives -= 1
        }
        return isCorrect
    }

    
    public func checkIfQuizOver() -> Bool {
        if lives <= 0 || currentQuestionIndex >= questions.count - 1 {
            handleQuizOver()
            return true
        }
        else {
            currentQuestionIndex += 1
            prepareNextQuestion()
            return false
        }
    }
    
    
    public func getCorrectAnswerIndex() -> Int {
        return questions[currentQuestionIndex].correctAnswerIndex
    }

    
    // ----- private methods -----
    
    private func initQuiz(questions: [Question]) {

        currentQuestionIndex = 0
        score = 0
        lives = QuizConstants.maxLives
        self.questions = questions
        currentQuestionPoints = 0
        isNewHighScore = false

        prepareNextQuestion()
    }

    
    private func prepareNextQuestion() {
        showQuestionTime = Date.now
    }
    
    
    private func calcQuestionPoints() -> Int {
        let answerTime = Date.now.timeIntervalSince(showQuestionTime)
        let pointsToDeduct = Int((min(Double(answerTime), Double(QuizConstants.speedBonusSeconds)) * bonusPointsPerSecond).rounded())
        let points = QuizConstants.baseAnswerPoints + QuizConstants.maxSpeedBonusPoints - pointsToDeduct
        return points
    }


    private func handleQuizOver() {
        questions = []
        LeaderboardService.reportScore(score: score)
        processHighScore()
    }
    
    
    private func processHighScore() {
        let highScore = UserDefaultsHelper.getHighScore()
        if score > highScore {
            UserDefaultsHelper.setHighScore(score: score)
            isNewHighScore = true
        }
    }
    

    private func initScoringParameters() {
        bonusPointsPerSecond  = Double(QuizConstants.maxSpeedBonusPoints) / Double(QuizConstants.speedBonusSeconds)
    }
}


