import 'package:dialcalink/app/layouts/glass_scaffold.dart';
import 'package:dialcalink/core/platform/client/providers/client_ui_bridge_provider.dart';
import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';
import 'package:dialcalink/features/sms/presentation/widgets/new_sms_textarea.dart';
import 'package:dialcalink/features/sms/presentation/widgets/search_contact_input_field.dart';
import 'package:dialcalink/features/sms/presentation/widgets/suggestions_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SmsNewScreen extends ConsumerStatefulWidget {
  const SmsNewScreen({super.key});

  @override
  ConsumerState<SmsNewScreen> createState() => _SmsNewScreenState();
}

class _SmsNewScreenState extends ConsumerState<SmsNewScreen> {
  final _recipientController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _recipientController.dispose();
    _messageController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clientUiBridgeProvider).requestSyncContacts();
    });
  }

  Future<void> _handleSend() async {
    final selected = ref.read(selectedRecipientProvider);
    final manual = _recipientController.text.trim();
    final content = _messageController.text.trim();

    final targetNumber = selected?.number ?? manual;

    if (targetNumber.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, indica el número de teléfono y el contenido del mensaje'))
      );
      return;
    }

    setState(() => _isSending = true);

    try {
      await ref.read(clientUiBridgeProvider).requestSendSms(targetNumber, content);

      if (mounted) {
        context.pushReplacement('/client/sms/$targetNumber');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contacts = ref.watch(filteredContactsProvider);
    final selectedContact = ref.watch(selectedRecipientProvider);
    return GlassScaffold(
      onBackTap: () => context.pop(),
      title: 'Nuevo SMS',
      body: Column(
        children: [
          SearchContactInputField(controller: _recipientController),
          if (selectedContact == null && contacts.isNotEmpty) ...[
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sugerencias",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                ...contacts.map((contact) => SuggestionsContact(
                  contact: contact,
                  onTap: () {
                    ref.read(selectedRecipientProvider.notifier).select(contact);
                    _recipientController.text = contact.name;
                    ref.read(smsContactSearchQueryProvider.notifier).update('');
                  },
                )),
              ],
            ),
          ],
          const SizedBox(height: 16),
          NewSmsTextarea(
            controller: _messageController,
            onSend: _isSending ? null : _handleSend,
          ),
        ],
      ),
    );
  }
}
