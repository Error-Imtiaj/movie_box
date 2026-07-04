import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_icons.dart';

class OverviewWidget extends StatefulWidget {
  final String overview;

  const OverviewWidget({
    super.key,
    required this.overview,
  });

  @override
  State<OverviewWidget> createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.overview.trim().isEmpty) {
      return const SizedBox();
    }

    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodySmall?.copyWith(height: 1.6);

    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.overview,
        style: textStyle,
      ),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(
      maxWidth: MediaQuery.of(context).size.width - 48,
    );

    final bool hasOverflow = textPainter.didExceedMaxLines;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overview",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          AnimatedCrossFade(
            firstChild: Text(
              widget.overview,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            secondChild: Text(
              widget.overview,
              style: textStyle,
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),

          const SizedBox(height: 10),
          
          if (hasOverflow)
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _expanded ? 'Show Less' : 'Read More',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _expanded ? .5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: HugeIcon(
                      icon: AppIcons.arrowDownIcon,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}