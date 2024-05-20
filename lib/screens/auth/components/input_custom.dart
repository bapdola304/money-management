import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget {
  const InputCustom(
      {Key? key,
      required this.label,
      required this.obscureText,
      this.validator,
      this.controller})
      : super(key: key);
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _obscured = widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          obscureText: _obscured,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              suffixIcon: widget.obscureText
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: InkWell(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    )
                  : null,
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
