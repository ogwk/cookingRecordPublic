import 'package:cooking_record/extension/date_time_ex.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/unit/image/image.dart';
import 'package:flutter/material.dart';

FutureBuilder recordList(
    Future getRecord, Function fncTapCard, Widget noRecord) {
  Widget buildCard(BuildContext context, Record record) {
    return GestureDetector(
      onTap: () async {
        await fncTapCard(record);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10),
                child: netImageBox(100.0, 128.0, record.imageUrl)),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        record.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        record.date != null
                            ? record.date!.getJapaneseDateE().toString()
                            : "-年-月-日",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  return FutureBuilder(
    future: getRecord,
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasData) {
        if (snapshot.data.isEmpty) {
          return noRecord;
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return buildCard(context, snapshot.data[index]);
              });
        }
      } else {
        return noRecord;
      }
    },
  );
}
