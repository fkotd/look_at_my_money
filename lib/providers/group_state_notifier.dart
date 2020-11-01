import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/services/data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupStateNotifier extends StateNotifier<AsyncValue<String>> {
  GroupStateNotifier() : super(const AsyncValue.loading()) {
    _getLastVisitedGroup();
  }

  Future<void> _getLastVisitedGroup() async {
    state = await AsyncValue.guard(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('lastVisitedGroup');
    });
  }

  void _setLastVisitedGroup(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastVisitedGroup', groupId);
  }

  Future<void> changeGroup(String groupId) async {
    state = AsyncValue.data(groupId);
    await _setLastVisitedGroup(groupId);
  }
}
