// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String vPassword,
    @Default('') String name,
    @Default('') String namepyme,
    @Default(false) bool termsOk,
  }) = _RegisterState;
  static RegisterState get initialState => RegisterState();
}
