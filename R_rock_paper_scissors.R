rsp_game <- function () {
  play <- c("rock", "scissors", "paper")
  win <- 0
  loss <- 0
  tie <- 0
  
  while (T) {
    user <- tolower (readline("Select your move: rock, paper, scissors, quit: "))
    computer <- sample (play, 1)
    
    if (user == "quit") {
      print (data.frame (Win = win, Loss = loss, Tie = tie))
      break
    } else if (user == computer) {
      print(data.frame(Your = user, Computer = computer, Result = "TIE"))
      tie <- tie + 1
      
    } else if ((user == "rock" & computer == "paper") | 
               (user == "paper" & computer == "scissors") |
               (user == "scissors" & computer == "rock")) {
      
      print(data.frame( Your = user, Computer = computer, Result = "Loss"))
      loss <- loss +1
      
    } else if ((user == "rock" & computer == "scissors") |
               (user == "paper" & computer == "rock") |
               (user == "scissors" & computer == "paper")) {
      print(data.frame( Your = user, Computer = computer, Result = "Win"))
      win <- win + 1
    } else {
      message ("Invalid, try again")
    }
  }
}
