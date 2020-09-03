import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repos_github/models/commit.dart';

class CommitItem extends StatelessWidget {
  final Commit model;

  const CommitItem({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.commit.message.split('\n')[0]),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Text(model.commit.author, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(' $_dateFormat', style: TextStyle(fontWeight: FontWeight.w300))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(model.commit.hash.substring(0, 7), style: TextStyle(color: Theme.of(context).primaryColor)),
          )
        ],
      ),
      trailing: model.commit.authorAvatar != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(model.commit.authorAvatar),
            )
          : null,
    );
  }

  String get _dateFormat {
    final DateTime dateTime = DateTime.parse(model.commit.date).toLocal();
    return '${DateFormat.yMMMd().format(dateTime)} ${DateFormat.Hm().format(dateTime)}';
  }
}
