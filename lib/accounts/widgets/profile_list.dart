import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key, required this.context, this.tittle, this.data, this.icon});
  final BuildContext context;
  final IconData? icon;
  final String? tittle;
  final String? data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        color: Colors.black,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tittle ?? "",
                      style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                          ?.copyWith(color: Colors.grey)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(data ?? "",
                      style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                          ?.copyWith(color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
