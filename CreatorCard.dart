
import 'package:flutter/material.dart';

class CreatorCard extends StatefulWidget {
  CreatorCard({Key? key,required this.content,required this.heroTag}) : super(key: key);
  Widget content;
  String heroTag;
  @override
  _CreatorCardState createState() => _CreatorCardState();
}

class _CreatorCardState extends State<CreatorCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: widget.heroTag,

            child: Material(
                color: Colors.white,
                elevation: 2,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                        child: //widget.content
                          SingleChildScrollView(
                          padding: MediaQuery.of(context).viewInsets,
                            child: widget.content,
                          )
                    )
                )
            )

        ),
      ),
    );
  }
}
