import 'dart:math';
import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';

class DiceWidget extends StatefulWidget {
  final double size;
  final bool isRolling;
  final int value;
  final VoidCallback? onRollComplete;

  const DiceWidget({
    super.key,
    this.size = AppSizes.diceMedium,
    this.isRolling = false,
    this.value = 1,
    this.onRollComplete,
  });

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _displayValue = 1;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _displayValue = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _displayValue = widget.value;
        });
        widget.onRollComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(DiceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRolling && !oldWidget.isRolling) {
      _startRolling();
    }
  }

  void _startRolling() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Random value during roll
        if (_controller.isAnimating) {
          _displayValue = _random.nextInt(6) + 1;
        }

        final rotation = _controller.value * 4 * pi;
        final scale = 1.0 + (_controller.value * 0.2);

        return Transform.scale(
          scale: widget.isRolling
              ? scale * (1.0 - _controller.value * 0.2)
              : 1.0,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(rotation)
              ..rotateY(rotation)
              ..rotateZ(rotation * 0.5),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: AppColors.diceWhite,
                borderRadius: BorderRadius.circular(widget.size * 0.15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.diceShadow,
                    blurRadius: widget.size * 0.2,
                    offset: Offset(0, widget.size * 0.1),
                  ),
                ],
              ),
              child: _buildDiceFace(_displayValue),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiceFace(int value) {
    final dotSize = widget.size * 0.12;
    final padding = widget.size * 0.2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final positions = _getDotPositions(
          value,
          constraints.maxWidth,
          padding,
        );

        return Stack(
          children: positions.map((position) {
            return Positioned(
              left: position.dx - dotSize / 2,
              top: position.dy - dotSize / 2,
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: const BoxDecoration(
                  color: AppColors.diceDot,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  List<Offset> _getDotPositions(int value, double size, double padding) {
    final center = size / 2;
    final offset = size / 2 - padding;

    switch (value) {
      case 1:
        return [Offset(center, center)];
      case 2:
        return [
          Offset(center - offset, center - offset),
          Offset(center + offset, center + offset),
        ];
      case 3:
        return [
          Offset(center - offset, center - offset),
          Offset(center, center),
          Offset(center + offset, center + offset),
        ];
      case 4:
        return [
          Offset(center - offset, center - offset),
          Offset(center + offset, center - offset),
          Offset(center - offset, center + offset),
          Offset(center + offset, center + offset),
        ];
      case 5:
        return [
          Offset(center - offset, center - offset),
          Offset(center + offset, center - offset),
          Offset(center, center),
          Offset(center - offset, center + offset),
          Offset(center + offset, center + offset),
        ];
      case 6:
        return [
          Offset(center - offset, center - offset),
          Offset(center + offset, center - offset),
          Offset(center - offset, center),
          Offset(center + offset, center),
          Offset(center - offset, center + offset),
          Offset(center + offset, center + offset),
        ];
      default:
        return [Offset(center, center)];
    }
  }
}
