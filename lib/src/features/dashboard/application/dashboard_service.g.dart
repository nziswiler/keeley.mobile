// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardServiceHash() => r'fb83e69c7552911f94ea98b551155c0f3c4d32e2';

/// See also [dashboardService].
@ProviderFor(dashboardService)
final dashboardServiceProvider = Provider<DashboardService>.internal(
  dashboardService,
  name: r'dashboardServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardServiceRef = ProviderRef<DashboardService>;
String _$monthlyStatsHash() => r'a85f8b4bc0e90caea793136a2f7a3e87c3a97058';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [monthlyStats].
@ProviderFor(monthlyStats)
const monthlyStatsProvider = MonthlyStatsFamily();

/// See also [monthlyStats].
class MonthlyStatsFamily extends Family<AsyncValue<MonthlyStats>> {
  /// See also [monthlyStats].
  const MonthlyStatsFamily();

  /// See also [monthlyStats].
  MonthlyStatsProvider call({
    DateTime? month,
  }) {
    return MonthlyStatsProvider(
      month: month,
    );
  }

  @override
  MonthlyStatsProvider getProviderOverride(
    covariant MonthlyStatsProvider provider,
  ) {
    return call(
      month: provider.month,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'monthlyStatsProvider';
}

/// See also [monthlyStats].
class MonthlyStatsProvider extends AutoDisposeFutureProvider<MonthlyStats> {
  /// See also [monthlyStats].
  MonthlyStatsProvider({
    DateTime? month,
  }) : this._internal(
          (ref) => monthlyStats(
            ref as MonthlyStatsRef,
            month: month,
          ),
          from: monthlyStatsProvider,
          name: r'monthlyStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlyStatsHash,
          dependencies: MonthlyStatsFamily._dependencies,
          allTransitiveDependencies:
              MonthlyStatsFamily._allTransitiveDependencies,
          month: month,
        );

  MonthlyStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final DateTime? month;

  @override
  Override overrideWith(
    FutureOr<MonthlyStats> Function(MonthlyStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyStatsProvider._internal(
        (ref) => create(ref as MonthlyStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MonthlyStats> createElement() {
    return _MonthlyStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyStatsProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthlyStatsRef on AutoDisposeFutureProviderRef<MonthlyStats> {
  /// The parameter `month` of this provider.
  DateTime? get month;
}

class _MonthlyStatsProviderElement
    extends AutoDisposeFutureProviderElement<MonthlyStats>
    with MonthlyStatsRef {
  _MonthlyStatsProviderElement(super.provider);

  @override
  DateTime? get month => (origin as MonthlyStatsProvider).month;
}

String _$categoryExpensesHash() => r'25a9f4b952baf64f852e00092143b3a3ebbc0574';

/// See also [categoryExpenses].
@ProviderFor(categoryExpenses)
const categoryExpensesProvider = CategoryExpensesFamily();

/// See also [categoryExpenses].
class CategoryExpensesFamily extends Family<AsyncValue<List<CategoryExpense>>> {
  /// See also [categoryExpenses].
  const CategoryExpensesFamily();

  /// See also [categoryExpenses].
  CategoryExpensesProvider call({
    DateTime? month,
    int limit = 10,
  }) {
    return CategoryExpensesProvider(
      month: month,
      limit: limit,
    );
  }

  @override
  CategoryExpensesProvider getProviderOverride(
    covariant CategoryExpensesProvider provider,
  ) {
    return call(
      month: provider.month,
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'categoryExpensesProvider';
}

/// See also [categoryExpenses].
class CategoryExpensesProvider
    extends AutoDisposeFutureProvider<List<CategoryExpense>> {
  /// See also [categoryExpenses].
  CategoryExpensesProvider({
    DateTime? month,
    int limit = 10,
  }) : this._internal(
          (ref) => categoryExpenses(
            ref as CategoryExpensesRef,
            month: month,
            limit: limit,
          ),
          from: categoryExpensesProvider,
          name: r'categoryExpensesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryExpensesHash,
          dependencies: CategoryExpensesFamily._dependencies,
          allTransitiveDependencies:
              CategoryExpensesFamily._allTransitiveDependencies,
          month: month,
          limit: limit,
        );

  CategoryExpensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
    required this.limit,
  }) : super.internal();

  final DateTime? month;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<CategoryExpense>> Function(CategoryExpensesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryExpensesProvider._internal(
        (ref) => create(ref as CategoryExpensesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CategoryExpense>> createElement() {
    return _CategoryExpensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryExpensesProvider &&
        other.month == month &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CategoryExpensesRef
    on AutoDisposeFutureProviderRef<List<CategoryExpense>> {
  /// The parameter `month` of this provider.
  DateTime? get month;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _CategoryExpensesProviderElement
    extends AutoDisposeFutureProviderElement<List<CategoryExpense>>
    with CategoryExpensesRef {
  _CategoryExpensesProviderElement(super.provider);

  @override
  DateTime? get month => (origin as CategoryExpensesProvider).month;
  @override
  int get limit => (origin as CategoryExpensesProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
