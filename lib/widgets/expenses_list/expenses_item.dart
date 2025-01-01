
import 'package:expencse_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget{
  const  ExpensesItem(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    //card() is used for styling purpose it gives a look like card
    //
    return  Card(

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
    
            style: Theme.of(context).textTheme.titleLarge,),
            //if u want to change the theme, use copywith (titleLarge.copyWith()) and change.
            //Because we cant overide the theme
            const SizedBox(height: 4,),


            Row(children: [
              //'\$' is escape because $ is used in flutter, inside {} is taken as a single value so it displays the value
              Text('\$${expense.amount.toStringAsFixed(2)}',),
              //23.454656=>23.45

              const Spacer(),

              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8,),
                  Text(expense.formattedDate)
                ],
              ),

            ],)
          ],
        ),
      ),);
  }
}