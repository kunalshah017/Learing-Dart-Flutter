int fact(int n) {
  if (n == 1) return 1;
  else return n * fact(n - 1);
}

void main(){
  print("Factorial of ${5} = ${fact(5)} ");
  print("Factorial of ${3} = ${fact(3)} ");
}