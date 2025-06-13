import 'package:flutter/material.dart';
import 'package:nexus_versus/app/models/unit_card_model.dart';

class UnitCard extends StatefulWidget {
  final bool isSmall;
  final UnitCardModel unitCardModel;
  final bool animateOnAppear;

  const UnitCard({
    super.key,
    required this.unitCardModel,
    this.isSmall = false,
    this.animateOnAppear = false,
  });

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> with SingleTickerProviderStateMixin {
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
      _controller.value = 1.0;
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
    final unitCardModel = widget.unitCardModel;

    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
        ),
        color: unitCardModel.cardSpecial,
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
                _buildHeader(unitCardModel, isSmall),
                _buildImageAndStars(unitCardModel, isSmall),
                _buildDescription(context, unitCardModel, isSmall),
                _buildStats(unitCardModel, isSmall),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(UnitCardModel model, bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 3 : 6),
      decoration: BoxDecoration(
        color: model.cardSpecial,
        borderRadius: BorderRadius.circular(isSmall ? 5 : 10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
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

  Widget _buildImageAndStars(UnitCardModel model, bool isSmall) {
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

  Widget _buildDescription(BuildContext context, UnitCardModel model, bool isSmall) {
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
                        : ((MediaQuery.sizeOf(context).width * 0.005) +
                        (MediaQuery.sizeOf(context).height * 0.007)),
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

  Widget _buildStats(UnitCardModel model, bool isSmall) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 4 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Atk/ ${model.attackPower}',
            style: TextStyle(
              fontSize: isSmall ? 6 : 16,
              color: Colors.white,
            ),
          ),
          SizedBox(width: isSmall ? 3 : 8),
          Text(
            'Hp/ ${model.healthPoints}',
            style: TextStyle(
              fontSize: isSmall ? 6 : 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
