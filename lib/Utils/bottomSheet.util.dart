import 'package:flutter/material.dart';

class MyBottomSheetContent extends StatefulWidget {
  const MyBottomSheetContent({super.key, required this.onCounterChanged});
  final Function(int) onCounterChanged;

  @override
  _MyBottomSheetContentState createState() => _MyBottomSheetContentState();
}

class _MyBottomSheetContentState extends State<MyBottomSheetContent> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.onCounterChanged(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      int check = _counter - 1;
      if (check < 1) {
        _counter = 1;
      } else {
        _counter--;
      }
      widget.onCounterChanged(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      // padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Quantity'),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              minimumSize: const Size(20, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.red)),
            ),
            onPressed: _decrementCounter,
            child: const Text(
              '-',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Text(
            '$_counter',
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              minimumSize: const Size(20, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.red),
              ),
            ),
            onPressed: _incrementCounter,
            child: const Text(
              '+',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
