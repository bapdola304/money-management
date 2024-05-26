import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/model/item_menu.dart';
import 'package:money_management/screens/navigation/animated_bar.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key, required this.onTabChange}) : super(key: key);

  final Function(int tabIndex) onTabChange;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final List<TabItem> _icons = [
    TabItem(stateMachine: "HOME_interactivity", artboard: "HOME"),
    TabItem(stateMachine: "RULES_Interactivity", artboard: "RULES"),
    TabItem(stateMachine: "TIMER_Interactivity", artboard: "TIMER"),
    TabItem(stateMachine: "DASHBOARD_Interactivity", artboard: "DASHBOARD"),
    TabItem(stateMachine: "USER_Interactivity", artboard: "USER"),
  ];

  int _selectedTab = 0;

  void _onRiveIconInit(Artboard artboard, index) {
    final controller = StateMachineController.fromArtboard(
        artboard, _icons[index].stateMachine);
    artboard.addController(controller!);

    _icons[index].status = controller.findInput<bool>("active") as SMIBool;
  }

  void onTabPress(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
      widget.onTabChange(index);
    }
    _icons[index].status!.change(true);
    Future.delayed(const Duration(seconds: 1), () {
      _icons[index].status!.change(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // Clip to avoid the tab touch outside the border radius area
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 20),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            TabItem icon = _icons[index];
            if (index == 2) {
              return const SizedBox(width: 80);
            }
            return Expanded(
              key: icon.id,
              child: CupertinoButton(
                padding: const EdgeInsets.all(12),
                child: AnimatedOpacity(
                  opacity: _selectedTab == index ? 1 : 0.5,
                  duration: const Duration(milliseconds: 200),
                  child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: -4,
                            child: AnimatedBar(
                              isActive: _selectedTab == index,
                            )),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: RiveAnimation.asset(
                            'assets/icons/icons.riv',
                            stateMachines: [icon.stateMachine],
                            artboard: icon.artboard,
                            onInit: (artboard) {
                              _onRiveIconInit(artboard, index);
                            },
                          ),
                        )
                      ]),
                ),
                onPressed: () {
                  onTabPress(index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
