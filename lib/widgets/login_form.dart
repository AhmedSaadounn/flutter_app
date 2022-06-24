import 'package:flutter/material.dart';
import 'package:flutter_app_app/res/custom_colors.dart';
import 'package:flutter_app_app/screens/dashboard_screen.dart';
import 'package:flutter_app_app/utils/database.dart';
import 'package:flutter_app_app/utils/validator.dart';

import 'custom_form_field.dart';

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;

  const LoginForm({
    Key? key,
    required this.focusNode,
  }) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uidController = TextEditingController();

  final _loginInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /// 1- ui of LoginForm ///
    return Form(
      key: _loginInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _uidController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateUserID(
                    uid: value,
                  ),
                  label: 'ادخل تصنيف الكتاب',
                  hint: 'الرياضة , التاريخ ,السياسة',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    CustomColors.firebaseOrange,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                /// 2- code navigator to DashboardScreen after inter idDocs and click login ///
                onPressed: () {
                  widget.focusNode.unfocus();

                  if (_loginInFormKey.currentState!.validate()) {
                    Database.idDocs = _uidController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    'بحث',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.firebaseWhite,
                      letterSpacing: 2,
                    ),
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

