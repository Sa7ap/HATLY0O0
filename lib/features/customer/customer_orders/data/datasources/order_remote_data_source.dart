import '../../../../../../core/network/dio_client.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  // الدالة البرمجية المسؤولة عن إرسال الطلب الحر للسيرفر
  Future<void> createOrder(OrderModel orderModel);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DioClient _dioClient;

  OrderRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> createOrder(OrderModel orderModel) async {
    await _dioClient.post(
      '/customer/orders', // رابط الـ API المخصص لاستلام طلبات العملاء الحرة
      data: orderModel.toJson(), // تحويل كائن الطلب إلى JSON تلقائياً هنا
    );
  }
}
