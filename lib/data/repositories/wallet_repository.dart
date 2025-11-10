import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/wallet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletRepositoryProvider = Provider(
  (ref) => WalletRepository(ref.read(dioProvider)),
);

class WalletRepository {
  final Dio _dio;

  WalletRepository(this._dio);

  Future<WalletModel> createWallet(
    String name,
    String currency,
    String initialBalance,
  ) async {
    final response = await _dio.post(
      '/wallets/',
      data: {
        'wallet_name': name,
        'currency': currency,
        'initial_balance': initialBalance,
      },
    );
    final apiResponse = APIResponse<WalletModel>.fromJson(
      response.data,
      (json) => WalletModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  Future<APIListResponse<WalletModel>> getWallets({
    String? query,
    int limit = 10,
    int offset = 0,
  }) async {
    final response = await _dio.get(
      '/wallets/',
      queryParameters: {'q': query, 'limit': limit, 'offset': offset},
    );
    return APIListResponse<WalletModel>.fromJson(
      response.data,
      (json) => WalletModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<WalletModel> updateWallet(
    String walletId,
    String name,
    String currency,
  ) async {
    final response = await _dio.put(
      '/wallets/$walletId',
      data: {'wallet_name': name, 'currency': currency},
    );
    final apiResponse = APIResponse<WalletModel>.fromJson(
      response.data,
      (json) => WalletModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  // --- DELETE ---
  Future<void> deleteWallet(String walletId) async {
    await _dio.delete('/wallets/$walletId');
  }
}

final walletListProvider =
    StateNotifierProvider<
      WalletListNotifier,
      AsyncValue<APIListResponse<WalletModel>>
    >((ref) {
      return WalletListNotifier(ref.watch(walletRepositoryProvider));
    });

class WalletListNotifier
    extends StateNotifier<AsyncValue<APIListResponse<WalletModel>>> {
  final WalletRepository _repository;

  WalletListNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchWallets();
  }

  Future<void> fetchWallets({String? query}) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getWallets(query: query);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addWallet(
    String name,
    String currency,
    String initialBalance,
  ) async {
    try {
      await _repository.createWallet(name, currency, initialBalance);
      await fetchWallets();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeWallet(String walletId) async {
    try {
      await _repository.deleteWallet(walletId);
      await fetchWallets();
    } catch (e) {
      rethrow;
    }
  }
}
