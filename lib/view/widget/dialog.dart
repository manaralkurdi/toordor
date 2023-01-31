import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  MyDialog({Key? key, required this.hasError, this.title, this.content})
      : super(key: key);
  bool hasError;
  String? title;
  String? content;
  bool size = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Dialog(
        // title:
        child: StatefulBuilder(builder: (context, update) {
      Future.delayed(const Duration(seconds: 300))
          .whenComplete(() => update(() => size = true));
      return AnimatedContainer(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        height: size ? h / 1.8 : h / 4,
        width: size ? w / 1.3 : w / 2.3,
        duration: const Duration(seconds: 150),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              content ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                SizedBox(width: hasError?w/4:0),
                Expanded(
                  child: Image.asset(
                    hasError
                        ? 'assets/cross-vermeia.gif'
                        : 'assets/check-mark-verified.gif',
                    alignment: hasError ? const Alignment(-4, 0) : Alignment.center,
                   // height: h / 5,
                    //width: w / 1.3,
                    fit: BoxFit.fitWidth,
                  ),
                ),

              ],
            ),

            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const SizedBox(
                    width: 200, height: 50, child: Center(child: Text('رجوع'))))
          ],
        ),
      );
    }));
  }
}
