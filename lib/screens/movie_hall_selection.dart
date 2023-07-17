import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_movie_app/utils/extensions.dart';

import 'ticket_payment.dart';

// ignore: must_be_immutable
class MovieHall extends StatelessWidget {
  String? movieName;
  String? releaseDate;

  MovieHall({required this.movieName, required this.releaseDate, super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
            color: Colors.white38,
            child: Column(
              children: [
                topContainer(context),
                Expanded(
                  child: bottomContainer(context),
                )
              ],
            )),
      ),
    );
  }

  Container topContainer(BuildContext context) {
    return Container(
        height: 90,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    context.popWidget();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        movieName!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        releaseDate!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 14),
                      )
                    ]),
              )
            ],
          ),
        ));
  }

  bottomContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      width: double.infinity,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dates",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 35,
            child: getDates(),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 350,
            child: theaterInfo(),
          ),
          const Spacer(),
          Center(
              child: SizedBox(
            width: double.infinity,
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                context.pushToNextScreen(TicketPayment(
                  movieName: movieName,
                  releaseDateAndHall: "$releaseDate | CineTech Hall 1",
                ));
              },
              child: const Text("Select Seats"),
            ),
          ))
        ],
      ),
    );
  }

  ListView getDates() {
    final List<String> dates = [
      '1 Jan',
      '2 Jan',
      '3 Jan',
      '4 Jan',
      '5 Jan',
      '6 Jan',
      '7 Jan',
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dates.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            width: 55,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: index == 0 ? Colors.blue : Colors.grey[400],
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                dates[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  ListView theaterInfo() {
    List theater = [
      'CineTech Hall 1',
      'CineTech Hall 2',
      'CineTech Hall 3',
      'CineTech Hall 4',
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: theater.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.pushToNextScreen(TicketPayment(
              movieName: movieName,
              releaseDateAndHall: "$releaseDate | ${theater[index]}",
            ));
          },
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "13:00 | ${theater[index]}",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                seatView(theater, index),
                const Text(
                  "From 10.00\$ or 1000 bonus",
                  style: TextStyle(fontSize: 13.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container seatView(List<dynamic> theater, int index) {
    return Container(
      width: 300,
      height: 250,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: Colors.blue),
          borderRadius: BorderRadius.circular(5)),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Stack(children: [
          CurvedLine(),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Sreen",
                  style: TextStyle(fontSize: 16),
                ),
              )),
          SeatView(),
        ]),
      ),
    );
  }
}

class SeatView extends StatelessWidget {
  const SeatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.fromLTRB(15, 40, 15, 15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 10,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.event_seat,
              size: 12,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}

class CurvedLine extends StatelessWidget {
  const CurvedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0 * 3.14,
      child: CustomPaint(
        painter: _CustomLinePainter(),
        size: const Size(double.infinity, 100),
      ),
    );
  }
}

class _CustomLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
