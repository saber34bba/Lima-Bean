import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limabean/utils/home_presenter.dart';
import 'package:limabean/utils/limaModel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  late HomePresenter homePresenter;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<HomePresenter>(context, listen: false).fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homePresenter = Provider.of<HomePresenter>(context);
    return GestureDetector(
      onTap: () {
        Provider.of<HomePresenter>(context, listen: false).fetchData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("LimaBean"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: !homePresenter.isLoading
            ? RefreshIndicator(
                onRefresh: () async {
                  _refreshData();
                },
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: homePresenter.linaModel_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      LimaModel limaModel = homePresenter.linaModel_list[index];
                      return itemWidget(limaModel);
                    }),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget itemWidget(LimaModel _limaModel) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 25),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  _limaModel.image ?? "",
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _limaModel.text ?? "",
            style: TextStyle(color: Colors.black45),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  _refreshData() async {
    await Future.delayed(Duration(seconds: 1));
    Provider.of<HomePresenter>(context, listen: false).refreshContents();
  }
}
