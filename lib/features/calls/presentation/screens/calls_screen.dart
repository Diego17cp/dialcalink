import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/features/calls/presentation/providers/call_providers.dart';
import 'package:dialcalink/features/calls/presentation/widgets/call_log_item.dart';
import 'package:dialcalink/features/calls/presentation/widgets/calls_skeleton.dart';
import 'package:dialcalink/features/calls/presentation/widgets/empty_calls_list.dart';

class CallsScreen extends ConsumerWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callsAsync = ref.watch(allCallsProvider);
    return callsAsync.when(
      data: (calls) {
        if (calls.isEmpty) {
          return const EmptyCallsList();
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: calls.length,
          itemBuilder: (context, index) {
            final call = calls[index];
            return CallLogItem(call: call);
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
      loading: () => const CallsSkeleton(),
    );
  }
}
