void main() {
  int cuponCode = 300;
  switch (cuponCode) {
    case 100:
      print('Free');
      break;
    case 200:
      print('Discount');
      break;
    case 300:
      print('Special');
      break;
    default:
      print('Invalid');
  }
}
