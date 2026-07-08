import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayerWebView extends StatefulWidget {
  final String url;
  final VoidCallback? onFullscreen;

  const PlayerWebView({super.key, required this.url, this.onFullscreen});

  @override
  State<PlayerWebView> createState() => _PlayerWebViewState();
}

class _PlayerWebViewState extends State<PlayerWebView> {
  late final WebViewController _controller;
  double _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                _progress = progress / 100;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          ),
          if (_progress < 1) LinearProgressIndicator(value: _progress),
          Positioned(
            top: 12,
            right: 12,
            child: Material(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(50),
              child: IconButton(
                onPressed: widget.onFullscreen,
                icon: const Icon(Icons.fullscreen, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
