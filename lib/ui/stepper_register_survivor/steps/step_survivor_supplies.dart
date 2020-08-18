import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t_virus/core/model/supplie.dart';
import 'package:t_virus/core/model/survivor.dart';
import 'package:t_virus/ui/shared/app_colors.dart';

// ignore: must_be_immutable
class StepSurvivorSupplies extends StatefulWidget {
  Survivor survivor;

  StepSurvivorSupplies(this.survivor);

  @override
  _StepSurvivorSuppliesState createState() => _StepSurvivorSuppliesState();
}

class _StepSurvivorSuppliesState extends State<StepSurvivorSupplies> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  @override
  void initState() {
    super.initState();
    addSupplies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ColoredBox(
              color: primaryColor,
              child: Container(
                height: 300,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 2,
                    color: accentColor,
                  ),
                  itemCount: widget.survivor.supplies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          Image.asset('images/ic_back_pack.png', width: 30),
                      title: Text( widget.survivor.supplies[index].name,
                          style: TextStyle(color: accentColor,fontSize: 14, fontWeight: FontWeight.w300)),
                      subtitle: Text(
                          'Points: ' +  widget.survivor.supplies[index].points.toString(),
                          style: TextStyle(color: accentColor, fontWeight:  FontWeight.w300, fontSize: 12, fontStyle: FontStyle.italic)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 20.0,
                              color: accentColor,
                            ),
                            onPressed: () => removeQuatintyInSupplie(index),
                          ),
                          Text(
                            widget.survivor.supplies[index].quantity.toString(),
                            style: TextStyle(color: accentColor),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 20.0,
                                color: accentColor,
                              ),
                              onPressed: () => addQuatintyInSupplie(index)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }

  void addQuatintyInSupplie(int index) {
    setState(() {
      widget.survivor.supplies[index].quantity += 1;
    });
  }

  void removeQuatintyInSupplie(int index) {
    if ( widget.survivor.supplies[index].quantity > 0)
      setState(() {
        widget.survivor.supplies[index].quantity -= 1;
      });
  }

  void addSupplies() {
    widget.survivor.supplies = List();
    widget.survivor.supplies.add(Supplie(name: 'Fiji Water', points: 14, quantity: 0));
    widget.survivor.supplies.add(Supplie(name: 'Campbell Soup', points: 12, quantity: 0));
    widget.survivor.supplies.add(Supplie(name: 'First Aid Pounch', points: 10, quantity: 0));
    widget.survivor.supplies.add(Supplie(name: 'AK47', points: 8, quantity: 0));
  }
}
