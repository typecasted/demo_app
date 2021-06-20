

import 'package:demo_app/Model/data_model.dart';
import 'package:demo_app/utils/remote_service.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  var isLoading = true.obs;
  var dataList = <DataModel>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await RemoteServices.fetchData();
      if (data != null) {
        dataList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }
}