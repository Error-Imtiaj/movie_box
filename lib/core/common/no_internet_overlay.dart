import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NoInternetOverlay extends SnackBar {
  NoInternetOverlay({
    super.key,
    required Color backgroundColor,
    required String message,
    required List icon,
    required Duration duration,
  }) : super(
          backgroundColor: backgroundColor,
          duration: duration,
          content: Row(
            children: [
              HugeIcon(
                icon: [icon],
                size: 22,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );}
