//
//  QuizViewModel.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 28/09/2024.
//

import Foundation
import Combine

class QuizViewModel: ObservableObject {

    // quiz properties
    
    @Published private(set) var questions: [Question] = []
    @Published var score: Int = 0
    @Published var lives: Int = 0
    @Published var currentQuestionIndex: Int = 0

    var highScore: Int {
        get { UserDefaultsHelper.getHighScore()}
    }

    var isNewHighScore: Bool {
        get { quizManager.isNewHighScore }
    }

    var currentQuestionPoints: Int  {
        get { quizManager.currentQuestionPoints }
    }

    
    // technical properties
    
    @Published var answerFeedback: Bool? = nil
    @Published var isQuestionActive: Bool = false
    @Published var isQuizOver: Bool = false
    @Published var imagesLoadedCount: Int = 0
    @Published var selectedIndex: Int = 0
    @Published var messageText: String? = Strings.Messages.creatingQuiz

    private let maxImageLoadingFailures: Int = 10

    private var quizManager: QuizManager = QuizManager()
    private var cancellables = Set<AnyCancellable>()
    private var imageLoadingFailureCount: Int = 0

    
    // public methods
    
    public func createNewQuiz() {
        quizManager.generateNewQuiz() {
            DispatchQueue.main.async {
                self.clearMessageText()
                self.prepareQuiz()
                self.prepareNextQuestion()
            }
        }
    }

    public func resetQuiz() {
        DispatchQueue.main.async {
            self.messageText = Strings.Messages.creatingQuiz
            self.questions = []
            self.isQuizOver = false
        }
    }
    
    public func handleUserAnswer(_ answerIndex: Int) {
        let answerFeedback = self.quizManager.handleUserAnswer(answerIndex)
        DispatchQueue.main.async {
            self.isQuestionActive = false
            self.selectedIndex = answerIndex
            self.answerFeedback = answerFeedback
        }
        imageLoadingFailureCount = 0
    }
    
    
    public func handleQuestionCompleted() {
        let isQuizOver = quizManager.checkIfQuizOver()
        DispatchQueue.main.async {
            self.answerFeedback = nil
            self.isQuizOver = isQuizOver
        }
        if isQuizOver {
            finishQuiz()
        }
        else {
            DispatchQueue.main.async {
                self.prepareNextQuestion()
            }
        }
    }
    
    
    public func handleImageLoadingFailure() {
        imageLoadingFailureCount += 1
        if imageLoadingFailureCount > maxImageLoadingFailures {
            messageText = Strings.Messages.connectionError
        }
        else {
            quizManager.replaceCurrentQuestion() {
                DispatchQueue.main.async {
                    self.prepareNextQuestion()
                }
            }
        }
    }

    
    public func getCorrectAnswerIndex() -> Int {
        return quizManager.getCorrectAnswerIndex()
    }


    
    // --------- private methods ----------
    
    private func prepareQuiz() {
        initQuizDataFromQuizManager()
        setupQuizDataBindings()
    }
    
    
    private func finishQuiz() {
        cancelQuizDataBindings()
    }
    
    
    private func initQuizDataFromQuizManager() {
        self.questions = quizManager.questions
        self.score = quizManager.score
        self.lives = quizManager.lives
        self.currentQuestionIndex = quizManager.currentQuestionIndex
    }
    
    
    private func setupQuizDataBindings() {
        cancellables.removeAll()

        quizManager.$currentQuestionIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentQuestionIndex in
             self?.currentQuestionIndex = currentQuestionIndex
            }
            .store(in: &cancellables)

        quizManager.$score
            .receive(on: DispatchQueue.main)
            .sink { [weak self] score in
             self?.score = score
            }
            .store(in: &cancellables)

        quizManager.$lives
            .receive(on: DispatchQueue.main)
            .sink { [weak self] lives in
             self?.lives = lives
            }
            .store(in: &cancellables)
    }
    
    
    private func cancelQuizDataBindings() {
        cancellables.removeAll()
    }

    
    private func prepareNextQuestion() {
        isQuestionActive = true
        imagesLoadedCount = 0
    }

    private func clearMessageText() {
        messageText = nil
    }
}
