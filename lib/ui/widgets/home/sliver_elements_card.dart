import 'package:flutter/material.dart';

import '../../../common/enums/element_type.dart';
import '../../pages/elements_page.dart';
import '../common/element_image.dart';

class SliverElementsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () => _gotoElementsPage(context),
        child: Card(
          margin: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: SizedBox(
            height: 170,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildIcon(ElementType.anemo, const Offset(0, -1)),
                _buildIcon(ElementType.cryo, const Offset(-1.4, -0.6)),
                _buildIcon(ElementType.dendro, const Offset(-1.4, 0.6)),
                _buildIcon(ElementType.geo, const Offset(0, 1)),
                _buildIcon(ElementType.hydro, const Offset(1.4, -0.6)),
                _buildIcon(ElementType.pyro, const Offset(1.4, 0.6)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ElementType type, Offset offset) {
    return FractionalTranslation(
      translation: offset,
      child: ElementImage.fromType(type: type),
    );
  }

  Future<void> _gotoElementsPage(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (c) => ElementsPage()));
  }
}
