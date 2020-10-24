import 'package:equatable/equatable.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/models/user.dart';

class UserGroupParam extends Equatable {
  final User user;
  final Group group;

  UserGroupParam({this.user, this.group});

  @override
  List<Object> get props => [user, group];
}
