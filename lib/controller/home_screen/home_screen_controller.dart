import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insa_demo_abhay/helpers/textfile.dart';
import 'package:insa_demo_abhay/model/insurance_model.dart';
import 'package:insa_demo_abhay/services/api_calls.dart';
import 'package:insa_demo_abhay/services/api_endpoints.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreenController extends GetxController {
  RxInt totalAstrologersCount = 0.obs;
  InsuranceDetailsModel insuranceDetailsModel = InsuranceDetailsModel();
  final insuranceDataList = <InsuranceData>[].obs;
  final isLoadMoreLeads = false.obs;
  final noRecordFound = true.obs;
  final pageNumber = 0.obs;
  RxBool isLoading = false.obs;
  RxString chosenStatusForFilter = "".obs;

  Future<dynamic> getLeadStatus(
      {String? userID, String? status, bool? value}) async {
    isLoading.value = true;
    if (value == false) {
      insuranceDataList.clear();
      isLoadMoreLeads.value = true;
      noRecordFound.value = true;
      pageNumber.value = 1;
    }
    Map<String, String> headers = {};
    headers[HttpHeaders.authorizationHeader] = ConstantStrings.token;
    try {
      final response = await NetworkUtil.getApi(
        "${ApiEndPoints.getLeadDetails}?page=${pageNumber.value}&size=10&userId=$userID${status != null ? "&status=$status" : ""}",
        headers: headers,
      );
      if (response != null) {
        if (response.statusCode == 200) {
          if ((jsonDecode(response.body)["success"]) == true) {
            isLoading.value = false;
            insuranceDetailsModel =
                InsuranceDetailsModel?.fromJson(jsonDecode(response.body));
            List<InsuranceData> tempList = [];
            tempList = insuranceDetailsModel.data!;
            if (tempList.isEmpty || tempList.length < 10) {
              isLoadMoreLeads.value = false;
            } else {
              isLoadMoreLeads.value = true;
            }
            insuranceDataList.addAll(tempList);
            noRecordFound.value = false;
            if (kDebugMode) {
              print(insuranceDataList.value);
            }
          } else {
            isLoading.value = false;
            noRecordFound.value = false;
          }
        } else {
          isLoading.value = false;
          noRecordFound.value = false;
          Get.snackbar(
              margin: EdgeInsets.only(top: 1.h),
              backgroundColor: const Color(0xFFFAAA52).withOpacity(0.5),
              snackPosition: SnackPosition.TOP,
              response.reasonPhrase!,
              jsonDecode(response.body)["message"]);
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
            margin: EdgeInsets.only(top: 1.h),
            backgroundColor: const Color(0xFFFAAA52).withOpacity(0.5),
            snackPosition: SnackPosition.TOP,
            "Error",
            jsonDecode(response!.body)["message"]);
      }
    } catch (error) {
      isLoading.value = false;
      if (kDebugMode) {
        print(error);
      }
    }
    return insuranceDetailsModel;
  }
}
