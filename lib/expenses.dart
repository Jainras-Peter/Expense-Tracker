
import 'package:expencse_tracker/widgets/chart/chart.dart';
import 'package:expencse_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expencse_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expencse_tracker/models/expense.dart';

class Expenses extends StatefulWidget{
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}



class _ExpensesState extends State<Expenses>{

  final List<Expense> _registeredExpenses=[
    Expense(title:'Flutter Course',
     amount:19.8,
      date: DateTime.now(),
       category:Category.work),

    Expense(title: 'Cinema',
     amount:23.8, 
     date:DateTime.now(), 
     category:Category.leisure),

  ];
    // => used insted of {}
   //context -> widget meta information(info related on other widgets)
  void _openAddExpense(){
    showModalBottomSheet(context: context, 
    isScrollControlled: true,
    builder:(ctx)=> NewExpense(onAddExpense: _addExpense));

  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });

  }

   void _removeExpense(Expense expense){
    //store the index for undo option
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();//it removes the snakbar message when all the data are deleted

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //show the deleted message and undo option
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(label:'Undo' ,
        onPressed:(){
          setState(() {//insert the deleted expense at the same position
            _registeredExpenses.insert(expenseIndex,expense);
          });
        },),),);

  }




  @override
  Widget build(BuildContext context) {
    Widget mainContent=const Center(child: Text('No expenses list is found'),);

    if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,);
    }

    return  Scaffold(
      appBar: AppBar(
        title:const  Text('Expense Tracker'),
        actions: [
          IconButton(onPressed:_openAddExpense, 
          icon:const Icon(Icons.add))
        ],
      ),

      body:Column(
      children: [

        Chart(expenses: _registeredExpenses),
        Expanded( child:mainContent),
      ],
    ),);
    
  }
}