import 'package:expense_tracker/widgets/expense_list/expenses.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
class Newexpense extends StatefulWidget{
  const Newexpense(this.adExpense,{super.key});
  final void Function(Expense expense) adExpense;
  @override
  State<Newexpense> createState() {
    return _NewexpenseState();
  }
}


class _NewexpenseState extends State<Newexpense>{
  final saveText = TextEditingController();
  final saveAmount = TextEditingController();
  final firstDate = DateTime(2020);
  final lastDate = DateTime.now();
  DateTime? selectedDate;

  Category selectedItem = Category.leisure;
  
  

  void submitForm(){
    final amount = double.tryParse(saveAmount.text);
    final amountNotValid = amount == null || amount<=0;
    if(saveText.text.trim().isEmpty || amountNotValid || selectedDate == null){
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
             )
          ],
        )
        );
        return ;
    }
    
    widget.adExpense(
      Expense(
        title: saveText.text,
        amount: amount,
        date: selectedDate!,
        category: selectedItem,
      ),
    );
    
    Navigator.pop(context);
    
  }

  void pickdate()async{
    
      var pickeddate =await showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
    
    setState(() {
      selectedDate = pickeddate;
    });
  }
  

  @override
  void dispose() {
    saveText.dispose();
    saveAmount.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsetsGeometry.fromLTRB(16, 50, 16, 16),
    child: 
    Column(
        
        children: [
          TextField(
            controller: saveText,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(children: [
          Expanded(child: 
          TextField(
            controller: saveAmount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '\$',
              label: Text('Amount'),
            ),
          ),
          ),
          SizedBox(width: 10,),
          Expanded(child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(selectedDate == null ? 'no date selected' : format.format(selectedDate!)),
              IconButton(onPressed: pickdate, icon: Icon(Icons.calendar_month)),
            ],
          ),
          )
          ],
          ),
          SizedBox(height: 16,),
          Row(
            children: [
            DropdownButton(
              value: selectedItem,
              items: Category.values.map((category) => DropdownMenuItem(value:category, child: Text(category.name.toUpperCase()))).toList(),
              onChanged: (value){
                if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedItem = value;
                  });
              },
              ),
              Spacer(),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel')),
            ElevatedButton(
              onPressed: submitForm, 
              child: Text('Save Expense'),
              )
          ],
          ),
        ],
        
    )
    
    );
  }
}