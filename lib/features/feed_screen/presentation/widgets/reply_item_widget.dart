import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../domain/entity/reply_entity.dart';

class ReplyItemWidget extends StatelessWidget {
  const ReplyItemWidget({super.key, required this.data});

  final ReplyDataEntity data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CustomNetworkImage(
              imageUrl: data.userEntity.profilePic,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.userEntity.fullName,
                              style: const TextStyle(fontFamily: 'Figtree', fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              data.commentTxt,
                              style: const TextStyle(
                                fontFamily: 'Figtree',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_horiz_outlined)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
