import 'package:worldcup/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  ChangePasswordDialog(
      {this.oldPasswordController,
      this.newPasswordController,
      this.confirmPasswordController});

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            child: Text(
              'Change Password',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          TextFieldWidget(
            deviceSize: deviceSize,
            controller: widget.oldPasswordController,
            obscureText: true,
            labelText: 'Old Password',
            width: 1,
          ),
          TextFieldWidget(
            deviceSize: deviceSize,
            controller: widget.newPasswordController,
            obscureText: true,
            labelText: 'New Password',
            width: 1,
          ),
          TextFieldWidget(
            deviceSize: deviceSize,
            controller: widget.confirmPasswordController,
            obscureText: true,
            labelText: 'Confirm New Password',
            width: 1,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
