import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/widgets/expense_list/newExpense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}



class _ExpensesState extends State<Expenses>{
  List<Expense> dummy = [
    Expense(
      category: Category.leisure, 
      amount: 50, 
      title: 'Television'.toString(), 
      date: DateTime(2026)
      )
  ];
  void adExpense(Expense submitData){
    setState(() {
      dummy.add(submitData);
    });
  }

  void removeExpense(Expense expense){
    final expenseIndex = dummy.indexOf(expense);
    setState(() {
      dummy.remove(expense);
    });
    
    ScaffoldMessenger.of(context).clearSnackBars();
    
    // Store the controller
    final controller = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted!'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              dummy.insert(expenseIndex, expense);
            });
          }
        ),
      )
    );

    // Force dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      controller.close();
    });
  }
  

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Newexpense(adExpense),
    );
  }


  @override

  Widget build(BuildContext context) {
    Widget mainContent = Center(child: Text('No expenses found. Start adding some!'),);
    if(dummy.isNotEmpty){
        mainContent = Column(
        children: [
           Chart(expenses: dummy),
          ExpensesList(dummy,removeExpense),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, 
          icon: Icon(Icons.add)
          ),
        ],
      ),
      
      body: 
      
       mainContent,
      
    );
  }
}