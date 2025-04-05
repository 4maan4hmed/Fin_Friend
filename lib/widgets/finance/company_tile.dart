import 'package:flutter/material.dart';

class CompanyData {
  final String id;
  final String name;
  final String logoPath;
  final String description;
  bool isSelected;

  CompanyData({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.description,
    this.isSelected = false,
  });
}

class CompanySelectionTile extends StatefulWidget {
  final CompanyData company;
  final Function(CompanyData) onSelectionChanged;
  final bool showAnimationWhenSelected;

  const CompanySelectionTile({
    super.key,
    required this.company,
    required this.onSelectionChanged,
    this.showAnimationWhenSelected = true,
  });

  @override
  State<CompanySelectionTile> createState() => _CompanySelectionTileState();
}

class _CompanySelectionTileState extends State<CompanySelectionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.company.isSelected && widget.showAnimationWhenSelected) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CompanySelectionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.company.isSelected != oldWidget.company.isSelected) {
      if (widget.company.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            final newSelectedState = !widget.company.isSelected;
            widget.company.isSelected = newSelectedState;
            widget.onSelectionChanged(widget.company);
            if (widget.showAnimationWhenSelected) {
              if (newSelectedState) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            }
          },
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.company.isSelected
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: widget.company.isSelected ? 3 : 1,
                  ),
                ],
                border: Border.all(
                  color: widget.company.isSelected
                      ? Colors.blue
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        widget.company.logoPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.company.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (widget.company.isSelected)
                              FadeTransition(
                                opacity: _opacityAnimation,
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.company.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}