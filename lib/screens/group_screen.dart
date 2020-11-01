import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/expense.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/widgets/expense_list.dart';
import 'package:look_at_my_money/widgets/sum_list.dart';
import 'package:look_at_my_money/widgets/welcome_view.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen({Key key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final valueController = TextEditingController();
  final hintController = TextEditingController();

  final duration = 200;
  final double maxSlide = 300;
  final minSwipeVelocity = 700;

  double delta = 0;
  double targetDX = 0;
  double currentDX = 0;
  bool isOpen = false;

  void _toogleIsOpen() {
    print('toggling !');
    this.isOpen = !this.isOpen;
  }

  void _onHorizontalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      double dx = details.globalPosition.dx.floorToDouble();

      this.targetDX = dx > this.maxSlide ? this.maxSlide : dx;
      this.currentDX = dx;
      this.delta = details.delta.dx.floorToDouble();
    });
  }

  void _onVerticalDragUpdateHandler(DragUpdateDetails details) {}

  void _onDragEnd(DragEndDetails details, BuildContext context) {
    double velocity = details.velocity.pixelsPerSecond.dx.abs().floorToDouble();

    setState(() {
      if (velocity > this.minSwipeVelocity) {
        if (this.delta > 0) {
          this.targetDX = maxSlide;
        } else {
          this.targetDX = 0;
        }
      } else {
        final screenWidth = MediaQuery.of(context).size.width;
        if (this.currentDX > screenWidth / 2) {
          this.targetDX = maxSlide;
        } else {
          this.targetDX = 0;
        }
      }
      _toogleIsOpen();
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {}

  void _createExpenses(BuildContext context) {
    final dataService = context.read(DataProviders.dataServiceProvider);
    final group = context.read(DataProviders.groupProvider);

    Expense expense = Expense(
      groupId: group.data.value.id,
      value: double.parse(valueController.text),
      hint: hintController.text,
      date: new DateTime.now(),
    );

    dataService.createExpenses(expense);
  }

  Future<void> _showForm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Show your money doggy'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expenses',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: hintController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'For what ?',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Throw'),
              onPressed: () {
                _createExpenses(context);
                valueController.text = '';
                hintController.text = '';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final topOffset = MediaQuery.of(context).padding.top;
    final cornerRadius = Radius.circular(10.0);

    return AnimatedContainer(
      padding: EdgeInsets.only(
        top: topOffset,
      ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 25.0,
            spreadRadius: 5.0,
            offset: Offset(15.0, 15.0),
          ),
        ],
      ),
      transform: Matrix4.translationValues(targetDX, 0, 0),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOut,
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdateHandler,
        onVerticalDragUpdate: null,
        onHorizontalDragEnd: (details) => _onDragEnd(details, context),
        onVerticalDragEnd: null,
        behavior: HitTestBehavior.translucent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: cornerRadius,
          ),
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Consumer(
              builder: (context, watch, child) {
                final group = watch(DataProviders.groupProvider);
                // TODO: when the user has no group ?
                return group.when(
                  loading: () => Container(width: 0, height: 0),
                  error: (error, stack) => Container(width: 0, height: 0),
                  data: (group) {
                    if (group == null) {
                      return WelcomeView();
                    }
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          leading: IconButton(
                            icon: Icon(Icons.menu),
                            color: Theme.of(context).primaryColorLight,
                            onPressed: () {
                              setState(
                                () {
                                  this.targetDX =
                                      this.isOpen ? 0 : this.maxSlide;
                                  _toogleIsOpen();
                                },
                              );
                            },
                          ),
                          title: Text(
                            group.name,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        SumList(group: group),
                        ExpenseList(group: group),
                      ],
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showForm();
              },
              child: Icon(Icons.attach_money),
            ),
          ),
        ),
      ),
    );
  }
}
