void main() {
  int num1 = 10;
  print(num1.runtimeType);

  var i = 10, num;
  print(i);
  print(i.runtimeType);
  i = 25;
  num = 50;
  print("After changing the value ${i}");
//   i="Good Morning";  // i was initialized with int value, hence cannot be assigned str. ERROR
  print(num.runtimeType);
  num = "DART Programming";
  print(num);
  print(num.runtimeType);

  var x = "SYBCA";
  print(x);

  Object obj = 10;
  print(obj.runtimeType);
  obj = true;
  print(obj.runtimeType);
  obj = "Good Morning";
  // obj.subString(2); // type checking during compile time
  print(obj.runtimeType);
  String str = obj as String;
  print(str.substring(2));

  dynamic status = true;
  print(status.runtimeType);
  status = 35.67;
  status = "DART";
  print(status);
//   status.subString(2);
  // status.iamSYBCAmethod(); // does not have type checking -- runtime error
}
