import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import '../../bloc/bloc.dart';
import '../../common/extensions/string_extensions.dart';
import '../../common/genshin_db_icons.dart';
import '../../common/styles.dart';
import '../../generated/l10n.dart';
import '../widgets/ascension_materials/add_edit_item_bottom_sheet.dart';
import '../widgets/ascension_materials/ascension_materials_summary.dart';
import '../widgets/ascension_materials/item_card.dart';
import '../widgets/common/item_description_detail.dart';
import '../widgets/common/nothing_found_column.dart';
import '../widgets/common/sliver_row_grid.dart';
import 'characters_page.dart';
import 'weapons_page.dart';

class CalculatorAscensionMaterialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: Text(s.ascensionMaterials)),
      body: SafeArea(
        child: HawkFabMenu(
          icon: AnimatedIcons.menu_arrow,
          fabColor: theme.accentColor,
          iconColor: Colors.white,
          items: [
            HawkFabMenuItem(
              label: s.addCharacter,
              ontap: () => _openCharacterPage(context),
              icon: const Icon(Icons.people),
              color: theme.accentColor,
              labelColor: theme.accentColor,
            ),
            HawkFabMenuItem(
              label: s.addWeapon,
              ontap: () => _openWeaponPage(context),
              icon: const Icon(GenshinDb.crossed_swords),
              color: theme.accentColor,
              labelColor: theme.accentColor,
            ),
          ],
          body: BlocBuilder<CalculatorAscMaterialsBloc, CalculatorAscMaterialsState>(
            builder: (context, state) {
              return state.map(
                initial: (state) {
                  if (state.items.isEmpty) {
                    return NothingFoundColumn(
                      msg: s.startByAddingMsg,
                      icon: Icons.add_circle_outline,
                    );
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 10),
                        sliver: SliverToBoxAdapter(
                          child: ItemDescriptionDetail(
                            title: '${s.characters} / ${s.weapons}',
                            textColor: theme.accentColor,
                            body: null,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: Styles.edgeInsetHorizontal16,
                        sliver: SliverRowGrid(
                          crossAxisCount: isPortrait ? 2 : 3,
                          crossAxisSpacing: isPortrait ? 10 : 5,
                          itemsCount: state.items.length,
                          builder: (index) {
                            final e = state.items[index];
                            return ItemCard(
                              index: index,
                              itemKey: e.key,
                              image: e.image,
                              name: e.name,
                              rarity: e.rarity,
                              isWeapon: !e.isCharacter,
                              materials: e.materials,
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ItemDescriptionDetail(
                          title: s.summary,
                          textColor: theme.accentColor,
                          body: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...state.summary.map((e) => AscensionMaterialsSummaryWidget(summary: e)).toList()
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _openCharacterPage(BuildContext context) async {
    context.read<CharactersBloc>().add(const CharactersEvent.init());
    final route = MaterialPageRoute<String>(builder: (ctx) => const CharactersPage(isInSelectionMode: true));
    final keyName = await Navigator.of(context).push(route);

    context.read<CharactersBloc>().add(const CharactersEvent.init());
    if (keyName.isNullEmptyOrWhitespace) {
      return;
    }

    context
        .read<CalculatorAscMaterialsItemBloc>()
        .add(CalculatorAscMaterialsItemEvent.load(key: keyName, isCharacter: true));

    await showModalBottomSheet(
      context: context,
      shape: Styles.modalBottomSheetShape,
      isDismissible: true,
      isScrollControlled: true,
      builder: (_) => AddEditItemBottomSheet.toAddItem(keyName: keyName, isAWeapon: false),
    );
  }

  Future<void> _openWeaponPage(BuildContext context) async {
    context.read<WeaponsBloc>().add(const WeaponsEvent.init());
    final route = MaterialPageRoute<String>(builder: (ctx) => const WeaponsPage(isInSelectionMode: true));
    final keyName = await Navigator.of(context).push(route);

    context.read<WeaponsBloc>().add(const WeaponsEvent.init());
    if (keyName.isNullEmptyOrWhitespace) {
      return;
    }

    context
        .read<CalculatorAscMaterialsItemBloc>()
        .add(CalculatorAscMaterialsItemEvent.load(key: keyName, isCharacter: false));

    await showModalBottomSheet<bool>(
      context: context,
      shape: Styles.modalBottomSheetShape,
      isDismissible: true,
      isScrollControlled: true,
      builder: (_) => AddEditItemBottomSheet.toAddItem(keyName: keyName, isAWeapon: true),
    );
  }
}
