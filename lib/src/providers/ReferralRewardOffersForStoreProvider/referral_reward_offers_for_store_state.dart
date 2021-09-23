import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class ReferralRewardOffersForStoreState extends Equatable {
  final int? progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String? message;
  final Map<String, dynamic>? newReferralRewardOffersForStoreData;
  final Map<String, dynamic>? referralRewardOffersForStoreListData;
  final Map<String, dynamic>? referralRewardOffersForStoreMetaData;
  final bool? isRefresh;

  ReferralRewardOffersForStoreState({
    @required this.progressState,
    @required this.message,
    @required this.newReferralRewardOffersForStoreData,
    @required this.referralRewardOffersForStoreListData,
    @required this.referralRewardOffersForStoreMetaData,
    @required this.isRefresh,
  });

  factory ReferralRewardOffersForStoreState.init() {
    return ReferralRewardOffersForStoreState(
      progressState: 0,
      message: "",
      newReferralRewardOffersForStoreData: Map<String, dynamic>(),
      referralRewardOffersForStoreListData: Map<String, dynamic>(),
      referralRewardOffersForStoreMetaData: Map<String, dynamic>(),
      isRefresh: false,
    );
  }

  ReferralRewardOffersForStoreState copyWith({
    int? progressState,
    String? message,
    Map<String, dynamic>? newReferralRewardOffersForStoreData,
    Map<String, dynamic>? referralRewardOffersForStoreListData,
    Map<String, dynamic>? referralRewardOffersForStoreMetaData,
    bool? isRefresh,
  }) {
    return ReferralRewardOffersForStoreState(
      progressState: progressState ?? this.progressState,
      message: message ?? this.message,
      newReferralRewardOffersForStoreData: newReferralRewardOffersForStoreData ?? this.newReferralRewardOffersForStoreData,
      referralRewardOffersForStoreListData: referralRewardOffersForStoreListData ?? this.referralRewardOffersForStoreListData,
      referralRewardOffersForStoreMetaData: referralRewardOffersForStoreMetaData ?? this.referralRewardOffersForStoreMetaData,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }

  ReferralRewardOffersForStoreState update({
    int? progressState,
    String? message,
    Map<String, dynamic>? newReferralRewardOffersForStoreData,
    Map<String, dynamic>? referralRewardOffersForStoreListData,
    Map<String, dynamic>? referralRewardOffersForStoreMetaData,
    bool? isRefresh,
  }) {
    return copyWith(
      progressState: progressState,
      message: message,
      newReferralRewardOffersForStoreData: newReferralRewardOffersForStoreData,
      referralRewardOffersForStoreListData: referralRewardOffersForStoreListData,
      referralRewardOffersForStoreMetaData: referralRewardOffersForStoreMetaData,
      isRefresh: isRefresh,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "message": message,
      "newReferralRewardOffersForStoreData": newReferralRewardOffersForStoreData,
      "referralRewardOffersForStoreListData": referralRewardOffersForStoreListData,
      "referralRewardOffersForStoreMetaData": referralRewardOffersForStoreMetaData,
      "isRefresh": isRefresh,
    };
  }

  @override
  List<Object> get props => [
        progressState!,
        message!,
        newReferralRewardOffersForStoreData!,
        referralRewardOffersForStoreListData!,
        referralRewardOffersForStoreMetaData!,
        isRefresh!,
      ];

  @override
  bool get stringify => true;
}
