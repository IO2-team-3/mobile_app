import 'package:flutter/material.dart';

class ModalProgressIndicator extends StatelessWidget {
  final bool inAsyncCall;
  final Widget child;
  const ModalProgressIndicator({
    super.key,
    required this.inAsyncCall,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    return Stack(
      children: [
        child,
        const Opacity(
          opacity: 0.2,
          child: ModalBarrier(dismissible: false),
        ),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
