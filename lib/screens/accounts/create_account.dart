import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/utils/currence_format.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
        title: const Text(
          'Thêm tài khoản',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF5F5F8),
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              const Text('Số dư ban đầu'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                        controller: _controller,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          String formattedValue = formatCurrency(value);
                          _controller.value = TextEditingValue(
                            text: formattedValue,
                            selection: TextSelection.collapsed(
                                offset: formattedValue.length),
                          );
                        }),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '₫',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ]),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/icons/account_name.png',
                          width: 40,
                        )),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            hintText: 'Tên tài khoản',
                            hintStyle: TextStyle(color: Colors.black38)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/icons/wallet.png',
                          width: 40,
                        )),
                    const SizedBox(width: 8),
                    const Text(
                      'Tiền mặt',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
