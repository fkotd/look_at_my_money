import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/providers/auth_providers.dart';
import 'package:look_at_my_money/services/data_service.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/models/user.dart';
import 'package:look_at_my_money/models/expense.dart';
import 'package:look_at_my_money/models/user_group_param.dart';

class DataProviders {
  static final dataServiceProvider = Provider((ref) {
    final currentUser = ref.watch(AuthProviders.currentUserProvider);
    return DataService(currentUser.data?.value);
  });

  static final currentUserGroupsProvider = StreamProvider.autoDispose((ref) {
    final dataService = ref.watch(dataServiceProvider);
    return dataService.getCurrentUserGroups();
  });

  static final groupUsersProvider =
      StreamProvider.autoDispose.family<List<User>, Group>((ref, group) {
    final dataService = ref.watch(dataServiceProvider);
    return dataService.getGroupUsers(group);
  });

  static final groupExpensesProvider =
      StreamProvider.autoDispose.family<List<Expense>, Group>((ref, group) {
    final dataService = ref.watch(dataServiceProvider);
    return dataService.getGroupExpenses(group);
  });

  static final userExpensesProvider = StreamProvider.autoDispose
      .family<List<Expense>, UserGroupParam>((ref, params) {
    final dataService = ref.watch(dataServiceProvider);
    return dataService.getUserExpenses(params.group, params.user);
  });

  static final userAllExpensesProvider =
      StreamProvider.autoDispose.family<List<Expense>, User>((ref, user) {
    final dataService = ref.watch(dataServiceProvider);
    return dataService.getUserAllExpenses(user);
  });
}
