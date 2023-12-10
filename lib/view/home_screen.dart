import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:insa_demo_abhay/controller/home_screen/home_screen_controller.dart';
import 'package:insa_demo_abhay/dash_seperator.dart';
import 'package:insa_demo_abhay/helpers/gradient_button.dart';
import 'package:insa_demo_abhay/helpers/textfile.dart';
import 'package:insa_demo_abhay/helpers/utility.dart';
import 'package:insa_demo_abhay/model/insurance_model.dart';
import 'package:insa_demo_abhay/view/history_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.put(HomeScreenController());

  var userID = "51d31396-8514-4edc-9897-81873fc79b4b";

  Future<void> getAPI({String? status}) async {
    await homeScreenController.getLeadStatus(
        userID: userID, value: false, status: status);
  }

  final dateFormat = DateFormat('dd-MMMM-yyyy hh:mm:ss');
  final dateFormatForEpoch = DateFormat('dd-MMMM-yyyy');

  @override
  void initState() {
    super.initState();
    getAPI();
  }

  void _showModalBottomSheetComment(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text('Add Comment',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 17.sp)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 1.h, left: 1.h, right: 1.h, bottom: 2.h),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ),
              Center(
                child: Utility.appButton(context, "Save", () {
                  Get.back();
                },
                    fontWeight: FontWeight.w600,
                    width: Get.width / 2,
                    bottomPadding: 1.5.h),
              )
            ],
          ),
        );
      },
    );
  }

  void _showModalBottomSheetStatus(
      BuildContext context, List<StatusHistory> statusHistoryList) {
    showModalBottomSheet(
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text('Status History',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp)),
            ),
            Padding(
                padding: EdgeInsets.all(1.h),
                child: ListView.builder(
                    itemCount: statusHistoryList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, statusIndex) {
                      return Padding(
                        padding: EdgeInsets.all(0.8.h),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              color: Colors.grey.withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Date & Time: ${dateFormat.format(DateTime.parse(statusHistoryList[statusIndex].date!))}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.5.sp),
                                ),
                                Text(
                                  "Status: ${statusHistoryList[statusIndex].currStatus ?? "No Current Status"}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.5.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
            SizedBox(
              height: 2.h,
            )
          ],
        );
      },
    );
  }

  void _showModalBottomSheetPolicyDetails(
      BuildContext context, PolicyTypeDetails policyTypeDetails) {
    showModalBottomSheet(
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text('Policy Details',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp)),
            ),
            Padding(
                padding: EdgeInsets.all(1.h),
                child: Padding(
                  padding: EdgeInsets.all(0.8.h),
                  child: Column(
                    children: [
                      policyTypeDetails.imageUrl != null
                          ? Center(
                              child: Image.network(
                              policyTypeDetails.imageUrl!,
                              height: 8.h,
                            ))
                          : Container(),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: Colors.grey.withOpacity(0.5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Policy name: ${policyTypeDetails.name!} (${policyTypeDetails.hindiName})",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5.sp),
                              ),
                              Text(
                                "Created at: ${dateFormatForEpoch.format(DateTime.fromMicrosecondsSinceEpoch(policyTypeDetails.createdAt!))}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5.sp),
                              ),
                              Text(
                                "Updated at: ${dateFormatForEpoch.format(DateTime.fromMicrosecondsSinceEpoch(policyTypeDetails.updatedAt!))}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5.sp),
                              ),
                              Text(
                                "Is active: ${policyTypeDetails.isActive! == true ? "Yes" : "No"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 2.h,
            )
          ],
        );
      },
    );
  }

  List<String> statusList = ["Pending", "Accepted", "Rejected", "Registered"];

  void sortByBottomSheet(BuildContext context, {String? status}) {
    showModalBottomSheet(
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text('Sort Leads Details',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp)),
            ),
            Padding(
                padding: EdgeInsets.all(1.h),
                child: Padding(
                  padding: EdgeInsets.all(0.8.h),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8, right: 8),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  getAPI();
                                  homeScreenController
                                      .chosenStatusForFilter.value = "";
                                },
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: statusList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                getAPI(
                                                    status: statusList[index]);
                                                homeScreenController
                                                    .chosenStatusForFilter
                                                    .value = statusList[index];
                                              },
                                              child: Text(
                                                statusList[index],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 2.h,
            )
          ],
        );
      },
    );
  }

  Widget headingRow(
      {String? heading, VoidCallback? onTap, bool? hideTopPadding}) {
    return Padding(
      padding: EdgeInsets.only(
          top: hideTopPadding == true ? 0 : 1.2.h,
          bottom: 1.2.h,
          left: 1.2.h,
          right: 1.2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                heading!,
                style:
                    TextStyle(fontSize: 18.5.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(0.w),
                icon: const Icon(Icons.filter_list_outlined),
                onPressed: () {
                  sortByBottomSheet(context);
                },
              ),
              IconButton(
                padding: EdgeInsets.all(0.w),
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  getAPI();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget homeScreenBody() {
    return CustomScrollView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      slivers: [
        SliverAppBar(
          expandedHeight: 6.h,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          title: headingRow(
              heading: "Insurance Leads",
              onTap: () {
                Get.to(() => HistoryScreen());
              }),
          backgroundColor: Colors.white,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
              child: Obx(() => homeScreenController.insuranceDataList.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        ListView.builder(
                            itemCount:
                                homeScreenController.insuranceDataList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _showModalBottomSheetPolicyDetails(
                                      context,
                                      homeScreenController
                                          .insuranceDataList[index]
                                          .policyTypeDetails!);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.5.h, vertical: 0.8.h),
                                  child: PhysicalModel(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFFAAA52)
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  9))),
                                                  height: 5.h,
                                                  width: 5.h,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      homeScreenController
                                                                  .insuranceDataList[
                                                                      index]
                                                                  .policyTypeDetails
                                                                  ?.name ==
                                                              "Health Insurance"
                                                          ? ImageAssets
                                                              .healthInsuranceSVG
                                                          : homeScreenController
                                                                      .insuranceDataList[
                                                                          index]
                                                                      .policyTypeDetails
                                                                      ?.name ==
                                                                  "Life Insurance"
                                                              ? ImageAssets
                                                                  .lifeInsuranceSVG
                                                              : ImageAssets
                                                                  .generalInsuranceSVG,
                                                      height: 2.5.h,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 1.5.w),
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          homeScreenController
                                                              .insuranceDataList[
                                                                  index]
                                                              .name!
                                                              .trim()
                                                              .capitalizeFirst!,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 17.sp),
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      SizedBox(height: 0.5.h),
                                                      homeScreenController
                                                                  .insuranceDataList[
                                                                      index]
                                                                  .mobile !=
                                                              null
                                                          ? Text(
                                                              "+91-${homeScreenController.insuranceDataList[index].mobile!}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.5.sp),
                                                            )
                                                          : Text(
                                                              "No Mobile Number",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.5.sp),
                                                            ),
                                                      SizedBox(height: 0.5.h),
                                                      Text.rich(TextSpan(
                                                          text:
                                                              'Current Status:',
                                                          children: <InlineSpan>[
                                                            TextSpan(
                                                              text:
                                                                  ' ${homeScreenController.insuranceDataList[index].status}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: homeScreenController
                                                                              .insuranceDataList[
                                                                                  index]
                                                                              .status ==
                                                                          'ACCEPTED'
                                                                      ? Colors
                                                                          .green
                                                                      : homeScreenController.insuranceDataList[index].status == 'REJECTED' ||
                                                                              homeScreenController.insuranceDataList[index].status ==
                                                                                  'REJECTED BY EXECUTIVE'
                                                                          ? Colors
                                                                              .red
                                                                          : homeScreenController.insuranceDataList[index].status == 'PENDING' || homeScreenController.insuranceDataList[index].status == 'POLIFYX PENDING'
                                                                              ? Colors.yellow[600]
                                                                              : homeScreenController.insuranceDataList[index].status == 'REGISTERED'
                                                                                  ? Colors.deepPurple
                                                                                  : homeScreenController.insuranceDataList[index].status == 'EXPERT'
                                                                                      ? Colors.blueAccent
                                                                                      : homeScreenController.insuranceDataList[index].status == 'DOCUMENT_PENDING'
                                                                                          ? Colors.yellow[900]
                                                                                          : Colors.black,
                                                                  fontWeight: FontWeight.w400),
                                                            )
                                                          ])),
                                                    ]),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.5.h),
                                            child: DashSeparator(
                                                color: Colors.grey
                                                    .withOpacity(0.6)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 1.h,
                                                right: 1.h,
                                                top: 0.h,
                                                bottom: 1.5.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GradientButton(
                                                  onClicked: (context) {
                                                    _showModalBottomSheetComment(
                                                        context);
                                                  },
                                                  buttonIcon: SvgPicture.asset(
                                                    ImageAssets.addCommentSVG,
                                                    height: 2.2.h,
                                                  ),
                                                  buttonWidth: Get.width / 2.2,
                                                  buttonText: "Add Comment",
                                                  color1:
                                                      const Color(0xFFFFFFFF),
                                                  color2:
                                                      const Color(0xFFFFFFFF),
                                                  color3:
                                                      const Color(0xFFFFFFFF),
                                                  color4:
                                                      const Color(0xFFFAAA52),
                                                  textColor: Colors.black,
                                                ),
                                                GradientButton(
                                                  onClicked: (context) {
                                                    _showModalBottomSheetStatus(
                                                        context,
                                                        homeScreenController
                                                            .insuranceDataList[
                                                                index]
                                                            .statusHistory!);
                                                  },
                                                  buttonIcon: SvgPicture.asset(
                                                    ImageAssets
                                                        .statusHistorySVG,
                                                    height: 2.2.h,
                                                  ),
                                                  buttonWidth: Get.width / 2.2,
                                                  color1:
                                                      const Color(0xFFFFFFFF),
                                                  color2:
                                                      const Color(0xFFFFFFFF),
                                                  color3:
                                                      const Color(0xFFFFFFFF),
                                                  color4:
                                                      const Color(0xFF7297E7),
                                                  buttonText: "Status History",
                                                  textColor: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            }),
                        homeScreenController.isLoading.value == true
                            ? Padding(
                                padding: EdgeInsets.all(1.5.h),
                                child: const CircularProgressIndicator(),
                              )
                            : Visibility(
                                visible:
                                    homeScreenController.isLoadMoreLeads.value,
                                child: GestureDetector(
                                    onTap: () async {
                                      if (homeScreenController
                                          .isLoadMoreLeads.value) {
                                        homeScreenController.pageNumber.value =
                                            homeScreenController
                                                    .pageNumber.value +
                                                1;
                                        await homeScreenController
                                            .getLeadStatus(
                                          status: homeScreenController
                                              .chosenStatusForFilter.value,
                                          value: true,
                                          userID: userID,
                                        );
                                      }
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.all(1.5.h),
                                        child: Text(
                                          "Load More Results",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ))),
                              ),
                      ],
                    ))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Text(
            "Insurance Samadhan",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: homeScreenBody(),
    );
  }
}
