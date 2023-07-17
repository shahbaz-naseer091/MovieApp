import 'package:flutter/material.dart';
import 'package:learn_movie_app/screens/movie_selection.dart';

import 'package:learn_movie_app/utils/extensions.dart';
import 'package:learn_movie_app/widgets/circular_icon_button.dart';
import 'package:learn_movie_app/widgets/icon_text.dart';

class TicketPayment extends StatelessWidget {
  String? movieName;
  String? releaseDateAndHall;

  TicketPayment(
      {required this.movieName, required this.releaseDateAndHall, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              header(context),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(
                      children: [cinemaSeats(), actionButtons()],
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        seatsInfo(),
                        const Spacer(),
                        bottomActionButtons(context)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Container header(BuildContext context) {
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
                        movieName ?? "",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        releaseDateAndHall ?? "",
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

  Container cinemaSeats() {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      alignment: Alignment.center,
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

  Widget actionButtons() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 25, 10),
        color: Colors.grey[200],
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircularIconButton(
              icon: Icons.add,
              onPress: () {},
            ),
            const SizedBox(
              width: 10,
            ),
            CircularIconButton(
              icon: Icons.remove,
              onPress: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget seatsInfo() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 0),
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: double.infinity / 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconText(
                    title: "Selected",
                    icon: Icons.event_seat,
                    iconColor: Colors.orange,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconText(
                    title: "Not Available",
                    icon: Icons.event_seat,
                    iconColor: Colors.grey,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconText(
                    title: "VIP (\$150)",
                    icon: Icons.event_seat,
                    iconColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconText(
                    title: "Regular (\$50)",
                    icon: Icons.event_seat,
                    iconColor: Colors.blue,
                  )
                ],
              ),
            ]),
      ),
    );
  }

  Widget bottomActionButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "500 \$",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    )
                  ]),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                context.pushAndClearStack(MovieSelection());
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.blue),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
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
