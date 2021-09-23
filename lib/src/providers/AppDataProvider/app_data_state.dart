import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:trapp/config/config.dart';

class AppDataState extends Equatable {
  final int? progressState;
  final String? message;
  final int? distance;
  final Map<String, dynamic>? currentLocation;
  final List<dynamic>? savedLocationList;
  final List<dynamic>? recentLocationList;
  final List<dynamic>? categoryList;

  AppDataState({
    @required this.message,
    @required this.progressState,
    @required this.distance,
    @required this.currentLocation,
    @required this.savedLocationList,
    @required this.recentLocationList,
    @required this.categoryList,
  });

  factory AppDataState.init() {
    return AppDataState(
      progressState: 0,
      message: "",
      distance: AppConfig.distances[0]["value"],
      currentLocation: Map<String, dynamic>(),
      savedLocationList: [],
      recentLocationList: [],
      categoryList: [],
    );
  }

  AppDataState copyWith({
    int? progressState,
    String? message,
    int? distance,
    Map<String, dynamic>? currentLocation,
    List<dynamic>? savedLocationList,
    List<dynamic>? recentLocationList,
    List<dynamic>? categoryList,
  }) {
    return AppDataState(
      progressState: progressState ?? this.progressState,
      message: message ?? this.message,
      distance: distance ?? this.distance,
      currentLocation: currentLocation ?? this.currentLocation,
      savedLocationList: savedLocationList ?? this.savedLocationList,
      recentLocationList: recentLocationList ?? this.recentLocationList,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  AppDataState update({
    int? progressState,
    String? message,
    int? distance,
    Map<String, dynamic>? currentLocation,
    List<dynamic>? savedLocationList,
    List<dynamic>? recentLocationList,
    List<dynamic>? categoryList,
  }) {
    return copyWith(
      progressState: progressState,
      message: message,
      distance: distance,
      currentLocation: currentLocation,
      savedLocationList: savedLocationList,
      recentLocationList: recentLocationList,
      categoryList: categoryList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "message": message,
      "distance": distance,
      "currentLocation": currentLocation,
      "savedLocationList": savedLocationList,
      "recentLocationList": recentLocationList,
      "categoryList": categoryList,
    };
  }

  @override
  List<Object> get props => [
        progressState!,
        message!,
        distance!,
        currentLocation!,
        savedLocationList!,
        recentLocationList!,
        categoryList!,
      ];

  @override
  bool get stringify => true;
}
