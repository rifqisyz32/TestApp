import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/pages/products/product_page.dart';
import 'package:test_app/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              "Silahkan masukkan akun terlebih dahulu sebelum masuk aplikasi",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              autocorrect: false,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                labelText: "Password",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Consumer<AuthProvider>(
                  builder: (context, auth, child) => IconButton(
                    icon: (auth.isHide)
                        ? Icon(Icons.remove_red_eye_outlined)
                        : Icon(Icons.remove_red_eye_rounded),
                    onPressed: () {
                      auth.hidePassword();
                    },
                  ),
                ),
              ),
              textInputAction: TextInputAction.next,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProductPage.routeName);
              },
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size.fromWidth(400),
                ),
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account?"),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Register here",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
