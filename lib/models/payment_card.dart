class PaymentCard {
  final int? id;
  final String? cardHolderName;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvv;
  final String? type;

  PaymentCard({
    this.id,
    this.cardHolderName,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.type,
  });
}
