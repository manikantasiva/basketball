import 'dart:convert';

import 'package:bb_sports/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthController controller;

  setUp(() {
    Get.testMode = true;
    controller = AuthController();

    Get.put(controller);
  });

  testWidgets('Login success for instructor', (WidgetTester tester) async {
    controller.emailController.text = "ali@gmail.com";
    controller.passwordController.text = "ali123";
    controller.toggleLoginType("studnet");

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Form(
            key: controller.formKey,
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => controller.loginAction(),
                  child: const Text('Test Login'),
                );
              },
            ),
          ),
        ),
      ),
    );

    const fakeJson = '''
    [
      {
        "id": 1,
        "name": "Coach Ram",
        "type": "instructor",
        "email": "ram@gmail.com",
        "mobile": "9999999991",
        "password": "ram123",
        "location": "Chennai"
      }
    ]
    ''';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final assetKey = utf8.decode(message!.buffer.asUint8List());
          if (assetKey.contains('user_data.json')) {
            return const StandardMethodCodec().encodeSuccessEnvelope(fakeJson);
          }
          return null;
        });

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => controller.loginAction(),
                child: const Text('Test Login'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Test Login'));
    await tester.pump(); 
    expect(controller.emailController.text, '');
    expect(controller.passwordController.text, '');
  });

  testWidgets('Login fails with wrong password', (WidgetTester tester) async {
    controller.emailController.text = "ram@gmail.com";
    controller.passwordController.text = "wrong";
    controller.toggleLoginType("instructor");

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Form(
            key: controller.formKey,
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => controller.loginAction(),
                  child: const Text('Test Login'),
                );
              },
            ),
          ),
        ),
      ),
    );

    const fakeJson = '''
    [
      {
        "id": 1,
        "name": "Coach Ram",
        "type": "instructor",
        "email": "ram@gmail.com",
        "mobile": "9999999991",
        "password": "ram123",
        "location": "Chennai"
      }
    ]
    ''';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          return const StandardMethodCodec().encodeSuccessEnvelope(fakeJson);
        });

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => controller.loginAction(),
                child: const Text('Fail Login'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Fail Login'));
    await tester.pump();

    expect(controller.emailController.text, isNotEmpty);
    expect(controller.passwordController.text, isNotEmpty);
  });
}
