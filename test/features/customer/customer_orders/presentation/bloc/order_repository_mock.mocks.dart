import 'import_mocks.dart'; // ملف استيراد الملحقات التأسيسية القياسي لدارت

class MockOrderRepository extends Mock implements OrderRepository {
  @override
  Future<Either<Failure, void>> processOrderPayment({
    required PaymentEntity? payment,
  }) async {
    return (super.noSuchMethod(
      Invocation.method(#processOrderPayment, [], {#payment: payment}),
      returnValue: Future<Either<Failure, void>>.value(
        const Right<Failure, void>(null),
      ),
    ) as Future<Either<Failure, void>>);
  }

  @override
  Future<Either<Failure, PaymentEntity>> getPaymentReceiptDetail({
    required String? orderId,
  }) async {
    return (super.noSuchMethod(
      Invocation.method(#getPaymentReceiptDetail, [], {#orderId: orderId}),
      returnValue: Future<Either<Failure, PaymentEntity>>.value(
        // تصحيح: تمرير بنود الفرز المالي الثلاثة الإلزامية الجديدة لحسم الأخطاء نهائياً
        Right<Failure, PaymentEntity>(
          PaymentEntity(
            transactionId: 'TXN_TEST',
            orderId: orderId ?? '',
            paymentMethod: 'WALLET',
            amountPaid: 120.0,
            paymentStatus: 'SUCCESS',
            merchantShare:
                80.0, // صافي مستحقات صاحب المتجر أو الصيدلية عن السلع
            deliveryFee: 30.0, // صافي حق كابتن التوصيل جغرافياً
            platformFee: 10.0, // نسبة تشغيل منصة هاتلي الذكية
          ),
        ),
      ),
    ) as Future<Either<Failure, PaymentEntity>>);
  }
}
