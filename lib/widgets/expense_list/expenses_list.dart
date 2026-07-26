import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList(this.data,this.remove,{super.key});
  final void Function(Expense expense) remove;
  final List<Expense> data;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, index) =>Dismissible(
        key: ValueKey(ExpenseItem(index,data)),
        background: Container(
          color: Colors.red.withOpacity(0.75),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onDismissed: (direction){
          remove(data[index]);
          
        },
        
        child: ExpenseItem(index,data),
        
        ),
    )
    );
  }
}