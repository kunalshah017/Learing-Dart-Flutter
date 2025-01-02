void main(){
  int a = 2, b = 3, c = 5;

  if(a > b && a > c){
      print("a is greatest $a");
  }else if (b > a && b > c){
      print("b is greatest $b");
  }else if (c > a && c > b){
      print("c is greatest $c");
  }else if (a == b && a == c){
      print("All three vars are equal");
  }else if(a == b || a == c || b == c){
      print("Two vars are equal");
  }
}
