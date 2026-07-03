import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dialcalink/shared/glass_icon_button.dart';

class GlassScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool scrollable;

  const GlassScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onBackTap,
    this.actions,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final appBarHeight = kToolbarHeight + topPadding;

    return Scaffold(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      extendBody: true,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: scrollable ? 
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: appBarHeight + 16.0,
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                child: body,
              )
              : Padding(
                  padding: EdgeInsets.only(top: appBarHeight),
                  child: body,
                ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  height: appBarHeight,
                  padding: EdgeInsets.only(top: topPadding),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.4),
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.02 ,
                        ),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 42,
                          child: onBackTap != null
                              ? Center(
                                  child: GlassIconButton(
                                    icon: CupertinoIcons.back,
                                    onTap: onBackTap!,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),

                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: -0.3,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 42,
                          child: actions != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: actions!,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
