import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/model/gegenstaende.dart';

class CreateGegenstandWidget extends StatefulWidget {
  // const CreateGegenstandWidget({super.key});
  final Gegenstaende? gegenstaende;
  final ValueChanged<String> onSubmit;

  const CreateGegenstandWidget({
    Key? key,
    this.gegenstaende,
    required this.onSubmit,
  }) : super (key: key);

  @override
  State<CreateGegenstandWidget> createState() => _CreateGegenstandWidgetState();
}

class _CreateGegenstandWidgetState extends State<CreateGegenstandWidget> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller.text = widget.gegenstaende?.name ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.gegenstaende != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Gegenstand' : 'Add Gegenstand'),
      content: Form(
        key: formKey,
        child: TextFormField(
          autofocus: true,
          controller: controller,
          decoration: const InputDecoration(hintText: 'Name'),
          validator : (value) =>
          value != null && value.isEmpty ? 'Name is required' : null,
          ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate())
            {
              widget.onSubmit(controller.text);
            }
          }, 
          child: const Text('OK'),
        )
      ],
    );
  }
}