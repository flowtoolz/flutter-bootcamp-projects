import 'package:bmi_calculator/bmi.dart';
import 'package:bmi_calculator/result_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'gender_cell_content.dart';
import 'cell.dart';
import 'style.dart';
import 'call_to_action_button.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Cell(
                    child: GenderCellContent(
                      gender: Gender.male, 
                      onTap: () => select(gender: Gender.male),
                    ),
                    isActive: activeGender == Gender.male,
                  ),
                ),
                Expanded(
                  child: Cell(
                    child: GenderCellContent(
                      gender: Gender.female,
                      onTap: () => select(gender: Gender.female),
                    ),
                    isActive: activeGender == Gender.female,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Cell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: kLabelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString(), style: kNumberStyle),
                      Text(' cm', style: kLabelStyle),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(), 
                    onChanged: (newHeight) {
                      setState(() {
                        height = newHeight.round();
                      });
                    },
                    min: 100,
                    max: 240,
                  ),
                ],
              ),
              isActive: true,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Cell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("WEIGHT", style: kLabelStyle),
                        Text(
                          weight.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              iconData: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight -= 1;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            RoundIconButton(
                              iconData: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight += 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    isActive: true,
                  ),
                ),
                Expanded(
                  child: Cell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("AGE", style: kLabelStyle),
                        Text(
                          age.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              iconData: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age -= 1;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            RoundIconButton(
                              iconData: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age += 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    isActive: true,
                  ),
                ),
              ],
            ),
          ),
          CallToActionButton(
            title: 'Calculate',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ResultPage(bmi: BodyMassIndex(
                  height: height,
                  weight: weight
                ),),)
              );
            },
          ),
        ],
      ),
    );
  }

  void select({required Gender gender}) {
    setState(() {
      activeGender = gender;
    });
  }

  Gender activeGender = Gender.male;
  int height = 170;
  int weight = 80;
  int age = 40; 
}

class RoundIconButton extends StatelessWidget {

  RoundIconButton({required this.iconData, required this.onPressed});

  @override
  RawMaterialButton build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      child: Icon(iconData, color: Colors.white),
      shape: CircleBorder(),
      fillColor: Color(0xff4c4f5e),
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      onPressed: () => onPressed(),
    );
  }

  final IconData iconData;
  final Function onPressed;
}