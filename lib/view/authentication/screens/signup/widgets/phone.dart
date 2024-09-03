import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../../bloc/sharedprefrences/sharedpref_bloc.dart';
import '../../../../../../generated/l10n.dart';

import '../../../../../../resources/values_manager.dart';

class Phone extends StatefulWidget {
  final TextEditingController controller;
  const Phone({
    super.key,
    required this.controller,
  });

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String getCountry(String country) {
    switch (country) {
      case "Egypt":
        return "EG";
      case "USA":
        return "US";
      case "France":
        return "FR";
      default:
        return "EG";
    }
  }

  @override
  Widget build(BuildContext context) {
   // PhoneNumber number = PhoneNumber(isoCode: "eg",dialCode: "+02",phoneNumber:);
    return InternationalPhoneNumberInput(
      locale: context.read<SharedPrefBloc>().lang,
      onInputChanged: (PhoneNumber number) {
        ////printnumber.phoneNumber);
      },
      onInputValidated: (bool value) {
        ////printvalue);
      },
      selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useBottomSheetSafeArea: true,
          setSelectorButtonAsPrefixIcon: true,
          leadingPadding: PaddingManager.pInternalPadding,
          trailingSpace: false),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: const TextStyle(color: Colors.black),
      spaceBetweenSelectorAndTextField: SizeManager.sSpace,
      inputDecoration: InputDecoration(
        label: Text(S.current.phoneNumber),
      ),

      initialValue: PhoneNumber(isoCode: "eg"),
      textFieldController: widget.controller,
      formatInput: true,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: false),
      inputBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(SizeManager.borderRadiusOfInputField),
      ),
      searchBoxDecoration: InputDecoration(
        label: Text(S.current.search),
        counterStyle: Theme.of(context).textTheme.bodyMedium,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        //floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      onSaved: (PhoneNumber number) {
        ////print'On Saved: $number');
      },
    );
  }
}
