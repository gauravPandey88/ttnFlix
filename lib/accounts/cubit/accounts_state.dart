import 'dart:io';
import 'dart:typed_data';

import 'package:ttn_flix/utils/default_equatable.dart';

abstract class AccountsState extends DefaultEquatable {
  const AccountsState();
}

class AccountsLoadingState extends AccountsState {
  const AccountsLoadingState();
}

class AccountLoadedState extends AccountsState {
  final String? name;
  final String? emailAddress;
  final String? dateOfBirth;
  final String? gender;
  final String? image;
  final String? dateofBirth;
  final String? password;
  final int? timeStamp;
  final bool? isLogin;

  const AccountLoadedState({
     this.name,
     this.emailAddress,
    this.dateOfBirth,
    this.gender,
    this.image,
    this.dateofBirth,
    this.isLogin,
    this.password,
    this.timeStamp
  });

  AccountLoadedState copyWith({
    final String? name,
    final String? emailAddress,
    final String? dateOfBirth,
    final String? gender,
    final String? image,
    final String? dateofBirth,
    final String? password,
    final bool? islogin,
    final int? timeStamp,
  }) {
    return AccountLoadedState(
      name: name ?? this.name,
      emailAddress: emailAddress ?? this.emailAddress,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      dateofBirth: dateofBirth ?? this.dateofBirth,
      isLogin: isLogin ?? isLogin,
      password: password ?? this.password,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  @override
  List<Object?> get props => [
    name,
    emailAddress,
    dateOfBirth,
    image,
    gender,
    dateofBirth,
    password,
    isLogin,
    timeStamp
  ];
}
