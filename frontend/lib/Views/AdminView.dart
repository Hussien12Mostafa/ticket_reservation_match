import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/User.dart';
import 'package:worldcup/ViewModels/AdminViewModel.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/UserListTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  AdminViewModel provider;
  AdminViewModel providerListener;
  AuthenticationViewModel auth;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    provider = Provider.of<AdminViewModel>(context, listen: false);
    Future.microtask(() {
      provider.fetchPendingUsers(auth.accessToken, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    providerListener = Provider.of<AdminViewModel>(context, listen: true);
    List<User> users =
        Provider.of<AdminViewModel>(context, listen: true).getPendingUsers;
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
                          "Requests",
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: deviceSize.width * 0.55),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ConstantColors.purple,
                          backgroundColor: ConstantColors.purple,
                        ),
                        child: Text(
                          "Accept all",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await provider.updateAllPending(
                              auth.accessToken, true);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ConstantColors.purple,
                          backgroundColor: ConstantColors.purple,
                        ),
                        child: Text(
                          "Reject all",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await provider.updateAllPending(
                              auth.accessToken, false);
                        },
                      ),
                    ),
                  ],
                ),
                providerListener.status == Status.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        //color: Colors.grey[500],
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
                                          allUserWidget: false,
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'No Requests Found',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 28),
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
