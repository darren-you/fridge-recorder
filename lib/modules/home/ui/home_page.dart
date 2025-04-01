import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternow/modules/add/ui/normal_add_page.dart';
import 'package:flutternow/modules/mine/ui/mine_page.dart';
import 'package:flutternow/modules/foods/foods.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _navBarHeight = 56;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<HomePage> {
  final _pages = [
    const FoodsPage(),
    const NormalAddPage(),
    const MinePage(),
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
                        _buildTextNavItem(0, '食物'),
                        _buildAddButton(1),
                        _buildTextNavItem(2, '我的'),
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

  Widget _buildTextNavItem(int index, String label) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.black : Colors.grey;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Container(
            width: 56,
            height: 32,
            decoration: BoxDecoration(
              color: _currentIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
