import 'package:flutter/material.dart';
import 'package:flutter_app_app/res/custom_colors.dart';
import 'package:flutter_app_app/utils/database.dart';
import 'package:flutter_app_app/utils/validator.dart';

import 'custom_form_field.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode imageFocusNode;

  const AddItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.imageFocusNode,
  });

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// 1- ui of AddItemForm ///
    return Form(
      key: _addItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 13.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),

                /// 2- ui of  empty textfield Title ///
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
                  isLabelEnabled: false,
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Title',
                  hint: 'أدخل عنوان للكتاب',
                ),
                SizedBox(height: 16.0),

                /// 3- ui of  empty textfield Image ///
                Text(
                  'صورة للكتاب',
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
                  inputAction: TextInputAction.none,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'image',
                  hint: 'أدخل عنوان URL للصورة',
                ),
                SizedBox(height: 16.0),

                /// 4- ui of  empty textfield Description ///
                Text(
                  'ملاحظة للكتاب',
                  style: TextStyle(
                    color: CustomColors.firebaseWhite,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                CustomFormField(
                  maxLines: 4,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'ملاحظة للكتاب',
                  hint: 'ادخل ملاحظة للكتاب',
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

              /// 5- code add data content [Title,Description,Image] to firebase ///
              onPressed: () async {
                widget.titleFocusNode.unfocus();
                widget.imageFocusNode.unfocus();
                widget.descriptionFocusNode.unfocus();

                if (_addItemFormKey.currentState!.validate()) {
                  setState(() {
                    _isProcessing = true;
                  });

                  await Database.addItem(
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
                  'اضافة للمكتبة',
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