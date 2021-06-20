

import 'package:demo_app/Controller/data_controller.dart';
import 'package:demo_app/Model/data_model.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';

class DataTile extends StatelessWidget {
  const DataTile({
    Key? key,
    required DataController dataController,
  }) : _dataController = dataController, super(key: key);

  final DataController _dataController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        itemBuilder: (context, index) {
          final DataModel dataModel =
          _dataController.dataList[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: SC().h(context) * 0.01,
              horizontal: SC().w(context) * 0.025,
            ),
            child: Container(
              child: Row(
                children: [
                  Container(
                    height: SC().h(context) * 0.15,
                    width: SC().h(context) * 0.15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(dataModel.url),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      // vertical: SC().h(context) * 0.01,
                      horizontal: SC().w(context) * 0.025,
                    ),
                    child: Container(
                      height: SC().h(context) * 0.15,
                      width: SC().w(context) * 0.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dataModel.title,
                        style: headerStyle.copyWith(
                            fontSize: SC().h(context) * 0.025),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}