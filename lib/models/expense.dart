import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //used to formate date ,year month date
const  uuid=  Uuid();
//enum is used to create a custom type

enum Category { food, travel ,leisure, work}

const categoryIcons={
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,

};

class Expense{
                                 //inside() is called positional arguments
   Expense({required this.title, //inside {} is called named parameters or arguments
                                  
  required this.amount,
  required this.date,
  required this.category,
          }) : id=uuid.v4(); //it generates the unique id to acces and delete
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }


}

//chart
class ExpenseBucket{
  const ExpenseBucket({
  required this.category,
  required this.expenses,});
   //additional constructor 
  ExpenseBucket.forCategory(List<Expense>allExpenses,this.category):
   expenses=allExpenses.where((expense)=>expense.category==category).toList();
   //where is used to filter from the list

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }
    return sum;
  }
    
  

}