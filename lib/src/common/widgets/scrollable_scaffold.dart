import 'package:flutter/material.dart';
import 'package:keeley/src/common/widgets/app_bar.dart';
import 'package:keeley/src/theme/keeley_theme.dart';

class ScrollableScaffold extends StatefulWidget {
  const ScrollableScaffold({
    super.key,
    required this.title,
    required this.builder,
    this.floatingActionButton,
  });

  final String title;

  final Widget Function(ScrollController controller, EdgeInsets padding)
      builder;

  final Widget? floatingActionButton;

  @override
  State<ScrollableScaffold> createState() => _ScrollableScaffoldState();
}

class _ScrollableScaffoldState extends State<ScrollableScaffold> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(
      top: kToolbarHeight + Sizes.p16,
      left: Sizes.p24,
      right: Sizes.p24,
      bottom: Sizes.p24,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ScrollableAppBar(
        title: widget.title,
        scrollController: _scrollController,
      ),
      body: widget.builder(_scrollController, padding),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
