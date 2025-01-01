import 'package:flutter/material.dart';
import 'package:expencse_tracker/models/expense.dart';
import 'package:expencse_tracker/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,

  });
  final void Function(Expense expense) onRemoveExpense; //returns nothing but takes a expense

  final List<Expense>expenses;

  @override                         //=> used insted of {}
  Widget build(BuildContext context) { //item count return the final expenses length
    return ListView.builder(itemCount:expenses.length,

    itemBuilder: (crt,index)=>Dismissible   //used to swipe(delete) the data
    (key:ValueKey(expenses[index]),

    background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
    //Why we call Theme because we cant override the contents in theme
    margin: EdgeInsets.symmetric(horizontal:Theme.of(context).cardTheme.margin!.horizontal),),


    onDismissed:(direction){  //direction is used to swipe on wich directions 
      onRemoveExpense(expenses[index]);
    } ,
    child:ExpensesItem(expenses[index])));
  }
}