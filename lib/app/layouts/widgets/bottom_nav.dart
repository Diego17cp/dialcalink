import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:dialcalink/app/router/tab_config.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double barWidth = screenWidth - 48;
    final double itemWidth = barWidth / clientTabs.length;

    return Theme(
      data: theme.copyWith(canvasColor: Colors.transparent),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 72,
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      left: currentIndex * itemWidth + 4,
                      top: 4,
                      bottom: 4,
                      width: itemWidth - 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(alpha: 0.08),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(clientTabs.length, (index) {
                        final tab = clientTabs[index];
                        final isActive = index == currentIndex;
                        return Expanded(
                          child: InkWell(
                            onTap: () => onTap(index),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedScale(
                                  duration: const Duration(milliseconds: 200),
                                  scale: isActive ? 1.1 : 1.0,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Icon(
                                      isActive ? tab.activeIcon : tab.icon,
                                      color: isActive
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                    letterSpacing: -0.1,
                                    color: isActive
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                  ),
                                  child: Text(
                                    tab.label, 
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
