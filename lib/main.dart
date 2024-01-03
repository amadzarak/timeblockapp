import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeblockapp/hero_dialog_route.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final List times = [
    '12:00',
    ' 1:00',
    ' 2:00',
    ' 3:00',
    ' 4:00',
    ' 5:00',
    ' 6:00',
    ' 7:00',
    ' 8:00',
    ' 9:00',
    '10:00',
    '11:00'
  ];
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(
        children: [
          const Row(
            children: [
              SizedBox(width: 100),
              Expanded(
                child: Center(child: Text('AM')),
              ),
              Expanded(
                child: Center(child: Text('PM')),
              )
            ],
          ),
          for (int i = 0; i < times.length; i++)
            Row(children: [
              SizedBox(
                width: 100,
                child: ListTile(
                  title: Text(
                    times[i],
                    style: GoogleFonts.spaceMono(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: singleTimeCard(time: i),
              ),
              Expanded(
                flex: 1,
                child: singleTimeCard(time: (i + 12)),
              ),
            ]),
        ],
      )),
    );
  }
}

class singleTimeCard extends StatefulWidget {
  singleTimeCard({required this.time});

  final int time;

  @override
  State<singleTimeCard> createState() => _singleTimeCardState();
}

class _singleTimeCardState extends State<singleTimeCard> {
  bool displayDraggable = false;

  void initState() {
    bool displayDraggable = false;
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      Container(
          decoration: BoxDecoration(
            border: (displayDraggable == true)
                ? Border(
                    top: BorderSide(width: 3.0, color: Colors.blue),
                    left: BorderSide(width: 3.0, color: Colors.blue),
                    right: BorderSide(width: 3.0, color: Colors.blue),
                    bottom: BorderSide(width: 3.0, color: Colors.blue),
                  )
                : null,
          ),
          child: Card(
              child: ListTile(
            key: UniqueKey(),
            onTap: () {
              String display;

              (widget.time > 12)
                  ? display = (widget.time - 12).toString() + ':00 PM'
                  : display = widget.time.toString() + ':00 AM';

              Navigator.of(context).push(
                HeroDialogRoute(
                  builder: (context) => Center(
                    child: _TodoPopupCard(time: display),
                  ),
                ),
              );
            },
            onLongPress: () {
              setState(() {
                displayDraggable = true;
              });
            },
          ))),
      if (displayDraggable == true)
        IconButton(
          iconSize: 10,
          icon: Icon(Icons.add),
          onPressed: () => print('hi'),
        )
    ]);
  }
}

class _TodoPopupCard extends StatelessWidget {
  _TodoPopupCard({Key? key, required this.time}) : super(key: key);
  String time;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: time,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(time),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        maxLines: 8,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Write a note...',
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
