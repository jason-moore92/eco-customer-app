import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class ScratchCardListState extends Equatable {
  final int? progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String? message;
  final Map<String, dynamic>? scratchCardListData;
  final Map<String, dynamic>? scratchCardMetaData;
  final bool? isRefresh;

  ScratchCardListState({
    @required this.progressState,
    @required this.message,
    @required this.scratchCardListData,
    @required this.scratchCardMetaData,
    @required this.isRefresh,
  });

  factory ScratchCardListState.init() {
    return ScratchCardListState(
      progressState: 0,
      message: "",
      scratchCardListData: Map<String, dynamic>(),
      scratchCardMetaData: Map<String, dynamic>(),
      isRefresh: false,
    );
  }

  ScratchCardListState copyWith({
    int? progressState,
    String? message,
    Map<String, dynamic>? scratchCardListData,
    Map<String, dynamic>? scratchCardMetaData,
    bool? isRefresh,
  }) {
    return ScratchCardListState(
      progressState: progressState ?? this.progressState,
      message: message ?? this.message,
      scratchCardListData: scratchCardListData ?? this.scratchCardListData,
      scratchCardMetaData: scratchCardMetaData ?? this.scratchCardMetaData,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }

  ScratchCardListState update({
    int? progressState,
    String? message,
    Map<String, dynamic>? scratchCardListData,
    Map<String, dynamic>? scratchCardMetaData,
    bool? isRefresh,
  }) {
    return copyWith(
      progressState: progressState,
      message: message,
      scratchCardListData: scratchCardListData,
      scratchCardMetaData: scratchCardMetaData,
      isRefresh: isRefresh,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "message": message,
      "scratchCardListData": scratchCardListData,
      "scratchCardMetaData": scratchCardMetaData,
      "isRefresh": isRefresh,
    };
  }

  @override
  List<Object> get props => [
        progressState!,
        message!,
        scratchCardListData!,
        scratchCardMetaData!,
        isRefresh!,
      ];

  @override
  bool get stringify => true;
}
