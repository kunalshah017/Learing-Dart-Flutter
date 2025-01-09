import 'dart:math';

void main() {
  var random = Random();
  int computerChoice = random.nextInt(3);  
  var choices = ["rock", "paper", "scissors"];
  
  int yourChoice = 2; 
  
  print("Computer Chose: ${choices[computerChoice]}");
  print("You Chose: ${choices[yourChoice]}");

  print("\n-----------------------\n");

  if (yourChoice == computerChoice) {
    print("DRAW");
  } else if (yourChoice == 1 && computerChoice == 2) {
    print("YOU WIN");
  } else if (yourChoice == 2 && computerChoice == 0) {
    print("YOU WIN");
  } else if (yourChoice == 0 && computerChoice == 1) {
    print("YOU WIN");
  } else {
    print("COMPUTER WINS");
  }

  print("\n-----------------------\n");
}