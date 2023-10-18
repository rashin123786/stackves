class TransactionModels {
  String? id;
  String? category;
  String? description;
  double? rupees;
  String? date;
  TransactionModels(
      {this.category, this.date, this.description, this.rupees, this.id});
  factory TransactionModels.fromJson(Map<String, dynamic> json) {
    return TransactionModels(
      id: json['id'],
      category: json['category'],
      date: json['date'],
      description: json['description'],
      rupees: json['rupees'],
    );
  }
}
