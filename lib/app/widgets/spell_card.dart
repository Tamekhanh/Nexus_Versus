import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/spell_card_model.dart';

class SpellCard extends StatefulWidget {
  final bool isSmall;
  final SpellCardModel spellCardModel;
  final bool animateOnAppear;

  const SpellCard({
    super.key,
    required this.spellCardModel,
    this.isSmall = false,
    this.animateOnAppear = false, // <== thêm flag này để kiểm soát animate
  });

  @override
  State<SpellCard> createState() => _SpellCardState();
}

class _SpellCardState extends State<SpellCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    if (widget.animateOnAppear) {
      _controller.forward();
    } else {
      _controller.value = 1.0; // Không animate nếu không cần
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    final isSmall = widget.isSmall;
    final spellCardModel = widget.spellCardModel;

    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
        ),
        color: spellCardModel.cardSpecial,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
            border: Border.all(
              color: Colors.black54,
              width: isSmall ? 3 : 8,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 2.0 : 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildHeader(isSmall, spellCardModel),
                _buildImageAndStars(isSmall, spellCardModel),
                SizedBox(height: isSmall ? 2 : 8),
                _buildDescription(context, isSmall, spellCardModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmall, SpellCardModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 3 : 6),
      decoration: BoxDecoration(
        color: model.cardSpecial,
        borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            model.name,
            style: TextStyle(
              fontSize: isSmall ? 6 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageAndStars(bool isSmall, SpellCardModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              model.level,
                  (index) => Icon(Icons.star, color: Colors.yellow, size: isSmall ? 8 : 24),
            ),
          ),
          Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isSmall ? 3 : 8),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  model.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, bool isSmall, SpellCardModel model) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isSmall ? 4 : 8),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 3 : 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.series}",
                  style: TextStyle(
                    fontSize: isSmall ? 6 : 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                Text(
                  model.description,
                  style: TextStyle(
                    fontSize: isSmall
                        ? 5
                        : (MediaQuery.sizeOf(context).width * 0.005) +
                        (MediaQuery.sizeOf(context).height * 0.007),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
