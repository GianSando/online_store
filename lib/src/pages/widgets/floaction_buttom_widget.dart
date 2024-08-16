import 'package:flutter/material.dart';
import 'package:online_store_tk/src/pages/admin/admin_page.dart';
import 'package:online_store_tk/src/utils/app_colors.dart';

class FloactionButtomWidget extends StatelessWidget {
  final dynamic userData;
  const FloactionButtomWidget({super.key, this.userData});
  @override
  Widget build(BuildContext context) {
    return userData['rol'] == 'admin'
        ? FloatingActionButton(
            foregroundColor: AppColors.text,
            backgroundColor: AppColors.oscureColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(
                    userData: userData,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.add_rounded,
              size: 35,
            ),
          )
        : Container();
  }
}
