import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class ReferralRewardOffersState extends Equatable {
  final int? progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String? message;
  final Map<String, dynamic>? newReferralRewardOffersData;
  final Map<String, dynamic>? referralRewardOffersListData;
  final Map<String, dynamic>? referralRewardOffersMetaData;
  final bool? isRefresh;

  ReferralRewardOffersState({
    @required this.progressState,
    @required this.message,
    @required this.newReferralRewardOffersData,
    @required this.referralRewardOffersListData,
    @required this.referralRewardOffersMetaData,
    @required this.isRefresh,
  });

  factory ReferralRewardOffersState.init() {
    return ReferralRewardOffersState(
      progressState: 0,
      message: "",
      newReferralRewardOffersData: Map<String, dynamic>(),
      referralRewardOffersListData: Map<String, dynamic>(),
      referralRewardOffersMetaData: Map<String, dynamic>(),
      isRefresh: false,
    );
  }

  ReferralRewardOffersState copyWith({
    int? progressState,
    String? message,
    Map<String, dynamic>? newReferralRewardOffersData,
    Map<String, dynamic>? referralRewardOffersListData,
    Map<String, dynamic>? referralRewardOffersMetaData,
    bool? isRefresh,
  }) {
    return ReferralRewardOffersState(
      progressState: progressState ?? this.progressState,
      message: message ?? this.message,
      newReferralRewardOffersData: newReferralRewardOffersData ?? this.newReferralRewardOffersData,
      referralRewardOffersListData: referralRewardOffersListData ?? this.referralRewardOffersListData,
      referralRewardOffersMetaData: referralRewardOffersMetaData ?? this.referralRewardOffersMetaData,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }

  ReferralRewardOffersState update({
    int? progressState,
    String? message,
    Map<String, dynamic>? newReferralRewardOffersData,
    Map<String, dynamic>? referralRewardOffersListData,
    Map<String, dynamic>? referralRewardOffersMetaData,
    bool? isRefresh,
  }) {
    return copyWith(
      progressState: progressState,
      message: message,
      newReferralRewardOffersData: newReferralRewardOffersData,
      referralRewardOffersListData: referralRewardOffersListData,
      referralRewardOffersMetaData: referralRewardOffersMetaData,
      isRefresh: isRefresh,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "message": message,
      "newReferralRewardOffersData": newReferralRewardOffersData,
      "referralRewardOffersListData": referralRewardOffersListData,
      "referralRewardOffersMetaData": referralRewardOffersMetaData,
      "isRefresh": isRefresh,
    };
  }

  @override
  List<Object> get props => [
        progressState!,
        message!,
        newReferralRewardOffersData!,
        referralRewardOffersListData!,
        referralRewardOffersMetaData!,
        isRefresh!,
      ];

  @override
  bool get stringify => true;
}
