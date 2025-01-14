import 'dart:math';

void main() {
  var random = Random();
  int computerChoice = random.nextInt(3);
  var choices = ["rock", "paper", "scissors"];

  int yourChoice = 2;

  print("You Chose: ${choices[yourChoice]}");
  print("Computer Chose: ${choices[computerChoice]}");

  print("\n-----------------------\n");

  if (yourChoice == computerChoice) {
    print("DRAW");
  } else if (yourChoice == 1 && computerChoice == 2) {
    print("COMPUTER WINS");
  } else if (yourChoice == 2 && computerChoice == 0) {
    print("COMPUTER WINS");
  } else if (yourChoice == 0 && computerChoice == 1) {
    print("COMPUTER WINS");
  } else {
    print("YOU WIN");
  }

  print("\n-----------------------\n");
}
