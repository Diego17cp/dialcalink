import 'dart:async';

import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchContactInputField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const SearchContactInputField({super.key, required this.controller});

  @override
  ConsumerState<SearchContactInputField> createState() => _SearchContactInputFieldState();
}

class _SearchContactInputFieldState extends ConsumerState<SearchContactInputField> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (ref.read(selectedRecipientProvider) != null) {
      ref.read(selectedRecipientProvider.notifier).select(null);
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(smsContactSearchQueryProvider.notifier).update(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Para:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: "Número o nombre",
            prefixIcon: const Icon(CupertinoIcons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}