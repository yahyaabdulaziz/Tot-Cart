class Discount {
  final String code;
  final double percentage;

  Discount({
    required this.code,
    required this.percentage,
  });

  double applyDiscount(double amount) {
    return amount * (1 - percentage / 100);
  }
}
