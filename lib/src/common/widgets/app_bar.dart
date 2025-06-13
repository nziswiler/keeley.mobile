import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScrollableAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ScrollableAppBar({
    super.key,
    required this.title,
    required this.scrollController,
  });

  final String title;
  final ScrollController scrollController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ScrollableAppBar> createState() => _ScrollableAppBarState();
}

class _ScrollableAppBarState extends State<ScrollableAppBar> {
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = widget.scrollController.offset;
    });
  }

  double get _appBarOpacity {
    if (_scrollOffset <= 0.0) {
      return 1.0;
    } else if (_scrollOffset >= 100.0) {
      return 0.8;
    } else {
      return 1.0 - (_scrollOffset / 100.0) * 0.2;
    }
  }

  double get _blurStrength {
    if (_scrollOffset <= 0.0) {
      return 0.0;
    } else if (_scrollOffset >= 100.0) {
      return 4.0;
    } else {
      return (_scrollOffset / 100.0) * 4.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _blurStrength,
          sigmaY: _blurStrength,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.background.withValues(alpha: _appBarOpacity),
                colorScheme.background
                    .withValues(alpha: _appBarOpacity * 0.8),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: colorScheme.border.withValues(alpha: _appBarOpacity),
                width: 0.5,
              ),
            ),
          ),
          child: AppBar(
            title: Text(widget.title, style: textTheme.h4),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            iconTheme: IconThemeData(color: colorScheme.foreground),
          ),
        ),
      ),
    );
  }
}

