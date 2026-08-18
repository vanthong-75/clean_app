import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:clean_app/config/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // 📍 1. ຕັດ Space ຫວ່າງທາງໜ້າ-ທາງຫຼັງອອກ
    final cleanEmail = event.email.trim();
    final cleanPassword = event.password.trim();

    if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
      emit(const AuthFailure('ກະລຸນາປ້ອນ Email ແລະ Password ໃຫ້ຄົບຖ້ວນ'));
      return;
    }

    emit(AuthLoading());

    try {
      final res = await api.post(
        Uri.parse(URL +"auth/signin"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": cleanEmail,
          "password": cleanPassword,
        }),
      );

      // 📍 2. Print Debug Log ເບິ່ງ Response ແທ້ໆໃນ Terminal
      print("Response Status Code: ${res.statusCode}");
      print("Response Body: ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', cleanEmail);

        // 📍 3. ເຊັກຄວາມປອດໄພກ່ອນ decode JSON
        String? token;
        if (res.body.isNotEmpty) {
          try {
            final data = jsonDecode(res.body);
            if (data is Map && data['access_token'] != null) {
              token = data['access_token'].toString();
              await prefs.setString('auth_token', token);
            }
          } catch (e) {
            print("JSON Parsing Error: $e");
          }
        }

        emit(AuthSuccess(token: token));
      } else {
        // 📍 4. Parse Error Message ຈາກ Backend ເພື່ອສະແດງວ່າ Email ຫຼື Password ບໍ່ຖືກຕ້ອງ
        String errorMessage = 'ເຂົ້າສູ່ລະບົບລົ້ມເຫຼວ';
        try {
          if (res.body.isNotEmpty) {
            final errorData = jsonDecode(res.body);

            // ກວດເຊັກ structure Response ຈາກ Backend ( NestJS / Express )
            if (errorData is Map && errorData.containsKey('message')) {
              final msg = errorData['message'];
              if (msg is List) {
                errorMessage = msg.join('\n');
              } else {
                errorMessage = msg.toString();
              }
            } else if (errorData is Map && errorData.containsKey('error')) {
              errorMessage = errorData['error'].toString();
            } else {
              errorMessage = 'ຂໍ້ມູນບໍ່ຖືກຕ້ອງ (${res.statusCode})';
            }
          }
        } catch (_) {
          errorMessage = 'ເກີດຂໍ້ຜິດພາດຈາກ Server (${res.statusCode})';
        }

        emit(AuthFailure(errorMessage));
      }
    } catch (error) {
      print("Login Network Error: $error");
      emit(const AuthFailure('ບໍ່ສາມາດເຊື່ອມຕໍ່ Server ໄດ້'));
    }
  }
}
