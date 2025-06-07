import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shan_koe_mee_myanmar/card_stack.dart';

class CardShuffleScreen extends StatefulWidget {
  const CardShuffleScreen({super.key});

  @override
  State<CardShuffleScreen> createState() => _CardShuffleScreenState();
}

class _CardShuffleScreenState extends State<CardShuffleScreen>
    with SingleTickerProviderStateMixin {
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

  List<String> cardImages = [];
  final int displayCount = 10;
  late final AnimationController _controller;
  late final List<_CardAnimationData> animationData;

  @override
  void initState() {
    super.initState();
    cardImages = List.from(allCardNames)..shuffle();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Future.delayed(const Duration(milliseconds: 200), () {
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const CardStackScreen()),
                  );
                }
              });
            }
          });
    final rand = Random();
    animationData = List.generate(displayCount, (index) {
      final scatterX = rand.nextDouble() * 300 - 150;
      final scatterY = rand.nextDouble() * 300 - 150;
      final fanAngle = -pi / 6 + (pi / 3) * (index / (displayCount - 1));
      return _CardAnimationData(
        scatterOffset: Offset(scatterX, scatterY),
        gatherOffset: Offset(0, 0),
        fanOffset: Offset(120 * cos(fanAngle), 20 * sin(fanAngle)),
        scatterRotation: (rand.nextDouble() - 0.5) * pi,
        fanRotation: fanAngle,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedCard(String cardName, int index) {
    final data = animationData[index];

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final t = _controller.value;
        Offset offset;
        double rotation;
        double scale;

        if (t < 0.2) {
          // Phase 1: Scatter (0 - 2s)
          final p = t / 0.2;
          offset = Offset.lerp(
            Offset.zero,
            data.scatterOffset,
            Curves.easeOut.transform(p),
          )!;
          rotation = data.scatterRotation * p;
          scale = 0.8 + 0.2 * p;
        } else {
          // Phase 2: Gather to center (2s - 5s)
          final p = ((t - 0.2) / 0.3).clamp(0.0, 1.0);
          offset = Offset.lerp(
            data.scatterOffset,
            Offset.zero,
            Curves.easeInOut.transform(p),
          )!;
          rotation = data.scatterRotation * (1 - p);
          scale = 1.0;
        }

        return Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(scale: scale, child: child),
          ),
        );
      },
      child: Image.asset('assets/card1/$cardName.png', width: 100, height: 140),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = cardImages.take(displayCount).toList();

    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shuffling Cards...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: Colors.black87,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: List.generate(
                displayCount,
                (i) => _buildAnimatedCard(cards[i], i),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: Colors.green[800],
                color: Colors.lightGreenAccent.shade400,
                value: _controller.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardAnimationData {
  final Offset scatterOffset;
  final Offset gatherOffset;
  final Offset fanOffset;
  final double scatterRotation;
  final double fanRotation;

  _CardAnimationData({
    required this.scatterOffset,
    required this.gatherOffset,
    required this.fanOffset,
    required this.scatterRotation,
    required this.fanRotation,
  });
}
