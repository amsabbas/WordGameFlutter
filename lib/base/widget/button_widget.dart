import 'package:flutter/material.dart';

import '../controller/audio_controller.dart';
import '../injection/general_injection.dart';
import '../style/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final IconData iconData;
  final Function buttonAction;

  const ButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.buttonAction,
      required this.iconData,
      required this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 65,
        width: double.infinity,
        child: Card(
          color: buttonColor,
          child: TextButton(
            onPressed: () async {
              getIt<AudioController>().playButtonClickAudio();
              buttonAction.call();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    iconData,
                    color: AppColors.whiteColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    buttonText,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 20, color: AppColors.whiteColor, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
