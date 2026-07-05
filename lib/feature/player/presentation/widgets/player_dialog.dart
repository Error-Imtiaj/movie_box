import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/player/presentation/screens/fullscreen_player.dart';
import 'package:movie_box/feature/player/presentation/widgets/player_webview.dart';

Future<void> showPlayerDialog(BuildContext context, {required String url}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Player',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return SafeArea(
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Builder(
              builder: (context) {
                final dialogWidth = MediaQuery.of(context).size.width * 0.9;
                return SizedBox(
                  width: dialogWidth,
                  height: dialogWidth * 9 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: PlayerWebView(
                            url: url,
                            onFullscreen: () {
                              context.pushNamed(
                                Routes.fullscreenPlayerScreen,
                                extra: url,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Material(
                            color: Colors.black54,
                            shape: const CircleBorder(),
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: child,
        ),
      );
    },
  );
}
