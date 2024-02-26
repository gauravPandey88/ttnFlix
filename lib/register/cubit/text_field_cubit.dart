import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/register/cubit/text_field_state.dart';
import 'package:ttn_flix/utils/validation_helper.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(const TextFieldLoadingState());

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  void showAndHidePassword() {
    if (state is TextFieldLoadingState) {
      var currentState = state as TextFieldLoadingState;
      _passwordVisible = !_passwordVisible;
      emit(currentState.copyWith(isShowPassword: _passwordVisible));
    }
  }

  void showAndHideConfirmPassword() {
    if (state is TextFieldLoadingState) {
      var currentState = state as TextFieldLoadingState;
      _confirmPasswordVisible = !_confirmPasswordVisible;
      emit(currentState.copyWith(
        isShowConfrimPassword: _confirmPasswordVisible,
      ));
    }
  }

  String _getEmailIdErrorText() {
    final emailId = emailTextController.text.trim();
    return (emailId.isNotEmpty && !ValidationHelper.isValidEmail(emailId))
        ? S.current.invalidEmail
        : '';
  }

  void onEmailIdChange({required String emailId}) {
    if (state is TextFieldLoadingState) {
      final currentState = (state as TextFieldLoadingState);
      emit(currentState.copyWith(emailIdErrorMessage: _getEmailIdErrorText()));
    }
  }
}
