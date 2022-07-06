import 'package:flutter/material.dart';
import 'package:greezy/presentation/home/widgets/sliver_featured_menu.dart';
import 'package:greezy/presentation/home/widgets/sliver_popular_menu.dart';
import 'package:greezy/presentation/home/widgets/sliver_search_bar.dart';
import 'package:greezy/presentation/shared/clickable_title.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widgets/sliver_home_greet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveBuilder(
      builder: (ctx, size) => const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverHomeGreet(),
            SliverSearchBar(),
            SliverClickableTitle(title: "Featured meals"),
            SliverFeaturedMenu(),
            SliverClickableTitle(title: "Popular meals"),
            SliverPopularMenu(),
          ],
        ),
      ),
    );
  }
}
