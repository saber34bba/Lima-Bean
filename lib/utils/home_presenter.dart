import 'package:flutter/material.dart';
import 'package:limabean/utils/limaModel.dart';
import 'package:limabean/utils/rest_api.dart';

class HomePresenter extends ChangeNotifier {
  String contentUrl = "https://baconipsum.com/api/?type=meat-and-filler";
  String imageUrl = "https://picsum.photos/200/300/?";
  RestApi restApi = RestApi();

  List<LimaModel> linaModel_list = [];
  bool isLoading = false;
  fetchData() async {
    isLoading = true;
    Map<dynamic, dynamic> data = await restApi.getData(contentUrl);
    isLoading = false;
    notifyListeners();
    if (data.containsKey(200)) {
      List<dynamic> _content = data[200];
      if (_content.isNotEmpty) {
        for (int i = 0; i < _content.length; i++) {
          LimaModel limaModel = LimaModel();
          limaModel.text = _content[i];
          limaModel.image = imageUrl + "${DateTime.now().microsecond}";
          addLima(limaModel);
        }
      }
    } else {}
  }

  addLima(LimaModel _lima) {
    linaModel_list.add(_lima);
    notifyListeners();
  }

  refreshContents() {
    linaModel_list.clear();
    notifyListeners();
    fetchData();
  }
}
