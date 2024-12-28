void main() {
  int n1 = 10;
  int n2 = 20;
  int n3 = 30;

    if (n1 < n2) {
        if (n2 < n3) {
        print("$n1 is the smallest");
        } else {
        print("$n3 is the smallest");
        }
    } else {
        if (n1 < n3) {
        print("$n2 is the smallest");
        } else {
        print("$n3 is the smallest");
        }
    }
}