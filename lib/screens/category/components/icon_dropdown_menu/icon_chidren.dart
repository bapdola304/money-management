import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class DropDownIconChildWidget extends StatefulWidget {
  const DropDownIconChildWidget({
    super.key,
    this.icon,
  });

  final String? icon;

  @override
  State<DropDownIconChildWidget> createState() =>
      _DropDownIconChildWidgetState();
}

class _DropDownIconChildWidgetState extends State<DropDownIconChildWidget> {
  final TextEditingController _iconController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isIconSelected = (widget.icon?.isNotEmpty ?? false);
    if (isIconSelected) {
      _iconController.text = 'Thay đổi biểu tượng';
    }
    return Row(
      children: [
        isIconSelected
            ? Base64ImageWidget(base64String: widget.icon, width: 60)
            : Image.asset('assets/icons/empty_icon.png', width: 60),
        const SizedBox(width: 10),
        Expanded(
          child: Stack(
            children: [
              TextFormField(
                  readOnly: true,
                  controller: _iconController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black38),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      border: const UnderlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      hintText: isIconSelected
                          ? 'Thay đổi biểu tượng'
                          : 'Chọn biểu tượng',
                      hintStyle: const TextStyle(color: Colors.black38)),
                  validator: Validators.compose(
                      [Validators.required('Vui lòng chọn biểu tượng')])),
              Positioned(
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 50,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
