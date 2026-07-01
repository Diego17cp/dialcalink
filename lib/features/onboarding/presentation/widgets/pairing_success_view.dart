import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widget_previews.dart';

@Preview(
  name: 'Pairing Success View',
  group: 'Onboarding',
)
Widget pairingSuccessViewPreview() {
  return const MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black,
      body: PairingSuccessView(),
    ),
  );
}

class PairingSuccessView extends StatelessWidget {
  const PairingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.green,
                size: 100,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            '¡Emparejamiento exitoso!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Tu dispositivo ahora está sincronizado con el Gateway. Redirigiendo...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 60),
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ]
      )
    );
  }
}