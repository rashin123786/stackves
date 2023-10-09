import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String? category;
  @HiveField(1)
  String? description;
  @HiveField(2)
  double? rupees;
  @HiveField(3)
  String? date;
  @HiveField(4)
  double? totalExpense;
  @HiveField(5)
  double? totalIncome;
  @HiveField(6)
  double? savings;
  TransactionModel({
    this.category,
    this.date,
    this.rupees,
    this.description,
    this.totalExpense,
    this.totalIncome,
    this.savings,
  });
}
