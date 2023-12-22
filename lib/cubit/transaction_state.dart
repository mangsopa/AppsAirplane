part of 'transaction_cubit.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionFailed extends TransactionState {
  final String error;

  TransactionFailed(this.error);

  @override
  List<Object> get props => [error];
}
