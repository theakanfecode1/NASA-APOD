import 'package:flutter/material.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';

class ReadMoreText extends StatefulWidget {
  final String text;

  const ReadMoreText({Key? key, required this.text}) : super(key: key);

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  var showAll = false;
  final length = 150;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        TextSpan(
      style: AppTextStyles.kB1,
      children: <InlineSpan>[
        TextSpan(
            text: widget.text.length > length && !showAll
                ? "${widget.text.substring(0, length)}... "
                : widget.text),
        widget.text.length > length
            ? WidgetSpan(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  child: Text(
                    showAll ? ' read less' : ' read more!',
                    style: AppTextStyles.kH3Lightx1,
                  ),
                ),
              )
            : const TextSpan(),
      ],
    ),
      textAlign: TextAlign.left,

    );
  }
}
