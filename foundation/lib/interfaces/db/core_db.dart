import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CoreDb<T> {
  const CoreDb(this.key, [this.rowKey = 'GLOBAL']);
  final String key;
  final String rowKey;

  bool exists() => Hive.isBoxOpen(key);

  ValueListenable<Object?> listenable() => Hive.box<T>(key).listenable();

  T? get() => Hive.box<T>(key).get(rowKey);

  void set(T value) => Hive.box<T>(key).put(rowKey, value);

  bool isEmpty() => Hive.box<T>(key).isEmpty;

  bool isNotEmpty() => Hive.box<T>(key).isNotEmpty;

  Future<void> open() => Hive.openBox<T>(key);

  Future<void> delete() => Hive.box<T>(key).delete(rowKey);
}
