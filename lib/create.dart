import 'package:flutter/material.dart';
import 'package:noteswithdjango/django.dart';
import 'package:noteswithdjango/note.dart';

class CreateNote extends StatefulWidget {
	const CreateNote({Key? key}) : super(key: key);

	@override
	_CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

	final _formKey = GlobalKey<FormState>();

	TextEditingController subjectController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();
	static final _priorities = ["High", "Low"];
	int _currentPriority=1;

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Create Note"),
			),
			body: Form(
				key: _formKey,
				child: Padding(
					padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
					child: ListView(
						children: <Widget>[
							//First Element
							Padding(
								padding: const EdgeInsets.only(left: 5.0),
								child: Row(
									children: <Widget>[
										const Text(
											"Priority : ",
										),
										Padding(
											padding: const EdgeInsets.only(left: 0.0),
											child: DropdownButton<String>(
												items: _priorities
													.map((String dropDownStringItem) {
													return DropdownMenuItem(
														value: dropDownStringItem,
														child: Text(dropDownStringItem),
													);
												}).toList(),
												value: _priorities[_currentPriority],
												onChanged: (valueSelectedByUser) {
													setState(() {
														_currentPriority = _priorities.indexOf(valueSelectedByUser??"Low");
													});
												}
											)
										)
									],
								),
							),

							//Second Element
							Padding(
								padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
								child: TextFormField(
                                    controller: subjectController,
//									onChanged: (value) {
//										setState(() {});
//									},
									validator: (String? value) {
										if (value!.isEmpty) {
											return "Please a title.";
										}
									},
									decoration: InputDecoration(
										labelText: 'Subject',
										errorStyle: const TextStyle(
											fontSize: 15.0,
										),
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(5.0),
										)
									),
								),
							),

							//Third Element
							Padding(
								padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
								child: TextFormField(
                                    controller: descriptionController,
//									onChanged: (value) {
//										setState(() {});
//									},
									decoration: InputDecoration(
										labelText: 'Description',
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(5.0),
										)
									),
								),
							),

							//Fourth Element
							Padding(
								padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20.0, left: 20.0),
								child: ElevatedButton(
									child: const Text(
										"Save",
										textScaleFactor: 1.5,
									),
									onPressed: () async{
										await createNote();
										Navigator.of(context).pop();
									},
								),
							),
						],
					),
				),
			),
		);
	}

	createNote() async{
		var bd = {
			'priority' :  _currentPriority,
			'subject' : subjectController.text,
			'description' : descriptionController.text
		};
		await Django.createNote(bd);
	}
}
