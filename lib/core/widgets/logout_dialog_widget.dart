import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key, required this.yesOnTap});

  final Function() yesOnTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Logout',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1A1336),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Are you sure, you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(40, 35, 59, 1),
                  fontFamily: 'Figtree',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Gap(18),
            Container(
              width: double.infinity,
              height: 1,
              color: const Color(0xFFBCBCBC),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      yesOnTap();
                    },
                    child: const Text(
                      'Yes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5D5BE9),
                        fontFamily: 'Figtree',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: const Color(0xFFBCBCBC),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'No',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 18, 15, 15),
                        fontFamily: 'Figtree',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
