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
String _$monthlyStatsHash() => r'5841bfdeab9d1ab85065f4086b76eff4f821e3df';

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

String _$categoryExpensesHash() => r'bab53f67804e999a4e2dbd7d476a410e599d7744';

/// See also [categoryExpenses].
@ProviderFor(categoryExpenses)
final categoryExpensesProvider =
    AutoDisposeFutureProvider<List<CategoryExpense>>.internal(
  categoryExpenses,
  name: r'categoryExpensesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryExpensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryExpensesRef
    = AutoDisposeFutureProviderRef<List<CategoryExpense>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
