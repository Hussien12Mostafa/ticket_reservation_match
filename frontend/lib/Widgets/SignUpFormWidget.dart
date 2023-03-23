import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  var deviceSize;
  AuthenticationViewModel provider;
  AuthenticationViewModel providerListener;
  final _formKey = GlobalKey<FormState>();
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  void initState() {
    provider = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerListener =
        Provider.of<AuthenticationViewModel>(context, listen: true);
    deviceSize = MediaQuery.of(context).size;
    return providerListener.status == Status.loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: Container(
              width: deviceSize.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        deviceSize: deviceSize,
                        controller: firstNameController,
                        labelText: 'First Name *',
                        width: 2.05,
                      ),
                      TextFieldWidget(
                        deviceSize: deviceSize,
                        controller: lastNameController,
                        labelText: 'Last Name *',
                        width: 2.05,
                      ),
                    ],
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: emailController,
                    labelText: 'Email *',
                    width: 1,
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Password *',
                    width: 1,
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: passwordConfirmationController,
                    obscureText: true,
                    labelText: 'Password Confirmation *',
                    width: 1,
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: userNameController,
                    labelText: 'User Name *',
                    width: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _birthDateTextField(birthDateController, "Date of birth *"),
                      _nationalityTextField(
                          nationalityController, "Nationality (Optional)"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _genderTextField(genderController, "Gender *"),
                      _roleTextField(roleController, "Role *"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ConstantColors.purple,
                      ),
                      onPressed: () async {
                        try {
                          _formKey.currentState.validate();
                          await provider.signUp(
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            userNameController.text,
                            passwordController.text,
                            passwordConfirmationController.text,
                            genderController.text,
                            roleController.text,
                            birthDateController.text,
                            nationalityController.text,
                            context,
                          );
                          _navigationService.navigateToWithReplacement(
                              routes.guestViewAllMatches);
                        } catch (error) {}
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _genderTextField(TextEditingController controller, String labelText) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        width: deviceSize.width * (0.4 / 2.07),
        height: deviceSize.height * 0.08,
        margin: EdgeInsets.all(deviceSize.height * 0.015),
        child: DropdownButtonFormField(
          items: ["Male", "Female"]
              .map(
                (label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ),
              )
              .toList(),
          onChanged: (value) {
            genderController.text = value;
            // _enableSubmit();
          },
          // value:
          //     genderController.text.isNotEmpty ? genderController.text : null,
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

  Widget _roleTextField(TextEditingController controller, String labelText) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        width: deviceSize.width * (0.4 / 2.07),
        height: deviceSize.height * 0.08,
        margin: EdgeInsets.all(deviceSize.height * 0.015),
        child: DropdownButtonFormField(
          items: ["Fan", "Manager"]
              .map(
                (label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ),
              )
              .toList(),
          onChanged: (value) {
            roleController.text = value;
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

  Widget _nationalityTextField(
      TextEditingController controller, String labelText) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        width: deviceSize.width * (0.4 / 2.07),
        height: deviceSize.height * 0.08,
        margin: EdgeInsets.all(deviceSize.height * 0.015),
        child: DropdownButtonFormField(
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
      width: deviceSize.width * (0.4 / 2.07),
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
