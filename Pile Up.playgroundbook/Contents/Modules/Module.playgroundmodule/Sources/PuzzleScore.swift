
public struct PuzzleScore {
    var score: Int
    var highScore: Int
    let basePoints = 16000
    let movePointsBase = 160000
    let pileHighScore = 0
    
    let goodMessage = "Congratulations!!"
    let unsolvedMessage = "Hmmmm, it seems like a few blocks weren't piled..."
    
    public init(score: Int, highScore: Int) {
        self.score = score
        self.highScore = highScore
    }
    
    // MARK: Messages
    func generateRecordMovesMessage(moves: Int) -> [String] {
        return ["OH YEAH!!!", "You solved the puzzle and set a new record of \(moves) moves!!!"]
    }
    
    func generateMovesMessage(moves: Int) -> String {
        "You solved the puzzle with \(moves) moves!"
    }
    
    // MARK: Access
    func getHighScore() -> Int {
        return highScore
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getPileHighScore() -> Int {
        return pileHighScore
    }
    
    // MARK: Operations
    mutating func add(points: Int) {
        score += points
    }
    
    mutating func reset() {
        score = 0
    }
    
    func isHighScore() -> Bool {
        return highScore == 0 || highScore < score ? true : false
    }
    
    mutating func updateHighScore() {
        if isHighScore() {
            highScore = score
        }
    }
    
    // each pile is worth 1000
    func generatePilePoints(pile: Int) -> Int {
        return pile * basePoints
    }
    
    func generateMovesBonus(moves: Int) -> Int {
        if  moves != 0 {
            return movePointsBase / moves
        } 
        return 0
    }
    
    
}

