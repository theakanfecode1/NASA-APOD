import 'package:flutter/material.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';
import 'package:nasa_apod/view/components/search_switch.dart';

class ApodSearchFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onChange;
  final Function(String) onSubmit;
  final Function(FindType) onFindTypeSelected;
  final VoidCallback onClear;
  final VoidCallback onSelectDate;

  const ApodSearchFormField(
      {Key? key,
      required this.textEditingController,
      required this.onFindTypeSelected,
      required this.onChange,
      required this.onClear,
      required this.onSelectDate,
      required this.onSubmit})
      : super(key: key);

  @override
  State<ApodSearchFormField> createState() => _ApodSearchFormFieldState();
}

class _ApodSearchFormFieldState extends State<ApodSearchFormField> {
  FindType _findType = FindType
      .title; // default value is FindType.title. Value can change based on user interaction with the search switch

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.blue,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _findType == FindType.title? null: widget.onSelectDate,
              child: TextFormField(
                controller: widget.textEditingController,
                cursorColor: AppColors.white,
                textAlignVertical: TextAlignVertical.center,
                enabled: _findType != FindType.date,
                maxLines: 1,
                onChanged: widget.onChange,
                style: AppTextStyles.kB1,
                onFieldSubmitted: widget.onSubmit,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(right: 10, top: 12, bottom: 12),
                    hintText:
                        "Search by ${_findType == FindType.title ? 'title' : 'date'}",
                    isDense: true,
                    hintStyle: AppTextStyles.kB1,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        Icons.search,
                        color: AppColors.white,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          widget.textEditingController.text.trim().isEmpty
              ? SearchSwitch(onFindTypeSelected: (findType) {
                  setState(() {
                    _findType = findType;
                  });
                  widget.onFindTypeSelected(findType);
                })
              : IconButton(
                  onPressed: widget.onClear,
                  constraints: const BoxConstraints(),
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.cancel_rounded,
                    size: 18,
                    color: AppColors.white,
                  ))
        ],
      ),
    );
  }
}
