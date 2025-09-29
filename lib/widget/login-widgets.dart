import 'dart:ui';
import 'package:flutter/material.dart';

// -----------------------------Textfield--------------------------------------------
class GlassTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;

  const GlassTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Center(
            child: TextField(
              obscureText: _obscureText,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
                isDense: true,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//----------------------------Button------------------------------------------------------
class GlassButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const GlassButton({super.key, required this.text, required this.onPressed});

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              _isPressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              _isPressed = false;
            });
            widget.onPressed();
          },
          onTapCancel: () {
            setState(() {
              _isPressed = false;
            });
          },
          child: Container(
            width: 150,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isPressed
                  ? Colors.white.withOpacity(0.05) 
                  : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
