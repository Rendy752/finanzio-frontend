import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/report_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportRepositoryProvider = Provider(
  (ref) => ReportRepository(ref.read(dioProvider)),
);

class ReportRepository {
  final Dio _dio;

  ReportRepository(this._dio);

  Future<FinancialSummaryModel> getSummary() async {
    final response = await _dio.get('/finance/summary');
    final apiResponse = APIResponse<FinancialSummaryModel>.fromJson(
      response.data,
      (json) => FinancialSummaryModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }
}

// --- Riverpod Provider for Report State ---

final financialSummaryProvider = FutureProvider<FinancialSummaryModel>((
  ref,
) async {
  return ref.watch(reportRepositoryProvider).getSummary();
});
