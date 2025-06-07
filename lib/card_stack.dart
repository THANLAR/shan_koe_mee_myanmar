import 'dart:math';
import 'package:flutter/material.dart';

class CardStackScreen extends StatefulWidget {
  const CardStackScreen({super.key});

  @override
  State<CardStackScreen> createState() => _CardStackScreenState();
}

class _CardStackScreenState extends State<CardStackScreen> {
  final List<String> allCardNames = [
    '10_of_clubs',
    '10_of_diamonds',
    '10_of_hearts',
    '10_of_spades',
    '2_of_clubs',
    '2_of_diamonds',
    '2_of_hearts',
    '2_of_spades',
    '3_of_clubs',
    '3_of_diamonds',
    '3_of_hearts',
    '3_of_spades',
    '4_of_clubs',
    '4_of_diamonds',
    '4_of_hearts',
    '4_of_spades',
    '5_of_clubs',
    '5_of_diamonds',
    '5_of_hearts',
    '5_of_spades',
    '6_of_clubs',
    '6_of_diamonds',
    '6_of_hearts',
    '6_of_spades',
    '7_of_clubs',
    '7_of_diamonds',
    '7_of_hearts',
    '7_of_spades',
    '8_of_clubs',
    '8_of_diamonds',
    '8_of_hearts',
    '8_of_spades',
    '9_of_clubs',
    '9_of_diamonds',
    '9_of_hearts',
    '9_of_spades',
    'ace_of_clubs',
    'ace_of_diamonds',
    'ace_of_hearts',
    'ace_of_spades',
    'jack_of_clubs',
    'jack_of_diamonds',
    'jack_of_hearts',
    'jack_of_spades',
    'queen_of_clubs',
    'queen_of_diamonds',
    'queen_of_hearts',
    'queen_of_spades',
    'king_of_clubs',
    'king_of_diamonds',
    'king_of_hearts',
    'king_of_spades',
  ];
  final List<String> _cardImages = [];

  @override
  initState() {
    super.initState();
    allCardNames.shuffle();
    _cardImages.addAll(
      allCardNames.take(2).map((name) => 'assets/card1/$name.png'),
    );
  }

  Offset _dragOffset = Offset.zero;
  double _rotation = 0.0;
  final int _topIndex = 0;
  Offset _bottomPostion = Offset.zero;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      _rotation = _dragOffset.dx / 300;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;
    if (velocity.abs() > 500 || _dragOffset.dx.abs() > 150) {
      setState(() {
        _dragOffset += Offset(_dragOffset.dx > 0 ? 500 : -500, 0);
      });

      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          _dragOffset = Offset.zero;
          _rotation = 0.0;
        });
      });
    } else if (_dragOffset.distance > 300) {
      setState(() {
        _dragOffset = Offset(60, 70);
        _bottomPostion = Offset.zero;
        _rotation = 0.0;
      });
    }
  }

  Widget _buildCard(int index) {
    final isTop = index == _topIndex;
    final nextCard = (index == (_topIndex + 1) % _cardImages.length);

    final scale = isTop
        ? 1.0
        : nextCard
        ? 0.95
        : 0.9;
    final translateY = isTop
        ? 0.0
        : nextCard
        ? 20.0
        : 40.0;

    return Transform.scale(
      scale: scale,
      child: Transform.translate(
        offset: Offset(0, translateY),
        child: GestureDetector(
          onPanUpdate: isTop ? _onPanUpdate : null,
          onPanEnd: isTop ? _onPanEnd : null,
          child: Transform.translate(
            offset: isTop ? _dragOffset : _bottomPostion,
            child: Transform.rotate(
              angle: isTop ? _rotation * pi / 12 : 0,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: 270,
                  height: 400,
                  child: Image.asset(_cardImages[index], fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/longyi_texture_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 50,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _dragOffset = Offset(60, 70);
                      _bottomPostion = Offset.zero;
                      _rotation = 0.0;
                    });
                  },
                  child: Text("Show the Cards"),
                ),
              ),
              ...List.generate(_cardImages.length, (index) {
                int displayIndex = (_topIndex + index) % _cardImages.length;
                return _buildCard(displayIndex);
              }).reversed,
              SizedBox.expand(),
              Positioned(
                bottom: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      45,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _dragOffset = Offset.zero;
                      _rotation = 0.0;
                      _bottomPostion = Offset.zero;
                      allCardNames.shuffle();
                      _cardImages.clear();
                      _cardImages.addAll(
                        allCardNames
                            .take(2)
                            .map((name) => 'assets/card1/$name.png'),
                      );
                    });
                  },
                  child: const Text('Shuffle Cards'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
