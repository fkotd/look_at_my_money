import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/services/auth_service.dart';

class AuthProviders {
  static final authServiceProvider = Provider((ref) => AuthService());

  static final currentUserProvider = StreamProvider((ref) {
    final authService = ref.watch(authServiceProvider);
    return authService.currentUserStream;
  });
}
