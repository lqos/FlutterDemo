import 'package:example01/utils/utils.dart';
import 'package:flutter/material.dart';

typedef LoadData = Future Function(int page, int pageSize);
typedef ItemView = Widget Function(int index, Object obj);

class ListViewMore extends StatefulWidget {
  ///每页加载数量
  final int pageSize;

  ///加载回调
  final LoadData loadData;

  ///item渲染
  final ItemView itemView;

  ///是否可以加载更多
  final bool isLoadMore;

  ///数据为空时显示，只有第一次加载(或者页数为1)
  final Widget emptyWidget;

  const ListViewMore(this.loadData, this.itemView,
      {Key key, this.pageSize, this.isLoadMore, this.emptyWidget})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListViewMoreState();
  }
}

class ListViewMoreState extends State {
  ListViewMore _listViewMore;

  ///存储数据
  List data;

  ///是否处于正在加载中
  bool isLoading = false;

  ///当前页数
  int curPage = 1;

  ///是否允许加载更多，默认为true
  bool isLoadMore = true;

  ///listView滑动控制器
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _listViewMore = widget;
    data = [];
    _onRefresh();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (isLoadMore &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        toLoadData(curPage + 1);
      }
      LoggerUtils.p('p = ' + _scrollController.position.pixels.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data != null && data.length > 0) {
      return RefreshIndicator(
          child: ListView.builder(

            ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return _listViewMore.itemView(index, data[index]);
            },
            itemCount: data.length,
            controller: _scrollController,
          ),
          onRefresh: _onRefresh);
    } else {
      if (_listViewMore.emptyWidget != null) {
        return _listViewMore.emptyWidget;
      } else {
        return new Container(
          child: new Center(
            child: InkWell(
              child: Text("数据为空,点击刷新"),
              onTap: () {
                _onRefresh();
              },
            ),
          ),
        );
      }
    }
  }

  ///刷新数据
  Future<Null> _onRefresh() async {
    if (!isLoading) {
      curPage = 1;
      toLoadData(curPage);
    }
    return null;
  }

  ///加载数据
  toLoadData(int page) async {
    if (!isLoading) {
      isLoading = true;
      List list = await _listViewMore.loadData(page, _listViewMore.pageSize);
      if (list != null && list.length > 0 && page == 1) {
        data.clear();
      }
      data.addAll(list);
      //处理页数
      if (page != 1) {
        if (list != null && list.length > 0) {
          this.curPage = page;
          if (list.length < _listViewMore.pageSize) {
            LoggerUtils.p("已加载全部数据");
          }
        }
      }
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
