import 'package:flutter/material.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';

class SearchSwitch extends StatelessWidget {
  const SearchSwitch({
    super.key,
    required this.onFindTypeSelected,
  });

  final Function(FindType findType) onFindTypeSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).unfocus();
        showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.black,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
            ),
            builder: (context) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20),
                child: Wrap(
                  children: [
                    Column(
                      children:  [

                        Container(
                          height: 3,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          onTap: (){
                            Navigator.pop(context);
                            onFindTypeSelected(FindType.title);
                          },
                          title: const Text(
                            'Title',
                            style: AppTextStyles.kH3Lightx1,
                          ),
                        ),
                        const Divider(color: AppColors.white,),
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          onTap: (){
                            Navigator.pop(context);
                            onFindTypeSelected(FindType.date);
                          },
                          title: const Text(
                            'Date',
                            style: AppTextStyles.kH3Lightx1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Search by',style: AppTextStyles.kB2,),
          SizedBox(width: 3,),
          Icon(Icons.arrow_drop_down_outlined,color: AppColors.white,),
          SizedBox(width: 12,),

        ],
      ),
    );
  }
}
enum FindType{
  title,
  date
}