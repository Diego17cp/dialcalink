import 'package:drift/drift.dart';
import 'package:dialcalink/core/database/drift/app_database.dart';
import 'package:dialcalink/features/sync/domain/entities/sync_event_entity.dart';

class SyncEventMapper {
  const SyncEventMapper._();

  static SyncEventEntity toEntity(SyncEvent row) {
    return SyncEventEntity(
      id: row.id,
      entityType: row.entityType,
      entityId: row.entityId,
      eventType: row.eventType,
      createdAt: row.createdAt,
      synced: row.synced,
    );
  }

  static SyncEventsCompanion toCompanion(SyncEventEntity entity) {
    return SyncEventsCompanion(
      id: Value(entity.id),
      entityType: Value(entity.entityType),
      entityId: Value(entity.entityId),
      eventType: Value(entity.eventType),
      createdAt: Value(entity.createdAt),
      synced: Value(entity.synced),
    );
  }
}