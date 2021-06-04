public struct Board {
    var blocks: [Block] = [Block]()
    var goals: [Goal] = [Goal]()
    
    // score points
    var moves: Int = 0
    var movesRecord: Int = 0
    
    public init() {
        newBoard()
    }
    
    mutating func newBoard() {
        blocks = generateBlocks()
        goals = generateGoals()
        blocks.shuffle()
        setBlockIndexes()
    }
    
    func saveCopy() -> Board {
        return self
    }
    
    mutating func newGame() {
        newBoard()
        moves = 0
    }
    
    mutating func endGame() -> Int {
        return moves
    }
    
    func isPuzzleSolved() -> Bool {
        return getPilesInGoals() == 16
    }
    
    // MARK: Score related
    // returns how many blocks are piled in every goal
    func getPilesInGoals() -> Int{
        var pile = 0
        for goal in goals {
            // check if goal and block are the same color
            if blocks[goal.index].color == goal.blockColor && !blocks[goal.index].isDisabled {
                // counts how many blocks are piled
                pile += blocks[goal.index].pile
            }
        }
        return pile
    }
    
    func isMovesRecord() -> Bool {
        return isPuzzleSolved() && (movesRecord == 0 || movesRecord > moves)
    }
    
    mutating func updateMovesRecord() {
        if isMovesRecord() {
            movesRecord = moves
        }
    }
    
    // MARK: Gesture related
    func isNeighbor(block: Block, to index: Int) -> Bool {
        switch block.index {
        // middle blocks
        case 5, 6, 9, 10, 1, 2, 13, 14:
            return abs(index - block.index) == 1 || abs(index - block.index) == 4
        // right column
        case 3, 7, 11, 15:
            return block.index - index == 1 || abs(index - block.index) == 4
        // left column
        case 0, 4, 8, 12:
            return index - block.index == 1 || abs(index - block.index) == 4
        default:
            return false
        }
    }
    
    func isBlockDisabled(at index: Int) -> Bool {
        return blocks[index].isDisabled 
    }
    
    // MARK: Drop Gesture - swap & pile
    func shouldDropBlock(at index: Int, block: Block) -> Bool {
        return index != block.index && !isBlockDisabled(at: index)
    }
    
    func haveSameImages(at index: Int, block: Block) -> Bool {
        return blocks[index].imageName == block.imageName
    }
    
    mutating func disableBlock(at index: Int) {
        blocks[index].isDisabled = true
    }
    
    mutating func pileBlock(at index: Int, from block: Block) {
        blocks[index].pile += block.pile
        moves += 1
    }
    
    mutating func swap(from block: Block, at index: Int) {
        // find block at array
        let firstIndex = findBlockIndex(block: block)
        
        blocks.swapAt(firstIndex, index)
        
        // update indexes
        blocks[firstIndex].index = firstIndex
        blocks[index].index = index
        
        moves += 1
    }
    
    
    // MARK: Access
    func getBlocks() -> [Block] {
        return blocks
    }
    
    func getGoals() -> [Goal] {
        return goals
    }
    
    func getBlock(of index: Int) -> Block {
        return blocks[index]
    }
    
    func findBlockIndex(block: Block) -> Int {
        return blocks.firstIndex(where: { $0.id == block.id }) ?? -1
    }
    
    func getGoalIndex(of index: Int) -> Int {
        return goals.firstIndex(where: { $0.index == index}) ?? -1
    }
    
    func getMoves() -> Int {
        return moves
    }
    
    func getMovesRecord() -> Int {
        return movesRecord
    }
    
    // MARK: initialization methods -> deveriam estar no puzzle game?
    // generates 4 blocks of each color (red, blue, yellow, green)
    func generateBlocks() -> [Block] {
        var blocks = [Block]()
        blocks += generateColor(imageName: "redBlock", blockColor: BlockColor.red, from: 0, until: 4)
        blocks += generateColor(imageName: "blueBlock", blockColor: BlockColor.blue, from: 4, until: 8)
        blocks += generateColor(imageName: "yellowBlock", blockColor: BlockColor.yellow, from: 8, until: 12)
        blocks += generateColor(imageName: "greenBlock", blockColor: BlockColor.green, from: 12, until: 16)
        
        return blocks
    }
    
    // generates 4 blocks with the specified color
    func generateColor(imageName: String, blockColor: BlockColor, from initial: Int, until end: Int) -> [Block] {
        var blocks = [Block]()
        for i in initial..<end {
            let block = Block(id: i, imageName: imageName, index: i, color: blockColor)
            blocks.append(block)
        }
        
        return blocks
    }
    
    // generate 1 goal of each color, at with random indexes
    func generateGoals() -> [Goal] {
        var goals = [Goal]()
        let indexes:[Int] = generateRandomIndexes()
        
        // the id of each goal is the same as the first id of each block color
        goals.append(Goal(id: 0, index: indexes[0], imageName: "redGoal", blockColor: BlockColor.red))
        goals.append(Goal(id: 4, index: indexes[1], imageName: "blueGoal", blockColor: BlockColor.blue))
        goals.append(Goal(id: 8, index: indexes[2], imageName: "yellowGoal", blockColor: BlockColor.yellow))
        goals.append(Goal(id: 12, index: indexes[3], imageName: "greenGoal", blockColor: BlockColor.green))
        
        return goals
    }
    
    // generates 4 numbers from 0..<16 that don't repeat to be the indexes of the goals to be placed at the board game
    func generateRandomIndexes() -> [Int] {
        var indexes = [Int]()
        
        for _ in 0..<4 {
            var index = Int.random(in: 0..<16)
            // to make sure that the indexes won't repeat
            while indexes.contains(index) {
                index = Int.random(in: 0..<16)
            }
            indexes.append(index)
        }
        return indexes
    }
    
    mutating func setBlockIndexes() {
        for i in 0..<blocks.count {
            blocks[i].index = i
        }
    }
    
    // goal view initialization
    func shouldPlaceGoal(index: Int) -> Bool {
        for goal in goals {
            if index == goal.index {
                return true
            }
        }
        return false
    }
}

