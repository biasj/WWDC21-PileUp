import SwiftUI

public class PuzzleGame: ObservableObject {
    @Published var board: Board = Board()
    var freshBoard: Board 
    var isPlaying: Bool = true
    var isMovesRecordCopy = false
    
    @Published var score: PuzzleScore = PuzzleScore(score: 0, highScore: 0)
    
    public init() {
        self.board = Board()
        self.freshBoard = Board()
        freshBoard = board.saveCopy()
    }
    
    // MARK: Game over
    func newGame() {
        board.newGame()
        // saves a copy of the board
        freshBoard = board.saveCopy()
        score.reset()
        isPlaying = true
    }
    
    func endGame() {
        isMovesRecordCopy = board.isMovesRecord()
        board.updateMovesRecord()
        updateScore()
        print("moves: \(board.moves)")
        print("score: \(score.getScore())")
        isPlaying = false
    }
    
    func getScore() -> Int {
        return score.getScore()
    }
    
    func updateScore() {
        var piles = board.getPilesInGoals()
        var pilePoints = score.generatePilePoints(pile: piles)
        var movePoints = score.generateMovesBonus(moves: board.moves)
        score.add(points: pilePoints+movePoints)
        checkHighScore()
    }
    
    func resetGame() {
        let movesRecord = board.movesRecord
        board = freshBoard
        board.movesRecord = movesRecord
        isPlaying = true
        score.reset()
    }
    
    func isSolved() -> Bool {
        return board.isPuzzleSolved()
    }
    
    // MARK: Score related
    func add(points: Int) {
        score.add(points: points)
    }
    
    func getHighScore() -> Int {
        return score.getHighScore()
    }
    
    func checkHighScore() {
        score.updateHighScore()
    }
    
    func isHighScore() -> Bool {
        return score.isHighScore()
    }
    
    func isMovesRecord() -> Bool {
        return board.isMovesRecord()
    }
    
    // score messages
    func getHighScoreMessage(moves: Int) -> [String] {
        return score.generateRecordMovesMessage(moves: moves)
    }
    
    func getHighScoreMovesMessage(moves: Int) -> String {
        return score.generateMovesMessage(moves: moves)
    }
    
    func getPuzzleUnsolvedMessage() -> String {
        return score.unsolvedMessage
    }
    
    // MARK: Gesture related
    func shouldDropBlock(at index: Int, block: Block) -> Bool {
        return board.shouldDropBlock(at: index, block: block)
    }
    
    func isBlockDisabled(at index: Int) -> Bool {
        return board.isBlockDisabled(at: index)
    }
    
    func isNeighbor(block: Block, index: Int) -> Bool {
        return board.isNeighbor(block: block, to: index)
    }
    
    // MARK: Drop gesture - Swap & Pile
    func haveSameImages(at index: Int, block: Block) -> Bool {
        return board.haveSameImages(at: index, block: block)
    }
    
    func disableBlock(at index: Int) {
        board.disableBlock(at: index)
    }
    
    func pileBlock(at index: Int, from block: Block) {
        board.pileBlock(at: index, from: block)
    }
    
    func swapBlocks(from block: Block, to index: Int) {
        board.swap(from: block, at: index)
    }
    
    // MARK: Model Access
    func getGoals() -> [Goal] {
        return board.getGoals()
    }
    
    func getBlocks() -> [Block] {
        return board.getBlocks()
    }
    
    func getBlock(of index: Int) -> Block {
        return board.getBlock(of: index)
    }
    
    func getGoalIndex(index: Int) -> Int {
        return board.getGoalIndex(of: index)
    }
    
    func shouldPlaceGoal(index: Int) -> Bool {
        return board.shouldPlaceGoal(index: index)
    }
    
    func getMovesRecord() -> Int {
        return board.getMovesRecord()
    }
    
    func getMoves() -> Int {
        return board.getMoves()
    }
    
}

