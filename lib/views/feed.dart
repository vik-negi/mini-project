import 'package:evika/models/user/post_model.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:evika/utils/widgets/post_container_widget.dart';
import 'package:get/get.dart';

// this page has only the UI of that page
class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Post"),
      ),
      body: GetBuilder<PostVM>(builder: (vm) {
        return SingleChildScrollView(
            child: Container(
          // height: Get.height - 100,
          child: Column(
            children: [
              SizedBox(
                height: Get.height - 150,
                child: FutureBuilder(
                  future: vm.futurePosts,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return PostContainer(postData: snapshot.data[i]);
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    List<PostData>? post = await vm.getAllPost();
                    print(post![0].description);
                  },
                  child: Text("Click")),
            ],
          ),
        ));
      }), //kk
    );
  }
}
