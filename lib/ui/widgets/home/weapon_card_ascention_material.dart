import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../common/extensions/i18n_extensions.dart';
import '../../../common/styles.dart';
import '../../../generated/l10n.dart';
import '../../pages/weapon_page.dart';

class WeaponCardAscentionMaterial extends StatelessWidget {
  final String name;
  final String image;
  final List<int> days;
  final List<String> weapons;

  const WeaponCardAscentionMaterial({
    Key key,
    @required this.name,
    @required this.image,
    @required this.days,
    @required this.weapons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final obtainOn = s.translateDays(days);

    return Card(
      margin: Styles.edgeInsetAll10,
      shape: Styles.cardShape,
      child: Container(
        padding: Styles.edgeInsetAll5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 120, height: 100),
            Tooltip(
              message: name,
              child: Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Tooltip(
              message: obtainOn,
              child: Text(
                obtainOn,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: theme.textTheme.subtitle2.copyWith(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: weapons.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) => Container(
                  margin: const EdgeInsets.all(3),
                  child: InkWell(
                    onTap: () => _gotoWeaponPage(weapons[index], context),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(weapons[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _gotoWeaponPage(String image, BuildContext context) async {
    context.read<WeaponBloc>().add(WeaponEvent.loadFromImg(image: image));
    final route = MaterialPageRoute(builder: (c) => WeaponPage());
    await Navigator.push(context, route);
  }
}
