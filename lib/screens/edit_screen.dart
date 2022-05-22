import 'package:flutter/material.dart';
import 'package:flutter_app_app/res/custom_colors.dart';
import 'package:flutter_app_app/utils/database.dart';
import 'package:flutter_app_app/widgets/app_bar_title_.dart';
import 'package:flutter_app_app/widgets/edit_item_form.dart';

class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentImage;
  final String documentId;

  EditScreen({
    required this.currentTitle,
    required this.currentImage,
    required this.currentDescription,
    required this.documentId,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    /// 1- ui of EditScreen ///
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _imageFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset:
        false, // to keep the size, when opening the keyboard
        backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.firebaseNavy,

          /// 2- to call ui of AppBarTitle class ///
          title: AppBarTitle(),

          /// 3- ui of IconButton delete ///
          actions: [
            _isDeleting
                ? Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                right: 16.0,
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.redAccent,
                ),
                strokeWidth: 3,
              ),
            )
                : IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 32,
              ),

              /// 4- code of delete data content from firebase and screen ///
              onPressed: () async {
                setState(() {
                  _isDeleting = true;
                });

                await Database.deleteItem(
                  docId: widget.documentId,
                );

                setState(() {
                  _isDeleting = false;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),

            /// 5-  to call ui of EditItemForm class  ///
            child: EditItemForm(
              documentId: widget.documentId,
              titleFocusNode: _titleFocusNode,
              imageFocusNode: _imageFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              currentTitle: widget.currentTitle,
              currentImage: widget.currentImage,
              currentDescription: widget.currentDescription,
            ),
          ),
        ),
      ),
    );
  }
}
