import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract interface class ProductsRemoteDatasource {
  Future<List<ProductModel>> fetchAllProducts();
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final SupabaseClient supabaseClient;

  ProductsRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final products = await supabaseClient
        .from('produits')
        .select('*, categorie(*)'); // Fetch products with their categories
      return products.map((product) => ProductModel.fromMap(product)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
