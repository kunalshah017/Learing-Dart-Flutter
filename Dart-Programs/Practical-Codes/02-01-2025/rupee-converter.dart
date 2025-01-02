void Convert({required String convertTo, required int rupee}){
  switch (convertTo) {
    case 'USD':
      print("$rupee INR = ${rupee * 0.012} USD");
      break;
    case 'EUR':
      print("${rupee * 0.011} EUR");
      break;
    case 'GBP':
      print("${rupee * 0.009} GBP");
      break;
    case 'AUD':
      print("${rupee * 0.017} AUD");
      break;
  }
}

void main(){
  Convert(convertTo: 'USD',rupee: 1000);
  Convert(convertTo: 'AUD', rupee: 200);
}