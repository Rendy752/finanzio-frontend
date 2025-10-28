import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider(
  (ref) => CategoryRepository(ref.read(dioProvider)),
);

class CategoryRepository {
  final Dio _dio;

  CategoryRepository(this._dio);

  Future<CategoryModel> createCategory(
    String name,
    TransactionType type,
  ) async {
    final response = await _dio.post(
      '/categories',
      data: {'category_name': name, 'type': type.name.toUpperCase()},
    );
    final apiResponse = APIResponse<CategoryModel>.fromJson(
      response.data,
      (json) => CategoryModel.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  Future<APIListResponse<CategoryModel>> getCategories({String? query}) async {
    final response = await _dio.get(
      '/categories',
      queryParameters: {'q': query},
    );
    return APIListResponse<CategoryModel>.fromJson(
      response.data,
      (json) => CategoryModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<void> deleteCategory(String categoryId) async {
    await _dio.delete('/categories/$categoryId');
  }
}

final categoryListProvider = FutureProvider<APIListResponse<CategoryModel>>((
  ref,
) async {
  return ref.watch(categoryRepositoryProvider).getCategories();
});
