#Sudoko Board
sudoko_board = [
    [7,8,0,4,0,0,1,2,0],
    [6,0,0,0,7,5,0,0,9],
    [0,0,0,6,0,1,0,7,8],
    [0,0,7,0,4,0,2,6,0],
    [0,0,1,0,5,0,9,3,0],
    [9,0,4,0,6,0,0,0,5],
    [0,7,0,3,0,0,0,1,2],
    [1,2,0,0,0,7,4,0,0],
    [0,4,9,2,0,6,0,0,7]
]

def board_print(board):
    x = 0
    while x <= 8:
        if x % 3 == 0 and x != 0:
            print("- - - - - - - - - - -")
        for j in enumerate(board[x]):
            if j[0] % 3 == 0 and j[0] != 0:
                    print("|", end = " ")
                
            if j[0] == 8:
                    print(j[1])
            else:
                print(j[1], end = " ")
        x = x+1

def empty_finder(board):

    y = 0
    while y <= 8:
        try:
            index = board[y].index(0)
            if isinstance(index, int):
                return (y, index)
        except ValueError:
            y = y + 1
    return None

def is_valid(board, loc, num):
    #checking rows
    for i in enumerate(board[loc[0]]):
        if i[1] == num and loc[1] != i[0]:
            return False
    
    
    #checking columns
    for i in enumerate(board):
        list = i[1]
        try:
            num_check = list.index(num) 
            if isinstance(num_check, int) and num_check == loc[1] and i[0] != loc[0]:
                return False
        except ValueError:
            continue
    
    #checking 3x3 box
    x_pos = loc[1] // 3
    y_pos = loc[0] // 3

    for i in range(y_pos*3, y_pos*3 + 3):
        for j in range(x_pos*3, x_pos*3 +3):
            if board[i][j] == num and i != loc[0] and j != loc[1]:
                return False
    
    return True

def board_solver(board):
    #base case of recursion
    pos = empty_finder(board)
    if not pos:
        return True
    else:
        y_loc, x_loc = pos
    #Recursive Case, solving board one step at a time using a backtracking algorithm 
    for i in range(1,10):
        if is_valid(board, (y_loc, x_loc), i):
            board[y_loc][x_loc] = i
        
            if board_solver(board):
                return True
        
            board[y_loc][x_loc] = 0
    return False
      
