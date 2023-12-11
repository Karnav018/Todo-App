import 'package:flutter/material.dart';
import 'package:todo/components/my_button.dart';

class MyDialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  MyDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            //TextField
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add New Task',
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //buttons -> save + cancel
            Row(
              children: [
                //save button
                MyButton(name: 'Save', onPressed: onSave),

                const SizedBox(
                  width: 10,
                ),

                //cancel button
                MyButton(name: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
