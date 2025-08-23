import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ShaderTextParser extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final List<Color> gradientColors;

  const ShaderTextParser({
    super.key,
    required this.text,
    this.baseStyle,
    this.gradientColors = const [Colors.blue, Colors.purple],
  });

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildParsedText(context);
  }

  Widget _buildParsedText(BuildContext context) {
    final spans = _parseTextToSpans();

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: spans,
      ),
    );
  }

  List<InlineSpan> _parseTextToSpans() {
    final List<InlineSpan> spans = [];

    // First, preprocess the text to remove all *link* patterns and create link mapping
    final processedText = _preprocessText();

    // Now parse the processed text for shader and link patterns
    final regex = RegExp(r'#([^#]+)#|%([^%]+)%');
    int lastEnd = 0;

    for (final match in regex.allMatches(processedText.text)) {
      // Add normal text before the match
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: processedText.text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }

      if (match.group(1) != null) {
        // Handle shader text (##text##)
        spans.add(WidgetSpan(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              match.group(1)!,
              style: baseStyle?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
      } else if (match.group(2) != null) {
        // Handle link text (%%text%%)
        final linkText = match.group(2)!;
        final url = processedText.linkMap[linkText];

        if (url != null) {
          spans.add(TextSpan(
            text: linkText,
            style: baseStyle?.copyWith(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchUrl(url),
          ));
        } else {
          // If no URL found, just show as normal blue text
          spans.add(TextSpan(
            text: linkText,
            style: baseStyle?.copyWith(color: Colors.blue),
          ));
        }
      }

      lastEnd = match.end;
    }

    // Add any remaining normal text
    if (lastEnd < processedText.text.length) {
      spans.add(TextSpan(
        text: processedText.text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
  }

  ProcessedTextResult _preprocessText() {
    String processedText = text;
    Map<String, String> linkMap = {};

    // Find all %text% patterns and their corresponding *link* patterns
    final linkTextRegex = RegExp(r'%([^%]+)%');
    final linkMatches = linkTextRegex.allMatches(text).toList();

    // Create a list to track which *link* patterns have been used
    final allUrlMatches = RegExp(r'\*([^*]+)\*').allMatches(text).toList();
    int urlIndex = 0;

    for (final linkMatch in linkMatches) {
      final linkText = linkMatch.group(1)!;

      // Find the next available *link* pattern
      if (urlIndex < allUrlMatches.length) {
        final urlMatch = allUrlMatches[urlIndex];
        final url = urlMatch.group(1)!;
        linkMap[linkText] = url;
        urlIndex++;
      }
    }

    // Remove ALL *link* patterns from the text
    processedText = processedText.replaceAll(RegExp(r'\*[^*]+\*'), '');

    // Clean up any extra spaces that might be left
    processedText = processedText.replaceAll(RegExp(r'\s+'), ' ').trim();

    return ProcessedTextResult(processedText, linkMap);
  }
}

class ProcessedTextResult {
  final String text;
  final Map<String, String> linkMap;

  ProcessedTextResult(this.text, this.linkMap);
}