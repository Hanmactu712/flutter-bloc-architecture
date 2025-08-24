abstract class IRepository<T> {
  Stream<T?> get stream;
  Future<T?> createOrUpdate(T item);
  Future<T?> detail(String id);
  Future<List<T>> list({required Map<String, dynamic> params});
  Future<void> delete(String id);
  void subscribe({required String itemId, Function(T?)? onData});
  void cancelSubscription({required String itemId});
  void subscribeCollection({Function()? onChanged});
  void cancelCollectionSubscription();
}
