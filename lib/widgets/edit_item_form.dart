import 'package:flutter/material.dart';

import 'package:flutter_app_app/res/custom_colors.dart';
import 'package:flutter_app_app/utils/database.dart';
import 'package:flutter_app_app/utils/validator.dart';

import 'custom_form_field.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode imageFocusNode;

  final String currentTitle;
  final String currentDescription;
  final String currentImage;
  final String documentId;

  const EditItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.imageFocusNode,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentImage,
    required this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.currentTitle,
    );
    _imageController = TextEditingController(
      text: widget.currentImage,
    );

    _descriptionController = TextEditingController(
      text: widget.currentDescription,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 1- ui of EditItemForm ///
    return Form(
      key: _editItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),

                /// 2- ui of  full textfield Title ///
                Text(
                  'عنوان للكتاب',
                  style: TextStyle(
                    color: CustomColors.firebaseWhite,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Title',
                  hint: 'Enter your note title',
                ),
                SizedBox(height: 16.0),

                /// 3- ui of  full textfield Image ///

                Text(
                  'Image',
                  style: TextStyle(
                    color: CustomColors.firebaseWhite,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _imageController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Image',
                  hint: 'Enter your image url',
                ),
                SizedBox(height: 16.0),

                /// 4- ui of  full textfield Description ///
                Text(
                  'عنوان الكتاب',
                  style: TextStyle(
                    color: CustomColors.firebaseWhite,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                CustomFormField(
                  maxLines: 5,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Description',
                  hint: 'أدخل وصف ملاحظتك',
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.firebaseOrange,
              ),
            ),
          )
              : Container(
            width: double.maxFinite,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  CustomColors.firebaseOrange,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              /// 5- code update data content after re-correction [Title,Description,Image] to firebase ///

              onPressed: () async {
                widget.titleFocusNode.unfocus();
                widget.descriptionFocusNode.unfocus();
                widget.imageFocusNode.unfocus();

                if (_editItemFormKey.currentState!.validate()) {
                  setState(() {
                    _isProcessing = true;
                  });

                  await Database.updateItem(
                    docId: widget.documentId,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    image: _imageController.text,
                  );

                  setState(() {
                    _isProcessing = false;
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  'تحديث آخر',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.firebaseWhite,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
