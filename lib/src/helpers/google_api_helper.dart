import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleApiHelper {
  static Future<Map<String, dynamic>> getAddressFromPlaceID({
    @required String? googleApiKey,
    @required String? placeID,
    String language = "en",
  }) async {
    String endpoint = "https://maps.googleapis.com/maps/api/place/details/json";
    endpoint += "?key=$googleApiKey" + "&placeid=$placeID" + "&language=$language";

    try {
      var response = jsonDecode((await http.get(Uri.parse(endpoint))).body);
      if (response["status"] == "OK") {
        Map<String, dynamic> location = response['result']['geometry']['location'];
        var addressComponents = response['result']['address_components'];

        var city = "";
        var state = "";
        var nbhd = "";
        var subloc = "";
        var zipCode = "";
        var countryCode = "";
        bool hascity = false;
        bool hassub = false;
        for (var i = 0; i < addressComponents.length; i++) {
          var types = addressComponents[i]["types"];
          for (var j = 0; j < types.length; j++) {
            var type = types[j];
            if (type == "locality") {
              city = addressComponents[i]["long_name"];
              hascity = true;
            }
            if (type == "administrative_area_level_1") {
              state = addressComponents[i]["long_name"];
            }
            if (type == "neighborhood") {
              nbhd = addressComponents[i]["long_name"];
            }
            if (type == "sublocality") {
              subloc = addressComponents[i]["long_name"];
              hassub = true;
            }
            if (type == "postal_code") {
              zipCode = addressComponents[i]["long_name"];
            }
            if (type == "country") {
              countryCode = addressComponents[i]["short_name"];
            }
          }
        }

        if (hascity) {
          city = city;
        } else if (hassub) {
          city = subloc;
        } else {
          city = nbhd;
        }

        return {
          "placeID": placeID,
          "name": response['result']["name"],
          "address": response['result']["formatted_address"],
          "location": location,
          "countryCode": countryCode,
          "city": city,
          "state": state,
          "zipCode": zipCode,
        };
      }
    } catch (e) {
      print(e);
    }

    return Map<String, dynamic>();
  }

  static Future<Map<String, dynamic>> getAddressFromPosition({
    @required String? googleApiKey,
    @required double? lat,
    @required double? lng,
    String? selectedPlacedId,
    String language = "en",
  }) async {
    try {
      String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng'
          '&key=$googleApiKey&language=$language&sensor=false';

      var response = jsonDecode((await http.get(Uri.parse(endpoint))).body);
      var addrssResult = response['results'][0];
      var addressComponents = addrssResult['address_components'];

      if (selectedPlacedId != null && selectedPlacedId != "") {
        for (var i = 0; i < response['results'].length; i++) {
          if (response['results'][i]["place_id"] == selectedPlacedId) {
            addrssResult = response['results'][i];
            addressComponents = response['results'][i]['address_components'];
            break;
          }
        }
      }

      var placeId = addrssResult["place_id"];
      var address = addrssResult["formatted_address"];
      var city = "";
      var state = "";
      var nbhd = "";
      var subloc = "";
      var zipCode = "";
      var countryCode = "";
      bool hascity = false;
      bool hassub = false;
      for (var i = 0; i < addressComponents.length; i++) {
        var types = addressComponents[i]["types"];
        for (var j = 0; j < types.length; j++) {
          var type = types[j];
          if (type == "locality") {
            city = addressComponents[i]["long_name"];
            hascity = true;
          }
          if (type == "administrative_area_level_1") {
            state = addressComponents[i]["long_name"];
          }
          if (type == "neighborhood") {
            nbhd = addressComponents[i]["long_name"];
          }
          if (type == "sublocality") {
            subloc = addressComponents[i]["long_name"];
            hassub = true;
          }
          if (type == "postal_code") {
            zipCode = addressComponents[i]["long_name"];
          }
          if (type == "country") {
            countryCode = addressComponents[i]["short_name"];
          }
        }
      }

      if (hascity) {
        city = city;
      } else if (hassub) {
        city = subloc;
      } else {
        city = nbhd;
      }

      return {
        "placeId": placeId,
        "name": address.toString().split(",")[0].trim(),
        "address": address,
        "location": addrssResult['geometry']["location"],
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "countryCode": countryCode,
      };
    } catch (e) {
      print(e);
    }

    return Map<String, dynamic>();
  }

  // static Future<Map<String, dynamic>> getAddressFromPosition({
  //   @required String googleApiKey,
  //   @required double lat,
  //   @required double lng,
  //   String language = "en",
  // }) async {
  //   try {
  //     String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng'
  //         '&key=$googleApiKey&language=$language&sensor=true';

  //     var response = jsonDecode((await http.get(Uri.parse(endpoint))).body);
  //     var locationData;
  //     String zipCode;
  //     for (var i = 0; i < response['results'].length; i++) {
  //       var data = response['results'][i];
  //       for (var j = 0; j < data["address_components"].length; j++) {
  //         if (data["address_components"][j]["types"].contains("postal_code")) {
  //           zipCode = data["address_components"][j]["short_name"];
  //         }
  //       }
  //       if (data['geometry']['location_type'] == "ROOFTOP") {
  //         locationData = data;
  //         print(locationData['formatted_address']);
  //         print("_________${i}___________");
  //         break;
  //       }
  //     }
  //     if (locationData == null) locationData = response['results'][0];

  //     print(locationData['formatted_address']);
  //     return {
  //       "placeId": locationData['place_id'],
  //       "name": locationData['formatted_address'].toString().split(",")[0].trim(),
  //       "address": locationData['formatted_address'],
  //       "location": locationData['geometry']["location"],
  //       "countryCode": locationData['address_components'].last["short_name"],
  //       "zipCode": zipCode,
  //     };
  //   } catch (e) {
  //     print(e);
  //   }

  //   return Map<String, dynamic>();
  // }
}
