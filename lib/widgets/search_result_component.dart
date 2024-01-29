import 'package:flutter/material.dart';
import 'package:google_clone/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultComponent extends StatefulWidget {
  final String link;
  final String text;
  final String LinkToGo;
  final String desc;
  const SearchResultComponent({super.key, required this.link,  required this.text, required this.LinkToGo, required this.desc});

  @override
  State<SearchResultComponent> createState() => _SearchResultComponentState();
}

class _SearchResultComponentState extends State<SearchResultComponent> {
  bool _showUnderline = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.link),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () async {
              if(await canLaunchUrl(Uri.parse(widget.LinkToGo))){
                await launchUrl(Uri.parse(widget.LinkToGo));
              }
            },
            onHover: (hovering){
              _showUnderline = hovering;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.link,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF202124),
                  ),
                ),
                Text(
                  widget.text,
                  style:  TextStyle(
                    color: blueColor,
                    decoration: _showUnderline ? TextDecoration.underline : TextDecoration.none,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          widget.desc,
          style: const TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}
