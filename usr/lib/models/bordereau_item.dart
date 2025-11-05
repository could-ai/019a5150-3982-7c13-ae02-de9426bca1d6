class BordereauItem {
  final String description;
  final int quantity;
  final double unitPrice;

  BordereauItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get total => quantity * unitPrice;
}
