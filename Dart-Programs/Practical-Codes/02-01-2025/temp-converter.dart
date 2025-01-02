void FarenheitToCelcius({ double farenheit = 1}){
    double celcius = (farenheit * -17.22);
    
    print("$farenheit F = ${celcius.toStringAsFixed(2)} C");
}

void CelciusToFarenheit({double celcius = 1}){
    double farenheit = (celcius / 17.22);

    print("$celcius C = ${farenheit.toStringAsFixed(2)} F");
}

void main(){
    FarenheitToCelcius(farenheit: 23.5);
    CelciusToFarenheit(celcius: 23.5);
}