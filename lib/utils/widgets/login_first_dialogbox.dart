import 'package:evika/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loginFirstDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
          content: Container(
            width: Get.width,
            height: 220,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                const Icon(Icons.error_outline_outlined,
                    color: Color.fromARGB(255, 165, 60, 52), size: 65),
                const Text(
                  "Login First",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You need to login to access this feature",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(26)),
                    child: Center(
                      child: InkWell(
                          onTap: () {
                            Get.off(() => SigninPage());
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor))),
                    ))
              ],
            ),
          ),
        );
      });
}

void showDialogBox(context, String? title, String? msg, bool showBtn) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
          content: Container(
            width: Get.width,
            height: 210,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                const Icon(Icons.error_outline_outlined,
                    color: Color.fromARGB(255, 165, 60, 52), size: 65),
                Text(
                  title ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  msg ?? "",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                showBtn
                    ? InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                            height: 45,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(26)),
                            child: Center(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor),
                              ),
                            )),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      });
}
