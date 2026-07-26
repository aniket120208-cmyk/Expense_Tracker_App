import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.index,this.item,{super.key});
  final List<Expense> item;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: 
      
      Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 20 ,
          vertical: 16
        ),
        
        child: 
        
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
        
        SizedBox(height: 15,),
        Row(
          children: [
            Text('\$${item[index].amount.toStringAsFixed(2)}'),
            Spacer(),
            
            Icon(categoryIcon[item[index].category]),
            SizedBox(width: 5,),
            Text(item[index].formatter().toString())
            
          ],
        )
      ],
    ),
      ),
    );
  }
}