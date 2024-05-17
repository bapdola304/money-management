import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/screens/create_expend/components/children.dart';
import 'package:money_management/screens/create_expend/components/item.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

class CreateExpend extends StatefulWidget {
  const CreateExpend({Key? key}) : super(key: key);

  @override
  _CreateExpendState createState() => _CreateExpendState();
}

class _CreateExpendState extends State<CreateExpend> {
  TextEditingController _controller = TextEditingController(text: '0');
  TextEditingController _accountsController = TextEditingController();
  var focusNode = FocusNode();
  final ValueNotifier<ProjectModel> projectValueNotifierFirst =
      ValueNotifier<ProjectModel>(listProjects[0]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
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
            'Chi tiền',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
        body: Container(
          color: const Color(0xFFefeff2),
          child: Column(children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('Số tiền'),
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
                              color: Colors.red),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ]),
            ),
            Container(
              color: Colors.white,
              child: Column(children: [
                MiraiPopupMenu<ProjectModel>(
                  key: UniqueKey(),
                  children: listProjects,
                  showSearchTextField: true,
                  itemWidgetBuilder: (
                    int index,
                    ProjectModel? project, {
                    bool isItemSelected = false,
                  }) {
                    return DropDownItemWidget(
                      project: project,
                      isItemSelected: isItemSelected,
                    );
                  },
                  onChanged: (ProjectModel project) {},
                  child: DropDownObjectChildWidget(
                    key: GlobalKey(),
                    projectValueNotifier: projectValueNotifierFirst,
                  ),
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
