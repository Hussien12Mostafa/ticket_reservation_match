import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Models/User.dart';
import 'package:worldcup/ViewModels/AdminViewModel.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Widgets/UserDetailsDialog.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';

class UserListTileWidget extends StatefulWidget {
  final User user;
  final bool allUserWidget;
  UserListTileWidget({
    this.user,
    this.allUserWidget,
  });

  @override
  _UserListTileWidgetState createState() => _UserListTileWidgetState();
}

class _UserListTileWidgetState extends State<UserListTileWidget> {
  AdminViewModel provider;
  AuthenticationViewModel auth;
  @override
  void initState() {
    provider = Provider.of<AdminViewModel>(context, listen: false);
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(),
                  Text(
                    widget.user.firstName + " " + widget.user.lastName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Username: " + widget.user.userName,
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Role: " + widget.user.role,
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              if (!widget.allUserWidget)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: ConstantColors.purple,
                      backgroundColor: ConstantColors.purple,
                    ),
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        btnCancelText: "Reject",
                        btnOkText: "Accept",
                        btnCancelColor: Colors.red,
                        btnOkColor: ConstantColors.purple,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.NO_HEADER,
                        width: deviceSize.width * 0.6,
                        body: UserDetailsDialog(
                          user: widget.user,
                        ),
                        title: 'This is Ignored',
                        desc: 'This is also Ignored',
                        btnOkOnPress: () {
                          try {
                            provider.updatePending(
                                auth.accessToken, widget.user.id, true);
                          } catch (error) {}
                        },
                        btnCancelOnPress: () {
                          try {
                            provider.updatePending(
                              auth.accessToken,
                              widget.user.id,
                              false,
                            );
                          } catch (error) {}
                        },
                      )..show();
                    },
                  ),
                ),
              if (widget.allUserWidget)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ConstantColors.purple,
                          backgroundColor: ConstantColors.purple,
                        ),
                        child: Text(
                          "View details",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            btnCancelText: "Cancel",
                            btnOkText: "Ok",
                            btnCancelColor: Colors.red,
                            btnOkColor: ConstantColors.purple,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.INFO,
                            width: deviceSize.width * 0.6,
                            body: UserDetailsDialog(
                              user: widget.user,
                            ),
                            title: 'This is Ignored',
                            desc: 'This is also Ignored',
                            btnOkOnPress: () {},
                            btnCancelOnPress: () {},
                          )..show();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            btnCancelText: "Cancel",
                            btnOkText: "Ok",
                            btnCancelColor: Colors.red,
                            btnOkColor: ConstantColors.purple,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.QUESTION,
                            width: deviceSize.width * 0.6,
                            body: Text(
                              "Are you sure you want to delete this user??",
                            ),
                            title: 'This is Ignored',
                            desc: 'This is also Ignored',
                            btnOkOnPress: () {
                              try {
                                provider.deleteUser(
                                    auth.accessToken, widget.user.id);
                              } catch (error) {}
                            },
                            btnCancelOnPress: () {},
                          )..show();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
