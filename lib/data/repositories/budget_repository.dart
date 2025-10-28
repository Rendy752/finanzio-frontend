import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/budget_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';

final budgetRepositoryProvider = Provider(
  (ref) => BudgetRepository(ref.read(dioProvider)),
);

class BudgetRepository {
  final Dio _dio;

  BudgetRepository(this._dio);

  // --- CREATE BUDGET ---
  Future<BudgetModel> createBudget(
    String categoryId,
    Decimal amountLimit,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final response = await _dio.post(
      '/budgets',
      data: {
        'category_id': categoryId,
        'amount_limit': amountLimit.toString(),
        // Kirim tanggal dalam format YYYY-MM-DD
        'start_date': startDate.toIso8601String().split('T').first,
        'end_date': endDate.toIso8601String().split('T').first,
      },
    );
    final apiResponse = APIResponse<BudgetModel>.fromJson(
      response.data,
      (json) => BudgetModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  // --- READ ALL BUDGETS ---
  Future<APIListResponse<BudgetModel>> getBudgets() async {
    final response = await _dio.get('/budgets');
    return APIListResponse<BudgetModel>.fromJson(
      response.data,
      (json) => BudgetModel.fromJson(json as Map<String, dynamic>),
    );
  }

  // --- DELETE BUDGET ---
  Future<void> deleteBudget(String budgetId) async {
    await _dio.delete('/budgets/$budgetId');
  }
}
