import 'package:calories_calculator/domine/blocs/dairy_bloc/food_list_bloc.dart';
import 'package:calories_calculator/ui/screens/dairy_screen/food_list/food_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';

class ListFoodWidget extends StatelessWidget {
  const ListFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1)),
          child: const _TextFieldWidget(),
        ),
      ),
      body: const _FoodListWidget(),
    );
  }
}

class _FoodListWidget extends StatelessWidget {
  const _FoodListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _TableFoodWidget(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: _ButtonAddFoodWidget(),
        ),
      ],
    );
  }
}

class _InfoTextWidget extends StatelessWidget {
  const _InfoTextWidget({Key? key}) : super(key: key);

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
      constraints: const BoxConstraints(minHeight: 331),
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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('There is no such food in', style: style),
          Text('our database', style: style),
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
    final bloc = context.watch<FoodListBloc>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => bloc.state.listFood.isNotEmpty
            ? bloc.add(AddDayFoodListEvent())
            : bloc.add(AddNewFoodEvent()),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 54),
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(const Color(0xFFD75755)),
        ),
        child: Text(
          bloc.state.listFood.isNotEmpty ? 'SAVE' : 'ADD NEW FOOD',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mPlusRounded,
            fontSize: 18,
            height: 1.33,
            color: Colors.white,
          ),
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
    final bloc = context.read<FoodListBloc>();
    return TextField(
      controller: controller,
      onChanged: (value) =>
          bloc.add(SearchFoodListEvent(enteredKeyword: value)),
      cursorHeight: 35,
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
            bloc.add(SearchFoodListEvent(enteredKeyword: ''));
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
    );
  }
}

class _TableFoodWidget extends StatelessWidget {
  const _TableFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listFood =
        context.select((FoodListBloc value) => value.state.listFood);
    return listFood.isNotEmpty
        ? ListView.separated(
            itemCount: listFood.length,
            padding: const EdgeInsets.only(bottom: 100),
            itemBuilder: (BuildContext context, int index) {
              return _TableFoodNameWidget(index: index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1, color: Color(0xFFC8C8C8));
            },
          )
        : const _InfoTextWidget();
  }
}

class _TableFoodNameWidget extends StatelessWidget {
  final int index;
  const _TableFoodNameWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<FoodListBloc>();
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => bloc.add(ChangeFoodEvent(index: index)),
            backgroundColor: const Color(0xFFF6C042),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (_) => bloc.add(DeleteFoodEvent(index: index)),
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
            bloc.state.listFood[index].foodName,
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
              bloc.state.isExpanded
                  ? Image.asset(AppImages.downSmall)
                  : Image.asset(AppImages.upSmall),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '${bloc.state.listFood[index].calories} kcal',
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.33,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.ubuntu,
                  ),
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          iconSize: 30,
          onPressed: () => bloc.add(SelectTableFoodListEvent(
              index: index,
              caloriesDayFood: bloc.state.listFood[index].calories,
              foodName: bloc.state.listFood[index].foodName)),
          icon: bloc.state.selectedIndex != index
              ? Image.asset(AppImages.unchecked)
              : Image.asset(AppImages.checked),
        ),
        children: <Widget>[
          Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(AppImages.rectangle),
                  IconButton(
                    splashRadius: 10,
                    onPressed: () => bloc.add(DiffPorciesEvent(index: index)),
                    icon: Image.asset(
                      AppImages.minus,
                      color: bloc.state.selectedIndex != index
                          ? Colors.grey
                          : null,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    bloc.state.selectedIndexSum == index
                        ? '${bloc.state.indexPorcies} pc'
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
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(AppImages.rectangle),
                  IconButton(
                    splashRadius: 10,
                    onPressed: () => bloc.add(SumPorciesEvent(index: index)),
                    icon: Image.asset(
                      AppImages.plus,
                      color: bloc.state.selectedIndex != index
                          ? Colors.grey
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
        onExpansionChanged: (_) => bloc.add(ExpansionTileEvent()),
      ),
    );
  }
}
