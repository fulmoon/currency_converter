class CurrencyList{
  final String countryCode;
  final double conversionRate;

  CurrencyList({
    required this.countryCode, 
    required this.conversionRate
  });
  
  factory CurrencyList.fromJson(Map<String, dynamic> json){
    return CurrencyList(
        countryCode: json['countryCode'] as String,
        conversionRate: json['conversionRate'] as double,
    );
  }
}