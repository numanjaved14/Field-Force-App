import 'package:field_force_app/base/models/Product_model.dart';
import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';
import '../../../../home/view/home.dart';
import '../repository/new_product_repository.dart';
import '../repository/update_product_repository.dart';

class NewProductController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newProductRepo = NewProductRepository();
  var updateProductRepo = UpdateProductRepository();

  Rx<TextEditingController> productName = TextEditingController().obs;
  Rx<TextEditingController> productDescription = TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Product') {
      productName.value.text = data[1].name;
      productDescription.value.text = data[1].description;
    }
  }

  onNewProductPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (productName.value.text.isNotEmpty &&
        productDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newProductRepo.addNewProduct(
          productName: productName.value.text,
          productDescription: productDescription.value.text,
        );
        showProgress.value = false;
        ProductModel res = ProductModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Product Added',
                  subtitle: 'Product Added Successfully')
              .getSnackbar();
        }
      } catch (error) {
        print(error.toString());
      }
    } else {
      MySnackBar(
              title: 'Input All Fields!',
              subtitle: 'Please input all fields correctly!')
          .getSnackbar();
    }
  }

  onUpdateProductPressed() async {
    if (productName.value.text.isNotEmpty &&
        productDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateProductRepo.updateProduct(
          productID: data[1].id,
          productName: productName.value.text,
          productDescription: productDescription.value.text,
          activeStatus: data[1].active,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Product Updated',
                  subtitle: 'Product Updated Successfully')
              .getSnackbar();
        }
      } catch (error) {
        print(error.toString());
      }
    } else {
      MySnackBar(
              title: 'Input All Fields!',
              subtitle: 'Please input all fields correctly!')
          .getSnackbar();
    }
  }

  @override
  void onClose() {
    productName.value.dispose();
    productDescription.value.dispose();
    super.onClose();
  }
}
