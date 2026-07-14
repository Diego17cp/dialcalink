import 'package:dialcalink/features/sms/presentation/widgets/sms_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dialcalink/app/layouts/glass_scaffold.dart';
import 'package:dialcalink/features/sms/presentation/providers/sms_providers.dart';
import 'package:dialcalink/features/sms/presentation/widgets/empty_sms_list.dart';
import 'package:dialcalink/features/sms/presentation/widgets/sms_bubble.dart';
import 'package:dialcalink/features/sms/presentation/widgets/sms_conversation_skeleton.dart';

class SmsConversationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const SmsConversationScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<SmsConversationScreen> createState() => _SmsConversationScreenState();
}

class _SmsConversationScreenState extends ConsumerState<SmsConversationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(markConversationAsReadProvider(widget.phoneNumber).future));
  }
  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(smsMessagesByPhoneNumberProvider(widget.phoneNumber));
    return messagesAsync.when(
      loading: () => GlassScaffold(
        title: widget.phoneNumber,
        onBackTap: () => context.pop(),
        scrollable: false,
        body: const SmsConversationSkeleton(),
      ),
      error: (err, _) => GlassScaffold(
        title: 'Error',
        onBackTap: () => context.pop(),
        body: Center(child: Text('Error al cargar mensajes: $err')),
      ),
      data: (messages) {
        final contactName = messages.firstOrNull?.contactName;
        final displayTitle = contactName ?? widget.phoneNumber;
        return GlassScaffold(
          title: displayTitle,
          onBackTap: () => context.pop(),
          scrollable: false,
          body: Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? const EmptySmsList()
                    : ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                        itemCount: messages.length,
                        itemBuilder: (context, index) => SmsBubble(sms: messages[index]),
                      ),
              ),
              SafeArea(
                top: false,
                child: SmsInputField(
                  phoneNumber: widget.phoneNumber,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
