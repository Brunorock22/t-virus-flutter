import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t_virus/core/database/dao/supplie_dao.dart';
import 'package:t_virus/core/util/global_user_acess.dart';
import 'package:t_virus/ui/shared/app_colors.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: addSupplies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: circleRadius / 2.0),
                      child: ColoredBox(
                        color: primaryColor,
                        child: Container(
                          height: 300,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              height: 2,
                              color: accentColor,
                            ),
                            itemCount: GlobalUser.survivor.supplies.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.asset('images/ic_back_pack.png',
                                    width: 30),
                                title: Text(
                                    GlobalUser.survivor.supplies[index].name,
                                    style: TextStyle(
                                        color: accentColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                                subtitle: Text(
                                    'Points: ' +
                                        GlobalUser
                                            .survivor.supplies[index].points
                                            .toString(),
                                    style: TextStyle(
                                        color: accentColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('Quantity : ',
                                        style: TextStyle(
                                            color: accentColor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic)),
                                    Text(
                                      GlobalUser
                                          .survivor.supplies[index].quantity
                                          .toString(),
                                      style: TextStyle(
                                          color: accentColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: circleRadius,
                      height: circleRadius,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(), color: accentColor),
                      child: Padding(
                        padding: EdgeInsets.all(circleBorderWidth),
                        child: DecoratedBox(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'images/ic_zombie_face.png',
                                  ))),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: primaryColor,
            ));
          }
        });
  }

  Future<void> addSupplies() async {
    //In case global supplies are empty request then on database
    if (GlobalUser.survivor.supplies == null) {
      GlobalUser.survivor.supplies = await SupplieDao.findAll();
    }
  }
}
