
import 'package:antrakuserinc/data/model/get_all_order_model/get_all_order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/repository.dart';

class OrderHistoryController extends GetxController with StateMixin<GetAllOrderModel> {
  final DateFormat dateFormatter = DateFormat('MM/dd/yyyy');
  var addDate = DateTime.now().subtract(Duration(days: 15)).toString().obs;
  var addDate2 = DateTime.now().add(Duration(days: 15)).toString().obs;
  final _repository = Repository();


  updateDate(var date) {
    addDate.value = date;
    getOrderHistory();
    update();
  }

  updateDate2(var date) {
    addDate2.value = date;
    getOrderHistory();
    update();
  }


  // Future<GetAllOrderModel>  getOrderHistory() async{
  //   GetAllOrderModel getAllOrderModel= await _repository.getOrderHistoryRepo(from: addDate.toString(), to: addDate2.toString());
  //   change(getAllOrderModel, status: RxStatus.success());
  //   return getAllOrderModel;
  // }

  getOrderHistory() async {
    try {
      await _repository.getOrderHistoryRepo(from: addDate.toString(), to: addDate2.toString()).then((getAllOrderModel) {
        change(getAllOrderModel, status: RxStatus.success());
      }, onError: (err) {
        change(
          null,
          status: RxStatus.error(err.toString()),
        );
      });
    } catch (e) {
      Get.snackbar(
          "Error", e.toString().replaceAll('Error:', "Something Went Wrong"));
    }
  }



  @override
  void onInit() {

    DateTime addDateVar = DateTime.now().subtract(Duration(days: 15));
    DateTime addDateVar2 =  DateTime.now().add(Duration(days: 15));
    addDate = dateFormatter.format(addDateVar).obs;
    addDate2 = dateFormatter.format(addDateVar2).obs;
    getOrderHistory();
    // TODO: implement onInit
    super.onInit();
  }
}
