import 'package:flutter/widgets.dart';
import '../../common/enums/element_type.dart';
import '../../common/enums/weapon_type.dart';

class CharacterCardModel {
  final String logoName;
  final String name;
  final int stars;
  final WeaponType weaponType;
  final ElementType elementType;
  final bool isNew;
  final bool isComingSoon;

  const CharacterCardModel({
    @required this.logoName,
    @required this.name,
    @required this.stars,
    @required this.weaponType,
    @required this.elementType,
    this.isNew = false,
    this.isComingSoon = false,
  });
}