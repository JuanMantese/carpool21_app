import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class GooglePlacesAutoComplete extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  Function(Prediction prediction) onPlaceSelected;

  GooglePlacesAutoComplete(this.controller, this.hintText, this.onPlaceSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        boxDecoration: const BoxDecoration(
          color: Colors.white
        ),
        textEditingController: controller,
        googleAPIKey: "YOUR_GOOGLE_API_KEY",
        inputDecoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.red
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: const ["ar"], // Lugares que voy a poder buscar en el mapa - ar = Argentina
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: onPlaceSelected,
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,

        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}