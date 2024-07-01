import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showDivisionSelectionBottomSheet({
  required BuildContext context,
  required List<String> divisionList,
  String? selectedItem,
  ValueChanged<int>? onSelected,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return DivisionSelectionBottomSheet(
        divisionList: divisionList,
        selectedItem: selectedItem,
        onSelected: onSelected,
      );
    },
  );
}

class DivisionSelectionBottomSheet extends StatelessWidget {
  const DivisionSelectionBottomSheet({
    required this.divisionList,
    super.key,
    this.selectedItem,
    this.onSelected,
  });

  final List<String> divisionList;
  final String? selectedItem;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select Division',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.appColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const Gap(2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select a division to enter daily noon meal counts of the students',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.commentTextColor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: divisionList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio:
                      2, // Aspect ratio of each item (width / height)
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = divisionList[index];
                  return GestureDetector(
                    onTap: () {
                      onSelected?.call(index);
                      Navigator.pop(
                        context,
                      ); // Close bottom sheet when an item is tapped
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedItem == item
                              ? AppColors.green
                              : AppColors.appColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
