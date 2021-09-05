import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'note.dart';

class Django{
    static final Client _client = http.Client();

    static String baseUrl = '192.168.0.103:7000';
    static Uri baseUri = Uri.http(baseUrl, "");
    static Uri retrieveUri = Uri.http(baseUrl, 'notes');
    static Uri createUri = Uri.http(baseUrl, 'notes/create');

    static getUrl(int id){
        return Uri.http(baseUrl, 'notes/'+id.toString());
    }
    static updateUrl(int id){
        return Uri.http(baseUrl, 'notes/'+id.toString()+'/update');
    }
    static deleteUrl(int id){
        return Uri.http(baseUrl, 'notes/'+id.toString()+'/delete');
    }


    static createNote(var bd) async{
        await _client.post(
            createUri,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(bd),
        );
    }
    static updateNote(int id, var bd) async{
        await _client.put(
            updateUrl(id),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(bd),
        );
    }
    static retrieveNote(int id) async{
        Map<String, dynamic> response = jsonDecode((await _client.get(getUrl(id))).body);
        return Note.fromMap(response);
    }
    static retrieveNotes() async{
        List<Note> notes = [];
        List response = jsonDecode((await _client.get(retrieveUri)).body);
        for (var element in response) {
            notes.add(Note.fromMap(element));
        }
        return notes;
    }
    static deleteNote(int id) async{
        await _client.delete(deleteUrl(id));
    }
    
}