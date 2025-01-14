void Convert({required String convertTo, required int rupee}) {
  switch (convertTo) {
    case 'USD':
      print("${rupee} INR = ${rupee * 0.012} USD");
      break;
    case 'EUR':
      print("${rupee} INR = ${rupee * 0.012} EUR");
      break;
    case 'GBP':
      print("${rupee} INR = ${rupee * 0.012} GBP");
      break;
    case 'AUD':
      print("${rupee} INR = ${rupee * 0.008} AUD");
      break;
  }
}

void main() {
  Convert(convertTo: 'USD', rupee: 1000);
  Convert(convertTo: 'AUD', rupee: 200);
}
