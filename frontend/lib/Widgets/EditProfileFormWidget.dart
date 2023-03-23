import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Widgets/ChangePasswordDialog.dart';
import 'package:worldcup/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileFormWidget extends StatefulWidget {
  @override
  _EditProfileFormWidgetState createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  var deviceSize;
  AuthenticationViewModel userProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);

    firstNameController.text = userProvider.firstName;
    lastNameController.text = userProvider.lastName;
    birthDateController.text = userProvider.dateOfBirth.split('T')[0];
    nationalityController.text = userProvider.nationality;
    genderController.text = userProvider.gender;
    emailController.text = userProvider.email;
    userNameController.text = userProvider.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Container(
          width: deviceSize.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldWidget(
                deviceSize: deviceSize,
                controller: emailController,
                labelText: 'Email',
                isFieldEnabled: false,
                width: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: userNameController,
                    labelText: 'Username',
                    isFieldEnabled: false,
                    width: 2.05,
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: genderController,
                    labelText: 'Gender',
                    isFieldEnabled: false,
                    width: 2.05,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: firstNameController,
                    labelText: 'First Name',
                    width: 2.05,
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: lastNameController,
                    labelText: 'Last Name',
                    width: 2.05,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _birthDateTextField(birthDateController, "Date of birth"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _nationalityTextField(
                      nationalityController, "Nationality (Optional)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ConstantColors.purple,
                          backgroundColor: ConstantColors.purple,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              await userProvider.editProfile(
                                  emailController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  birthDateController.text,
                                  genderController.text,
                                  userNameController.text,
                                  nationalityController.text);
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Success',
                                  desc: 'Profile Edited Successfully',
                                  btnOkOnPress: () {},
                                  width: deviceSize.width * 0.4)
                                ..show();
                            } catch (error) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Error',
                                  desc: error.toString(),
                                  btnOkOnPress: () {},
                                  width: deviceSize.width * 0.4)
                                ..show();
                            }
                          }
                        },
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ConstantColors.purple,
                          backgroundColor: ConstantColors.purple,
                        ),
                        onPressed: () async {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              body: ChangePasswordDialog(
                                oldPasswordController: oldPasswordController,
                                newPasswordController: newPasswordController,
                                confirmPasswordController:
                                    confirmPasswordController,
                              ),
                              width: deviceSize.width * 0.6,
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                              btnOkOnPress: () async {
                                 if (newPasswordController.text !=
                                    confirmPasswordController.text)
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Error',
                                        desc: "Passwords Dont Match",
                                        btnOkOnPress: () {},
                                        width: deviceSize.width * 0.4)
                                      ..show();
                                if (oldPasswordController.text.isNotEmpty &&
                                    newPasswordController.text.isNotEmpty)
                                  try {
                                    await userProvider.changePassword(
                                      oldPasswordController.text,
                                      newPasswordController.text,
                                      confirmPasswordController.text,
                                    );
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Success',
                                        desc: 'Password Changed Successfully',
                                        btnOkOnPress: () {},
                                        width: deviceSize.width * 0.4)
                                      ..show();
                                  } catch (error) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Error',
                                        desc: error.toString(),
                                        btnOkOnPress: () {},
                                        width: deviceSize.width * 0.4)
                                      ..show();
                                  }
                                oldPasswordController.clear();
                                newPasswordController.clear();
                                Navigator.pop(context);
                              },
                              btnCancelOnPress: () {},
                              btnOkText: 'Change',
                              btnCancelText: 'Cancel')
                            ..show();

                          _formKey.currentState.validate();
                        },
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _nationalityTextField(
      TextEditingController controller, String labelText) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        width: deviceSize.width * (0.4 / 2.07),
        height: deviceSize.height * 0.08,
        margin: EdgeInsets.all(deviceSize.height * 0.015),
        child: DropdownButtonFormField(
          value: nationalityController.text,
          items: [
            "",
            "Afghan",
            "Albanian",
            "Algerian",
            "American",
            "Andorran",
            "Angolan",
            "Antiguans",
            "Argentinean",
            "Armenian",
            "Australian",
            "Austrian",
            "Azerbaijani",
            "Bahamian",
            "Bahraini",
            "Bangladeshi",
            "Barbadian",
            "Barbudans",
            "Batswana",
            "Belarusian",
            "Belgian",
            "Belizean",
            "Beninese",
            "Bhutanese",
            "Bolivian",
            "Bosnian",
            "Brazilian",
            "British",
            "Bruneian",
            "Bulgarian",
            "Burkinabe",
            "Burmese",
            "Burundian",
            "Cambodian",
            "Cameroonian",
            "Canadian",
            "Cape Verdean",
            "Central African",
            "Chadian",
            "Chilean",
            "Chinese",
            "Colombian",
            "Comoran",
            "Congolese",
            "Costa Rican",
            "Croatian",
            "Cuban",
            "Cypriot",
            "Czech",
            "Danish",
            "Djibouti",
            "Dominican",
            "Dutch",
            "East Timorese",
            "Ecuadorean",
            "Egyptian",
            "Emirian",
            "Equatorial Guinean",
            "Eritrean",
            "Estonian",
            "Ethiopian",
            "Fijian",
            "Filipino",
            "Finnish",
            "French",
            "Gabonese",
            "Gambian",
            "Georgian",
            "German",
            "Ghanaian",
            "Greek",
            "Grenadian",
            "Guatemalan",
            "Guinea-Bissauan",
            "Guinean",
            "Guyanese",
            "Haitian",
            "Herzegovinian",
            "Honduran",
            "Hungarian",
            "I-Kiribati",
            "Icelander",
            "Indian",
            "Indonesian",
            "Iranian",
            "Iraqi",
            "Irish",
            "Israeli",
            "Italian",
            "Ivorian",
            "Jamaican",
            "Japanese",
            "Jordanian",
            "Kazakhstani",
            "Kenyan",
            "Kittian and Nevisian",
            "Kuwaiti",
            "Kyrgyz",
            "Laotian",
            "Latvian",
            "Lebanese",
            "Liberian",
            "Libyan",
            "Liechtensteiner",
            "Lithuanian",
            "Luxembourger",
            "Macedonian",
            "Malagasy",
            "Malawian",
            "Malaysian",
            "Maldivan",
            "Malian",
            "Maltese",
            "Marshallese",
            "Mauritanian",
            "Mauritian",
            "Mexican",
            "Micronesian",
            "Moldovan",
            "Monacan",
            "Mongolian",
            "Moroccan",
            "Mosotho",
            "Motswana",
            "Mozambican",
            "Namibian",
            "Nauruan",
            "Nepalese",
            "New Zealander",
            "Nicaraguan",
            "Nigerian",
            "Nigerien",
            "North Korean",
            "Northern Irish",
            "Norwegian",
            "Omani",
            "Pakistani",
            "Palauan",
            "Panamanian",
            "Papua New Guinean",
            "Paraguayan",
            "Peruvian",
            "Polish",
            "Portuguese",
            "Qatari",
            "Romanian",
            "Russian",
            "Rwandan",
            "Saint Lucian",
            "Salvadoran",
            "Samoan",
            "San Marinese",
            "Sao Tomean",
            "Saudi",
            "Scottish",
            "Senegalese",
            "Serbian",
            "Seychellois",
            "Sierra Leonean",
            "Singaporean",
            "Slovakian",
            "Slovenian",
            "Solomon Islander",
            "Somali",
            "South African",
            "South Korean",
            "Spanish",
            "Sri Lankan",
            "Sudanese",
            "Surinamer",
            "Swazi",
            "Swedish",
            "Swiss",
            "Syrian",
            "Taiwanese",
            "Tajik",
            "Tanzanian",
            "Thai",
            "Togolese",
            "Tongan",
            "Trinidadian or Tobagonian",
            "Tunisian",
            "Turkish",
            "Tuvaluan",
            "Ugandan",
            "Ukrainian",
            "Uruguayan",
            "Uzbekistani",
            "Venezuelan",
            "Vietnamese",
            "Welsh",
            "Yemenite",
            "Zambian",
            "Zimbabwean"
          ]
              .map(
                (label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ),
              )
              .toList(),
          onChanged: (value) {
            nationalityController.text = value;
          },
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColors.purple, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[900], width: 1.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _birthDateTextField(
      TextEditingController birthDateController, String labelText) {
    return Container(
      width: deviceSize.width * (0.4 / 2.05),
      height: deviceSize.height * 0.08,
      margin: EdgeInsets.all(deviceSize.height * 0.015),
      child: TextField(
        onTap: () async {
          final choice = await showDatePicker(
              context: context,
              firstDate: DateTime(1970),
              lastDate: DateTime(2016),
              initialDate: DateTime(2016),
              builder: (BuildContext context, Widget child) {
                return Center(
                    child: SizedBox(
                  width: deviceSize.width * 0.6,
                  height: deviceSize.height * 0.6,
                  child: child,
                ));
              });
          birthDateController.text = DateFormat('yyyy-MM-dd').format(choice);
        },
        controller: birthDateController,
        enabled: true,
        enableInteractiveSelection: false,
        readOnly: true,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors.purple, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[900], width: 1.0),
          ),
        ),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
