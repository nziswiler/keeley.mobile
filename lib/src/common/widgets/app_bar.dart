import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScrollableAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;
  final ScrollController scrollController;
  final bool centerTitle;
  final double fadeStart;
  final double fadeEnd;
  final double minOpacity;
  final double maxBlur;
  final double gradientIntensity;

  const ScrollableAppBar({
    super.key,
    required this.title,
    required this.scrollController,
    this.automaticallyImplyLeading = false,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.fadeStart = 0.0,
    this.fadeEnd = 100.0,
    this.minOpacity = 0.8,
    this.maxBlur = 4.0,
    this.gradientIntensity = 0.8,
  });

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
    } else if (_scrollOffset >= widget.fadeEnd) {
      return widget.minOpacity;
    } else {
      return 1.0 -
          ((_scrollOffset - widget.fadeStart) /
                  (widget.fadeEnd - widget.fadeStart)) *
              (1.0 - widget.minOpacity);
    }
  }

  double get _blurStrength {
    if (_scrollOffset <= widget.fadeStart) {
      return 0.0;
    } else if (_scrollOffset >= widget.fadeEnd) {
      return widget.maxBlur;
    } else {
      return ((_scrollOffset - widget.fadeStart) /
              (widget.fadeEnd - widget.fadeStart)) *
          widget.maxBlur;
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
                colorScheme.background.withValues(
                    alpha: _appBarOpacity * widget.gradientIntensity),
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
            centerTitle: widget.centerTitle,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            leading: widget.leading,
            actions: widget.actions,
            iconTheme: IconThemeData(color: colorScheme.foreground),
          ),
        ),
      ),
    );
  }
}

extension ScrollableAppBarExtension on Widget {
  Widget withScrollableAppBar({
    required String title,
    required ScrollController scrollController,
    bool automaticallyImplyLeading = false,
    List<Widget>? actions,
    Widget? leading,
    double fadeStart = 0.0,
    double fadeEnd = 100.0,
    double minOpacity = 0.1,
    double maxBlur = 10.0,
    double gradientIntensity = 0.8,
    bool centerTitle = true,
  }) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ScrollableAppBar(
        title: title,
        scrollController: scrollController,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions,
        leading: leading,
        fadeStart: fadeStart,
        fadeEnd: fadeEnd,
        minOpacity: minOpacity,
        maxBlur: maxBlur,
        gradientIntensity: gradientIntensity,
        centerTitle: centerTitle,
      ),
      body: this,
    );
  }
}
