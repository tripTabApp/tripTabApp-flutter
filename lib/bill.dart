class Bill {
  String type;
  double amount;

  Bill(this.type, this.amount);

   static List<String> getPredefinedTypes() {
    return ['Hotel', 'Food', 'Traveling'];
  }
}