import 'package:bb_sports/controllers/auth_controller.dart';
import 'package:bb_sports/views/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  late AuthController authController;

  setUp(() {
    authController = AuthController();
    Get.put(authController);
  });

  testWidgets('LoginScreen UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: LoginScreen()));
    expect(find.byType(Image), findsOneWidget);
    expect(find.textContaining('Basketball'), findsWidgets);
    expect(find.textContaining('Academy'), findsWidgets);
    expect(find.text('Login as Instructor'), findsOneWidget);
    expect(find.text('Login as Student'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Login button calls loginAction()', (WidgetTester tester) async {
    bool wasLoginCalled = false;

    // Override loginAction
    // authController.loginAction = () {
    //   wasLoginCalled = true;
    // };

    await tester.pumpWidget(GetMaterialApp(home: LoginScreen()));

    // Enter email and password
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'test@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );

    // Tap login
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(wasLoginCalled, true);
  });
}
