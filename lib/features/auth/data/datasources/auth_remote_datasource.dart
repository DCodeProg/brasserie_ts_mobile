import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithPassword({
    required String email,
    required String password,
  });
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required DateTime dateNaissance,
  });
  Future<void> signOut();
  Future<void> deleteAccount();
}

class AuthRemoteDatasourceImplt implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImplt({required this.supabaseClient});

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final currentSession = supabaseClient.auth.currentSession;
      if (currentSession != null) {
        final userData =
            await supabaseClient
                .from('utilisateurs')
                .select()
                .eq('uid', currentSession.user.id)
                .single();

        return UserModel.fromMap({
          'uid': currentSession.user.id,
          'email': currentSession.user.email,
          'nom': userData['nom'],
          'prenom': userData['prenom'],
          'dateNaissance': userData['date_naissance'],
          'createdAt': currentSession.user.createdAt,
        });
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user == null) {
        throw ServerException(message: "User is null!");
      }
      final userData =
          await supabaseClient
              .from('utilisateurs')
              .select()
              .eq('uid', res.user!.id)
              .single();

      return UserModel.fromMap({
        'uid': res.user!.id,
        'email': res.user!.email,
        'nom': userData['nom'],
        'prenom': userData['prenom'],
        'dateNaissance': userData['date_naissance'],
        'createdAt': res.user!.createdAt,
      });
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required DateTime dateNaissance,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      supabaseClient.auth.updateUser(UserAttributes());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
