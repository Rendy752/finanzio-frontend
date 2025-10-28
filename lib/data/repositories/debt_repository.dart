import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/debt_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';

final debtRepositoryProvider = Provider(
  (ref) => DebtRepository(ref.read(dioProvider)),
);

class DebtRepository {
  final Dio _dio;

  DebtRepository(this._dio);

  // --- CREATE DEBT ---
  Future<DebtModel> createDebt(
    String contactName,
    Decimal amount,
    bool isDebtToUser, {
    String? dueDate,
  }) async {
    final response = await _dio.post(
      '/debts',
      data: {
        'contact_name': contactName,
        'total_amount': amount.toString(),
        'is_debt_to_user': isDebtToUser,
        'due_date': dueDate,
      },
    );
    final apiResponse = APIResponse<DebtModel>.fromJson(
      response.data,
      (json) => DebtModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  // --- READ ALL DEBTS ---
  Future<APIListResponse<DebtModel>> getDebts({String? query}) async {
    final response = await _dio.get('/debts', queryParameters: {'q': query});
    return APIListResponse<DebtModel>.fromJson(
      response.data,
      (json) => DebtModel.fromJson(json as Map<String, dynamic>),
    );
  }

  // --- UPDATE (Record Payment/Settle) ---
  Future<DebtModel> recordPayment(String ledgerId, Decimal amountPaid) async {
    final response = await _dio.put(
      '/debts/$ledgerId',
      data: {'amount_paid': amountPaid.toString()},
    );
    final apiResponse = APIResponse<DebtModel>.fromJson(
      response.data,
      (json) => DebtModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  // --- DELETE DEBT ---
  Future<void> deleteDebt(String ledgerId) async {
    await _dio.delete('/debts/$ledgerId');
  }
}
