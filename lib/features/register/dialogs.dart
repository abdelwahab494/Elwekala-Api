
import 'package:flutter/material.dart';
import 'package:products_api/core/manager/app_sizes.dart';

class Dialogs {

  static Future<bool?> showDeletAlertDialog({
    required BuildContext context,
    required String title,
    required String contentText,
    required String action,
  }) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: AppSizes.sp24),
          content: Text(contentText),
          contentTextStyle: Theme.of(context).textTheme.titleSmall,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.sp16,
                ),
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.sp16,
                ),
              ),
              child: Text(action),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w25,
            AppSizes.h12,
            AppSizes.w25,
            AppSizes.h12,
          ),
          actionsPadding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w25,
            AppSizes.h0,
            AppSizes.w25,
            AppSizes.h16,
          ),
        );
      },
    );
  }



  static Future<ImageActionsEnum?> showImageSourceDialog({
    required BuildContext context,
  }) async {
    return showDialog<ImageActionsEnum?>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(ImageActionsEnum.camera);
              },
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w16,
                vertical: AppSizes.h16,
              ),
              child: Row(
                spacing: AppSizes.w16,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).primaryColor,
                    size: AppSizes.r22,
                  ),
                  Text(
                    "Open Camera",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(ImageActionsEnum.gallery);
              },
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w16,
                vertical: AppSizes.h16,
              ),
              child: Row(
                spacing: AppSizes.w16,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    color: Theme.of(context).primaryColor,
                    size: AppSizes.r22,
                  ),
                  Text(
                    "Choose From Gallery",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h8,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        elevation: 0,
      ),
    );
  }
}

enum ImageActionsEnum {
  gallery(icon: Icons.photo_library_outlined, title: "Choose From Gallery"),
  camera(icon: Icons.camera_alt_outlined, title: "Open Camera"),
  delete(icon: Icons.delete, title: "Remove Image");

  final IconData icon;
  final String title;

  const ImageActionsEnum({required this.icon, required this.title});
}
