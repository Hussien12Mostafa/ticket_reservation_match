import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Models/User.dart';
import 'package:worldcup/ViewModels/AdminViewModel.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/UserListTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAllUsersView extends StatefulWidget {
  @override
  _AdminAllUsersViewState createState() => _AdminAllUsersViewState();
}

class _AdminAllUsersViewState extends State<AdminAllUsersView> {
  AdminViewModel provider;
  AuthenticationViewModel auth;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    provider = Provider.of<AdminViewModel>(context, listen: false);
    Future.microtask(() {
      provider.fetchAllUsers(auth.accessToken, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<User> users =
        Provider.of<AdminViewModel>(context, listen: true).getAllUsers;
    return Scaffold(
      backgroundColor: ConstantColors.grey,
      body: auth.role == "admin"
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceSize.width * 0.06,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
                        child: Text(
                          "All Users",
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: deviceSize.width * 0.55),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  height: deviceSize.height * 0.7,
                  width: deviceSize.width * 0.8,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: deviceSize.height * 0.7,
                      width: deviceSize.width * 0.8,
                      child: users.length != 0
                          ? Scrollbar(
                              child: ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  return UserListTileWidget(
                                    user: users[index],
                                    allUserWidget: true,
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Users Found',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 28),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            )
          : Error404View(),
    );
  }
}
