import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class _Page {
  const _Page(
    this.id,
    this.title,
    this.color,
  )   : assert(id != null),
        assert(title != null),
        assert(color != null);

  final int id;
  final String title;
  final Color color;
}

final List<_Page> _allPages = <_Page>[
  _Page(1, 'Item 1', Colors.orange),
  _Page(2, 'Item 2', Colors.red),
  _Page(3, 'Item 3', Colors.blue),
  _Page(4, 'Item 4', Colors.green),
];

class TabBarFixed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: _buildSliverAppBar(context),
              ),
            ];
          },
          body: new TabBarView(
            children: _allPages
                .map(
                  (page) => SafeArea(
                        top: false,
                        bottom: false,
                        child: new Builder(
                          builder: (context) {
                            return _buildTabBarView(context, page);
                          },
                        ),
                      ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context, _Page page) {
    List<Widget> slivers = new List<Widget>();

    slivers.add(new SliverObstructionInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)));
    slivers.addAll(_buildSideHeaderGrids(0, 5, page.color));

    return CustomScrollView(
      key: PageStorageKey<_Page>(page),
      slivers: slivers,
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      title: Text('Main AppBar'),
      bottom: TabBar(
        tabs: _allPages
            .map(
              (p) => new Tab(
                    child: Text(p.title),
                  ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _buildSideHeaderGrids(int firstIndex, int count, Color color) {
    return List.generate(count, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        overlapsContent: true,
        header: _buildSideHeader(sliverIndex, color),
        sliver: new SliverPadding(
          padding: new EdgeInsets.only(left: 60.0),
          sliver: new SliverGrid(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0, childAspectRatio: 1.0),
            delegate: new SliverChildBuilderDelegate(
              (context, i) => new GridTile(
                    child: Card(
                      child: new Container(
                        color: color,
                      ),
                    ),
                    footer: new Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          'Grid tile #$i',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
              childCount: 12,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSideHeader(int index, Color color) {
    return new Container(
      height: 60.0,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: new CircleAvatar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        child: new Text('$index'),
      ),
    );
  }
}

class SliverObstructionInjector extends SliverOverlapInjector {
  /// Creates a sliver that is as tall as the value of the given [handle]'s
  /// layout extent.
  ///
  /// The [handle] must not be null.
  const SliverObstructionInjector({
    Key key,
    @required SliverOverlapAbsorberHandle handle,
    Widget child,
  })  : assert(handle != null),
        super(key: key, handle: handle, child: child);

  @override
  RenderSliverObstructionInjector createRenderObject(BuildContext context) {
    return new RenderSliverObstructionInjector(
      handle: handle,
    );
  }
}

/// A sliver that has a sliver geometry based on the values stored in a
/// [SliverOverlapAbsorberHandle].
///
/// The [RenderSliverOverlapAbsorber] must be an earlier descendant of a common
/// ancestor [RenderViewport] (probably a [RenderNestedScrollViewViewport]), so
/// that it will always be laid out before the [RenderSliverObstructionInjector]
/// during a particular frame.
class RenderSliverObstructionInjector extends RenderSliverOverlapInjector {
  /// Creates a sliver that is as tall as the value of the given [handle]'s extent.
  ///
  /// The [handle] must not be null.
  RenderSliverObstructionInjector({
    @required SliverOverlapAbsorberHandle handle,
    RenderSliver child,
  })  : assert(handle != null),
        _handle = handle,
        super(handle: handle);

  double _currentLayoutExtent;
  double _currentMaxExtent;

  /// The object that specifies how wide to make the gap injected by this render
  /// object.
  ///
  /// This should be a handle owned by a [RenderSliverOverlapAbsorber] and a
  /// [RenderNestedScrollViewViewport].
  SliverOverlapAbsorberHandle get handle => _handle;
  SliverOverlapAbsorberHandle _handle;
  set handle(SliverOverlapAbsorberHandle value) {
    assert(value != null);
    if (handle == value) return;
    if (attached) {
      handle.removeListener(markNeedsLayout);
    }
    _handle = value;
    if (attached) {
      handle.addListener(markNeedsLayout);
      if (handle.layoutExtent != _currentLayoutExtent || handle.scrollExtent != _currentMaxExtent) markNeedsLayout();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    handle.addListener(markNeedsLayout);
    if (handle.layoutExtent != _currentLayoutExtent || handle.scrollExtent != _currentMaxExtent) markNeedsLayout();
  }

  @override
  void performLayout() {
    _currentLayoutExtent = handle.layoutExtent;
    _currentMaxExtent = handle.layoutExtent;
    geometry = new SliverGeometry(
      scrollExtent: 0.0,
      paintExtent: _currentLayoutExtent,
      maxPaintExtent: _currentMaxExtent,
    );
  }
}