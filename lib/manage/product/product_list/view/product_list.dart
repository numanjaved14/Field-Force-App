import 'package:field_force_app/manage/product/product_list/view_model/product_list_controller.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../../new_product/view/new_product.dart';

class ProductList extends GetView<ProductListController> {
  ProductList({Key? key}) : super(key: key);

  var productListController = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/appbar_back.png',
              width: 25,
              height: 18,
              // color: const Color(0xFFD4D4D4),
            ),
            onPressed: () => Get.off(() => ManageMain()),
          ),
          actions: [
            productListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      productListController.resetSearch();
                    },
                  )
                : IconButton(
                    icon: Image.asset(
                      'assets/icons/search.png',
                      width: 25,
                      height: 18,
                      // color: const Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      productListController.isSearch.value =
                          !productListController.isSearch.value;
                      productListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: productListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      productListController.searchController.value,
                  hint: 'Search by Product Name',
                  onChange: () => productListController.onSearchChange(),
                  onFieldSubmit: () => productListController.resetSearch(),
                  focusNode: productListController.searchFocus,
                )
              : const Text(
                  'Products',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          backgroundColor: const Color(0x10F5F5F5),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 0.5,
                color: const Color(0xFFE2E2E2),
              ),
              const DateContainer(),
              Container(
                height: 0.5,
                color: const Color(0xFFE2E2E2),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                  top: 25.0,
                  bottom: 10.0,
                ),
                child: productListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: productListController.productList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Products found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: productListController
                                    .productList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: productListController
                                        .productList.value![index].name,
                                    subTitle: productListController
                                        .productList.value![index].description,
                                    iconPath: 'assets/icons/product.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      productListController
                                              .permissionsList.value
                                              .contains('CanUpdateProduct')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewProduct(),
                                                  arguments: [
                                                    'Update Product',
                                                    productListController
                                                        .productList
                                                        .value![index]
                                                  ]);
                                              if (res == 'success') {
                                                productListController
                                                    .getProductList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Product.')
                                              .getSnackbar();
                                    },
                                    iconColor: const Color(0xFFDE0C15),
                                  ),
                                ),
                              ),
                      )
                    : const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: controller.isInit.value
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 25.0,
                ),
                child: productListController.permissionsList.value
                        .contains('CanAddProduct')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewProduct(),
                              arguments: ['Add Product']);
                          if (res == 'success') {
                            productListController.getProductList();
                          }
                        },
                        text: 'Create New Product',
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }
}
