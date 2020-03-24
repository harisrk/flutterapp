import 'dart:ffi';
import 'dart:io';
import 'dart:async';
class Note {
  int _id;
  // String _title;
  double _content;
  String _date_created;
  // DateTime date_last_edited;
  // Double res;

  Note(this._date_created,this._content);

  Note.withid(this._id,this._date_created,this._content);

int get id => _id;
double get content => _content;
String get date_created => _date_created;

set  content(double newcontent){
  this._content= newcontent;
}
set date_created(String newdate_created){
  this._date_created = newdate_created;
}




// convenience method to create a Map from this Word object
    Map<String, dynamic> toMap() {
    var map = Map<String, dynamic> ();
    if (id !=  null) {
      map['id'] = _id;
    }
    map['date_created'] = _date_created;
    map['content'] = _content;
    
    
    return map;
  }


  Note.fromMap(Map<String,dynamic> map) {
    this._id = map['id'];
    this._date_created = map['date_created'];
    this._content = map['content'];
  }

  
}
