
class Payment {
  final String paymentId;
  final String paymentMethod;
  final String pgPaymentId;
  final String pgStatus;
  final String pgResponseMessage;
  final String pgName;

  Payment({
    required this.paymentId,
    required this.paymentMethod,
    required this.pgPaymentId,
    required this.pgStatus,
    required this.pgResponseMessage,
    required this.pgName,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['paymentId'].toString(),
      paymentMethod: json['paymentMethod'] ?? '',
      pgPaymentId: json['pgPaymentId'] ?? '',
      pgStatus: json['pgStatus'] ?? '',
      pgResponseMessage: json['pgResponseMessage'] ?? '',
      pgName: json['pgName'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'paymentId': paymentId,
      'paymentMethod': paymentMethod,
      'pgPaymentId': pgPaymentId,
      'pgStatus': pgStatus,
      'pgResponseMessage': pgResponseMessage,
      'pgName': pgName,
    };
  }
}