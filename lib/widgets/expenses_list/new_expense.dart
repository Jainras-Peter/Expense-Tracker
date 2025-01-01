import 'package:flutter/material.dart';
import 'package:expencse_tracker/models/expense.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{

  //var _enterdTitle=' ';

  //void _saveTitleInput(String inputValue){
   // _enterdTitle=inputValue;

  //}

  final _titleController=TextEditingController(); //it stores the content on text field
  final _amountController=TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory=Category.leisure;

  void _presentDatePicker() async{
    final now=DateTime.now();
    final firstDate=DateTime(now.year-1,now.month,now.day);
    
    final pickedDate=await showDatePicker(context: context, 
    initialDate: now,
    firstDate: firstDate, 
    lastDate:now,);
    setState(() {
      _selectedDate=pickedDate;
    });
  }

  void _submitExpenseData(){
    //tryparse convert the string value into double
    //trim is used to remove the unwanted space
    final enteredAmount=double.tryParse(_amountController.text);
    final amountInvalid=enteredAmount==null || enteredAmount<=0;

    if(_titleController.text.trim().isEmpty || amountInvalid || _selectedDate==null){

      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please make sure a valid title,amount and category was entered'),
        actions: [TextButton(onPressed:(){
          Navigator.pop(ctx);
        }, child:const Text('Okay'))],
      ),
      );


      return;


    }
    widget.onAddExpense(Expense(
      title: _titleController.text,
       amount:enteredAmount,
        date: _selectedDate!, 
        category:_selectedCategory,));

        Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose(); //We have to dispose because it takes memory even it is not in use
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const  EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(children: [
         TextField(
          //onChanged:_saveTitleInput,  //onChanged function is used to store the changes on the TextField
          controller: _titleController,
          maxLength: 50,
         // keyboardType: TextInputType.text,
         decoration: const InputDecoration(
          label: Text('Title')
         ),
        ),

        Row(  // without using Expanded it causes Error
          children: [
             Expanded(
               child: TextField(
                controller:_amountController ,
                keyboardType: TextInputType.number,
                decoration: const  InputDecoration(
                  prefixText:'\$',
                  label: Text('Amount')
                ),
               
                           ),
             ),

            const SizedBox(width: 16,),

            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Text(_selectedDate==null ? 'No date Selected' : formatter.format(_selectedDate!)),
                IconButton(onPressed: _presentDatePicker, 
                icon:const Icon(Icons.calendar_month),),

              ],
            ))



          ],
        ),
        
        
         
        const SizedBox(height: 16,),
        Row(
          children: [
            DropdownButton(
              value: _selectedCategory,
              
              items: Category.values.map(
              (category)=>DropdownMenuItem(
                value: category,
                child:Text(category.name.toUpperCase(),)),).toList(),

              onChanged: (value){
                if(value==null){
                  return;

                }
                setState(() {
                  _selectedCategory=value;
                });
                }),
                const Spacer(),

             


            ElevatedButton(onPressed:_submitExpenseData,
            child:const Text("Save Expense") ),

            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const Text('Cancel')),
          ],
        )

      ],),);
  }
}