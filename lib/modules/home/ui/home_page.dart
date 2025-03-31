import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternow/modules/fun_example/ui/fun_example_page.dart';
import 'package:flutternow/modules/mine_example/ui/mine_example_page.dart';
import 'package:flutternow/modules/ui_example/ui_example.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _navBarHeight = 56;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<HomePage> {
  final _pages = [
    const UiExamplePage(),
    const FunExamplePage(),
    const MineExamplePage(),
  ];

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final bottomBarHeight = mediaQueryData.padding.bottom + _navBarHeight;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MediaQuery(
              data: mediaQueryData.copyWith(
                padding: mediaQueryData.padding.copyWith(
                  bottom: mediaQueryData.viewInsets.bottom > 0
                      ? 0
                      : bottomBarHeight,
                ),
              ),
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    // bottom: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(0, CupertinoIcons.game_controller, '界面'),
                        _buildNavItem(1, CupertinoIcons.bus, '功能'),
                        _buildNavItem(2, CupertinoIcons.person, '我的'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
