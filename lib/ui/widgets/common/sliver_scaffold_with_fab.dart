import 'package:flutter/material.dart';

import '../../../common/extensions/scroll_controller_extensions.dart';
import 'app_fab.dart';

class SliverScaffoldWithFab extends StatefulWidget {
  final List<Widget> slivers;

  const SliverScaffoldWithFab({
    Key key,
    @required this.slivers,
  }) : super(key: key);

  @override
  _SliverScaffoldWithFabState createState() => _SliverScaffoldWithFabState();
}

class _SliverScaffoldWithFabState extends State<SliverScaffoldWithFab> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _hideFabAnimController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 0, // initially not visible
    );
    _scrollController.addListener(() => _scrollController.handleScrollForFab(_hideFabAnimController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: widget.slivers,
      ),
      floatingActionButton: AppFab(
        hideFabAnimController: _hideFabAnimController,
        scrollController: _scrollController,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }
}
