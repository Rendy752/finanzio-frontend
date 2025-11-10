import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/transaction_model.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';

final transactionRepositoryProvider = Provider(
  (ref) => TransactionRepository(ref.read(dioProvider)),
);

class TransactionRepository {
  final Dio _dio;

  TransactionRepository(this._dio);

  // --- CREATE TRANSACTION ---
  Future<TransactionModel> createTransaction(
    String walletId,
    String categoryId,
    TransactionType type,
    Decimal amount,
    String description, {
    // ARGUMEN BARU: Tanggal Transaksi
    DateTime? transactionDate,
  }) async {
    // Buat body request dasar
    final Map<String, dynamic> data = {
      'wallet_id': walletId,
      'category_id': categoryId,
      'transaction_type': type.name.toUpperCase(),
      'amount': amount.toString(),
      'description': description,
    };

    // Tambahkan tanggal hanya jika disediakan
    if (transactionDate != null) {
      // Kirim dalam format ISO8601 string, yang diharapkan FastAPI/Pydantic.
      data['transaction_date'] = transactionDate.toIso8601String();
    }

    final response = await _dio.post('/transactions/', data: data);
    final apiResponse = APIResponse<TransactionModel>.fromJson(
      response.data,
      (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  // --- READ ALL TRANSACTIONS/ ---
  Future<APIListResponse<TransactionModel>> getTransactions({
    int limit = 20,
    int offset = 0,
    String? query,
  }) async {
    final response = await _dio.get(
      '/transactions/',
      queryParameters: {'limit': limit, 'offset': offset, 'q': query},
    );
    return APIListResponse<TransactionModel>.fromJson(
      response.data,
      (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
    );
  }

  // --- DELETE TRANSACTION ---
  Future<void> deleteTransaction(String transactionId) async {
    await _dio.delete('/transactions/$transactionId');
  }

  // --- ENDPOINT KHUSUS: TRANSFER DANA ---
  Future<List<TransactionModel>> performTransfer(
    String sourceId,
    String targetId,
    Decimal amount,
    String description, {
    // TRANSFER JUGA MUNGKIN MEMERLUKAN TANGGAL
    DateTime? transactionDate,
  }) async {
    final Map<String, dynamic> data = {
      'source_wallet_id': sourceId,
      'target_wallet_id': targetId,
      'amount': amount.toString(),
      'description': description,
    };

    if (transactionDate != null) {
      data['transaction_date'] = transactionDate.toIso8601String();
    }

    final response = await _dio.post('/finance/transfer/', data: data);

    // Endpoint transfer mengembalikan List<TransactionResponse>
    final apiResponse = APIResponse<List<dynamic>>.fromJson(
      response.data,
      (json) => json as List<dynamic>,
    );

    return apiResponse.data
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
