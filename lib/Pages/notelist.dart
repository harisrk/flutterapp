import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../model/database_helper.dart';
import '../model/notes.dart';
import './notedetails.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class  NoteList  extends StatefulWidget {
  

@override
NoteListState createState() {
   return NoteListState();
  }
  
}
class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> notelist;
  int count = 0;
  
  @override
  Widget build(BuildContext context){
    if(notelist == null){
      notelist = List<Note>();
      updateList();

    }
    return Scaffold(
      appBar: AppBar(
        title:Text('List'),
      ),
      body: getNoteview(),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
        debugPrint('test');
        navigatetohome(Note(' ', 0));
        
      },
      tooltip: 'Add',
      child: Icon(Icons.add),
      ),
      
    );
  }






  ListView getNoteview(){
    TextStyle titlestyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(this.notelist[position].date_created, style: titlestyle,),
            subtitle: Text(this.notelist[position].content.toString(), style:  titlestyle,),
            trailing: GestureDetector(
              child :Icon(Icons.delete, color: Colors.grey),
              onTap: (){
                debugPrint('delete');
                delet(context , notelist[position]);
                debugPrint(notelist[position].date_created);
              },
            ),
            )

        );
      }
      );
  }

void updateList(){
  final Future<Database> dbfuture = databaseHelper.intializeDatabase();
  dbfuture.then((database){
    Future<List<Note>> notelistfuture = databaseHelper.getNotelist();
    notelistfuture.then((notelist){
      setState(() {
        this.notelist = notelist;
        this.count = notelist.length;
      });
    });
  }
  );
}
void navigatetohome(Note note) async {
bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomePage(note);
        })
        );
        if (result == true){
          updateList();
        }
        }
void delet(BuildContext context ,Note note) async {
  int result;
if(note.id != null){
  result = await databaseHelper.deletes(note.id);
}
  if(result != 0){
  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
  updateList();
  }
  else{
    debugPrint('error');
  }
  // if (resu != 0){
  //    AlertDialog(title:Text('Status'),
  //     content: Text('deleted'),
  //     );
  //   }
 
    }

}