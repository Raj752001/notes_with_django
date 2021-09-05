import 'package:flutter/material.dart';
import 'package:noteswithdjango/create.dart';
import 'package:noteswithdjango/update.dart';
import 'django.dart';
import 'note.dart';

class ListNotes extends StatefulWidget {
    const ListNotes({Key? key}) : super(key: key);

    @override
    _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
    List<Note> notes = [];

    @override
    void initState() {
        // TODO: implement initState
        _retrieveNotes();
        super.initState();
    }

    _retrieveNotes() async{
        notes = await Django.retrieveNotes();
        setState(() {});
    }

    _deleteNote(int id) async{
        await Django.deleteNote(id);
        _retrieveNotes();
    }

    @override
    Widget build(BuildContext context) {
        return  Scaffold(
            appBar: AppBar(
                title: const Text("Notes"),
            ),
            body: RefreshIndicator(
                onRefresh: () async{
                    _retrieveNotes();
                },
                child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index){
                        return Card(
                            elevation: 2.0,
                            child: ListTile(
                                leading: getAvatar(notes[index].priority),
                                title: Text(notes[index].subject),
                                subtitle: Text(notes[index].description),
                                onTap: () async{
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => UpdateNote(id: notes[index].id))
                                    );
                                    _retrieveNotes();
                                },
                                trailing: IconButton(
                                    onPressed: (){
                                        _deleteNote(notes[index].id);
                                    },
                                    icon: const Icon(Icons.delete),
                                ),
                            ),
                        );
                    }
                )
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async{
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CreateNote())
                    );
                    _retrieveNotes();
                },
                child: const Icon(Icons.add),
                tooltip: 'Add note',
            ),
        );
    }

    // Get CircleAvatar as par priority
    CircleAvatar getAvatar(int priority){
        Icon _icon;
        Color _color;
        if(priority==0) {
            _icon = const Icon(Icons.arrow_right);
            _color = Colors.redAccent;
        }
        else{
            _icon = const Icon(Icons.keyboard_arrow_right);
            _color = Colors.yellowAccent;
        }
        return  CircleAvatar(
            backgroundColor: _color,
            child: _icon
        );
    }


}
