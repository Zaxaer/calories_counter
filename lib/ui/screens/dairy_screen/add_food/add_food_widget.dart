import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:calorie_calculator_exemple/resources/resources.dart';
import 'package:calorie_calculator_exemple/ui/navigation/main_navigation.dart';
import 'package:calorie_calculator_exemple/ui/screens/dairy_screen/add_food/add_food_model.dart';

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Image.asset(
              AppImages.back,
            ),
            splashRadius: 20,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const _TextFieldWidget(),
        ),
        body: const _FoodListWidget(),
      ),
    );
  }
}

class _FoodListWidget extends StatelessWidget {
  const _FoodListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        TableFoodWidget(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: _ButtonAddFoodWidget(),
        ),
      ],
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Color(0xFF333333),
      fontFamily: AppFonts.mPlusRounded,
      fontSize: 24,
      height: 1.3,
      fontWeight: FontWeight.w500,
    );
    return Container(
      width: double.infinity,
      height: 311,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEBDBAF),
            spreadRadius: 2,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('There is no such food in our', style: style),
          Text('database', style: style),
          SizedBox(height: 25),
          Text('Continuing enter you will', style: style),
          Text('add it', style: style),
        ],
      ),
    );
  }
}

class _ButtonAddFoodWidget extends StatelessWidget {
  const _ButtonAddFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    final model = context.watch<AddFoodModel>();
    return model.foodAllData.isNotEmpty
        ? Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () => model.foodInDay(context),
              child: const Text(
                'SAVE',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: AppFonts.mPlusRounded,
                    fontSize: 18,
                    height: 1.33),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 54),
                ),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all(color),
              ),
            ),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Screen.addingFoodNew),
              child: const Text(
                'ADD NEW FOOD',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: AppFonts.mPlusRounded,
                    fontSize: 18,
                    height: 1.33),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 54),
                ),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all(color),
              ),
            ),
          );
  }
}

class _TextFieldWidget extends StatefulWidget {
  const _TextFieldWidget({Key? key}) : super(key: key);

  @override
  State<_TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<_TextFieldWidget> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = context.read<AddFoodModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: TextField(
        controller: controller,
        onChanged: (value) => model.runFilter(value),
        cursorHeight: 40,
        cursorColor: const Color(0xFF5DACE9),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            iconSize: 40,
            splashRadius: 20,
            padding: EdgeInsets.zero,
            icon: Image.asset(
              AppImages.inputDelete,
            ),
            onPressed: () {
              controller.text = '';
              model.runFilter('');
            },
          ),
          isCollapsed: true,
          focusColor: Colors.blue,
        ),
        style: const TextStyle(
          fontSize: 25,
          height: 1.5,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.roboto,
        ),
      ),
    );
  }
}

class TableFoodWidget extends StatelessWidget {
  const TableFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddFoodModel>();
    final expand = context.watch<AddFoodModel>();
    return model.foodAllData.isNotEmpty
        ? ListView.separated(
            itemCount: model.foodAllData.length,
            padding: const EdgeInsets.only(bottom: 100),
            itemBuilder: (BuildContext context, int index) {
              return _TableFoodNameWidget(expand: expand, index: index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1, color: Color(0xFFC8C8C8));
            },
          )
        : const _InfoText();
  }
}

class _TableFoodNameWidget extends StatefulWidget {
  final int index;
  const _TableFoodNameWidget({
    Key? key,
    required this.index,
    required this.expand,
  }) : super(key: key);

  final AddFoodModel expand;

  @override
  State<_TableFoodNameWidget> createState() => _TableFoodNameWidgetState();
}

class _TableFoodNameWidgetState extends State<_TableFoodNameWidget> {
  bool isExpanded = true;

  bool isExpandedTable() {
    isExpanded = !isExpanded;
    return isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddFoodModel>();
    return Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => model.changeFoodData(context, widget.index),
              backgroundColor: const Color(0xFFF6C042),
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (_) => model.deleteGroup(widget.index),
              backgroundColor: const Color(0xFFD75755),
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
            ),
          ],
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 20, right: 24),
          childrenPadding: const EdgeInsets.only(left: 20),
          collapsedTextColor: const Color(0xFF333333),
          textColor: const Color(0xFF333333),
          backgroundColor: const Color(0xFFF2F2F2),
          collapsedBackgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 11),
            child: Text(
              model.foodAllData[widget.index].foodName,
              style: const TextStyle(
                fontSize: 18,
                height: 1.33,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.ubuntu,
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                const Text(
                  '1 pc ',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.33,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.ubuntu,
                  ),
                ),
                isExpanded
                    ? Image.asset(AppImages.downSmall)
                    : Image.asset(AppImages.upSmall),
                const SizedBox(width: 10),
                Text(
                  model.foodAllData[widget.index].calories.toString() + ' kcal',
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.33,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.ubuntu,
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            iconSize: 30,
            onPressed: () => model.isSelectedTable(
                widget.index,
                model.indexPorcies,
                model.foodAllData[widget.index].foodName,
                model.foodAllData[widget.index].calories),
            icon: model.selectedIndex != widget.index
                ? Image.asset(AppImages.unchecked)
                : Image.asset(AppImages.checked),
          ),
          children: <Widget>[
            Row(
              children: [
                Stack(alignment: AlignmentDirectional.center, children: [
                  Image.asset(AppImages.rectangle),
                  IconButton(
                      splashRadius: 10,
                      onPressed: () => model.diffIndex(widget.index),
                      icon: Image.asset(
                        AppImages.minus,
                        color: model.selectedIndex != widget.index
                            ? Colors.grey
                            : null,
                      )),
                ]),
                Column(
                  children: [
                    Text(
                      model.selectedIndexSum == widget.index
                          ? '${model.indexPorcies} pc'
                          : '1 pc',
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.33,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.ubuntu,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const SizedBox(
                      height: 1,
                      width: 79,
                      child: ColoredBox(color: Color(0xFFCED0D6)),
                    )
                  ],
                ),
                Stack(alignment: AlignmentDirectional.center, children: [
                  Image.asset(AppImages.rectangle),
                  IconButton(
                      splashRadius: 10,
                      onPressed: () => model.sumIndex(widget.index),
                      icon: Image.asset(
                        AppImages.plus,
                        color: model.selectedIndex != widget.index
                            ? Colors.grey
                            : null,
                      )),
                ]),
              ],
            ),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              isExpandedTable();
            });
          },
        ));
  }
}
