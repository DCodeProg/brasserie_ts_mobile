import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/category_model.dart';

abstract interface class CategoriesRemoteDatasource {
  Future<List<CategoryModel>> fetchAllCategories();
}

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  final SupabaseClient supabaseClient;

  CategoriesRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      final categories = await supabaseClient.from('categories').select();
      return categories
          .map((categorie) => CategoryModel.fromMap(categorie))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
