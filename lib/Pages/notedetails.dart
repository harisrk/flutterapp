import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../model/notes.dart';
import '../model/database_helper.dart';
import './notelist.dart';

class HomePage extends StatefulWidget {



  
  final Note note;
HomePage(this.note);
  @override
  HomePageState createState(){
    return HomePageState(this.note);
  }
}
class HomePageState extends State<HomePage> {



 

final format = DateFormat("EEEE,MMMM d,yyyy at h:mm a"); 
 DateTime date;
  NoteList a = NoteList();
  DatabaseHelper  helper = DatabaseHelper();
   Note note;
   HomePageState(this.note);
TextEditingController contentController = TextEditingController();  
  Widget content(){
    return TextFormField(controller: contentController,
    keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Current Unit'),
      onChanged: (value){
      updatecontent();
       },
    );
  }
  dates(){
  return DateTimePickerFormField(format: format,
          inputType: InputType.both,
          editable: false,
          decoration:InputDecoration(labelText: 'Date&Timme',
          hasFloatingPlaceholder:false ),
          onChanged: (dt){
            
            setState(() {
              date = dt;
            });
          updatedate(date);

          },
        
  );
  }
  @override 
  Widget build(BuildContext context){
    return  Scaffold(
        appBar: AppBar(
          title: Text('Add'),
        ),
        body :Container(
      child:
       Form(child:
         ListView(
        children:<Widget>[
          dates(),
          content(),

          
                  // content(),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
              //   // Validate returns true if the form is valid, otherwise false.

              // // If the form is valid, display a snackbar. In the real world,
              // // you'd often call a server or save the information in a database.
              saves();  
              });

              
            },
            child: Text('Submit'),
          ),
        ],
        

      ),)
    ),
    );
  }

  void saves() async {
    movetolastscreen();

    int res;
    if(note.id != null){
  Scaffold.of(context).showSnackBar(SnackBar(content: Text('cant Update')));
    }
    else{
    res = await helper.inserts(note);
    }
    if(res != 0)
    {debugPrint("heklo");
      shows('Status','Saved');
    }
    else{
      shows('Status', 'Error');

    }
    
 }
 void updatedate(DateTime da){
   String daa = da.toString();
   note.date_created = daa;
 } 
 void updatecontent(){
   note.content = double.parse(contentController.text);
 }

 void movetolastscreen(){
   Navigator.pop(context, true);
 }
 shows(String title,String mssg){
   AlertDialog alertDialog = AlertDialog(title:Text(title),
   content:Text(mssg),);
   showDialog(context: context,
   builder:(_) => alertDialog);

 }
}