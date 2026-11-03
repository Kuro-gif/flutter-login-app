import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  // Colors taken from the two designs
  static const peach = Color(0xFFE8C4B8);
  static const navy = Color(0xFF2B2740);
  static const yellow = Color(0xFFFFEB3B);
  static const fieldGrey = Color(0xFFF4F4F4);
  static const gradientStart = Color(0xFF3043D6);
  static const gradientEnd = Color(0xFF66E0F5);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully')),
      );
    }
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: fieldGrey,
      suffixIcon: suffix,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 8),
      child: Text(
        '$text *',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: peach,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading (image 1 style, with yellow highlight word)
                  const Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Need to hire ',
                        children: [
                          TextSpan(
                            text: 'freelancer?',
                            style: TextStyle(color: yellow),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Login, type in what you need and receive a free quote in seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Email (image 2 style)
                  _label('Email'),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration('Enter your email'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password
                  _label('Password'),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: _inputDecoration(
                      'Enter your Password',
                      suffix: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black38,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Password is required';
                      }
                      if (v.length < 6) return 'At least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),

                  // Gradient pill button (image 2 style)
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [gradientStart, gradientEnd],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}