void calculateFactorialNPNR() {
  int num = 5, i = 1, factorial = 1;
  while (i <= num) {
    factorial = factorial * i;
    i++;
  }
  print("Factorial of $num is $factorial");
}

void calculateFactorialWPNR(int num) {
  int i = 1, factorial = 1;
  while (i <= num) {
    factorial = factorial * i;
    i++;
  }
  print("Factorial of $num is $factorial");
}

int calculateFactorialWPWR(int num) {
  int i = 1, factorial = 1;
  while (i <= num) {
    factorial = factorial * i;
    i++;
  }
  return factorial;
}

int calculateFactorialNPWR() {
  int num = 7, i = 1, factorial = 1;
  while (i <= num) {
    factorial = factorial * i;
    i++;
  }
  return factorial;
}

void main() {
  calculateFactorialNPNR();
  calculateFactorialWPNR(5);
  print(calculateFactorialWPWR(5));
  print(calculateFactorialNPWR());
}
