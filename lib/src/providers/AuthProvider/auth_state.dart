import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:trapp/src/models/index.dart';

enum LoginState {
  IsLogin,
  IsNotLogin,
}

class AuthState extends Equatable {
  final int? progressState;
  final String? message;
  final int? errorCode;
  final LoginState? loginState;
  final UserModel? userModel;
  final FeedbackModel? feedbackModel;
  final Function? callback;

  AuthState({
    @required this.message,
    @required this.errorCode,
    @required this.progressState,
    @required this.loginState,
    @required this.userModel,
    @required this.feedbackModel,
    @required this.callback,
  });

  factory AuthState.init() {
    return AuthState(
      errorCode: 0,
      progressState: 0,
      message: "",
      loginState: LoginState.IsNotLogin,
      userModel: UserModel(),
      feedbackModel: FeedbackModel(),
      callback: () {},
    );
  }

  AuthState copyWith({
    int? progressState,
    int? errorCode,
    String? message,
    LoginState? loginState,
    UserModel? userModel,
    FeedbackModel? feedbackModel,
    Function? callback,
  }) {
    return AuthState(
      progressState: progressState ?? this.progressState,
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
      loginState: loginState ?? this.loginState,
      userModel: userModel ?? this.userModel,
      feedbackModel: feedbackModel ?? this.feedbackModel,
      callback: callback ?? this.callback,
    );
  }

  AuthState update({
    int? progressState,
    int? errorCode,
    String? message,
    LoginState? loginState,
    UserModel? userModel,
    FeedbackModel? feedbackModel,
    Function? callback,
  }) {
    return copyWith(
      progressState: progressState,
      errorCode: errorCode,
      message: message,
      loginState: loginState,
      userModel: userModel,
      feedbackModel: feedbackModel,
      callback: callback,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorCode": errorCode,
      "message": message,
      "loginState": loginState,
      "userModel": userModel,
      "feedbackModel": feedbackModel,
      "callback": callback,
    };
  }

  @override
  List<Object> get props => [
        progressState!,
        errorCode!,
        message!,
        loginState!,
        userModel!,
        feedbackModel!,
        callback!,
      ];

  @override
  bool get stringify => true;
}
