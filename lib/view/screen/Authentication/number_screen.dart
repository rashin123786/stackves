import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/provider/authentication_controller.dart';
import 'package:rashin_stackvase/core/services/auth_services.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Your Phone Number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'We will send you the 6-digit verification code',
              style: TextStyle(),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 16, left: 5, right: 5),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          authProvider.addPhoneCode(country.phoneCode);
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 65,
                      width: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Consumer<AuthController>(
                        builder: (context, value, child) => Text(
                          "+${value.phoneCode}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Phone Number";
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.phone_android_outlined),
                          ),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<AuthController>(
              builder: (context, value, child) => ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      value.setLoading(true);

                      await AuthServices().registerUser(context,
                          '+${authProvider.phoneCode} ${numberController.text}');
                    }
                  },
                  icon: value.isLoading == true
                      ? const Text('Loading')
                      : const Text('Continue'),
                  label: value.isLoading == true
                      ? const Text('.....')
                      : const Icon(Icons.arrow_forward)),
            )
          ],
        ),
      ),
    );
  }
}
