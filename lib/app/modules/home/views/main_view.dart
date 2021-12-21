import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laporku/app/modules/home/controllers/home_controller.dart';
import '/app/routes/app_pages.dart';
import '/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends GetView<HomeController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.subject_rounded,
            ),
          ),
        ),
        backgroundColor: blueColor,
        title: const Text("Laporan"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllLaporan = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllLaporan.length,
              itemBuilder: (context, index) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                      vertical: defaultSmallMargin,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL);
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              child: Image.asset(
                                "assets/dummy.jpg",
                                height: 180,
                                width: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Center(
                              child: Text(
                                "${(listAllLaporan[index].data() as Map<String, dynamic>)["judul"]}",
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.account_circle),
                                          Text(
                                              "${(listAllLaporan[index].data() as Map<String, dynamic>)["nama"]}"),
                                        ],
                                      ),
                                      Text(
                                          "${(listAllLaporan[index].data() as Map<String, dynamic>)["date"]}")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${(listAllLaporan[index].data() as Map<String, dynamic>)["up"]}"),
                                          const Icon(Icons.arrow_circle_up),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.comment,
                                            size: 22.5,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.share,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "•",
                                            style: TextStyle(
                                              color: yellowColor,
                                              fontSize: 36,
                                            ),
                                          ),
                                          Text(
                                              "${(listAllLaporan[index].data() as Map<String, dynamic>)["status"]}"),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
