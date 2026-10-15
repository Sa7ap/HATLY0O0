import 'package:hatlyai/core/network/dio_client.dart';

import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  // دالة جلب بيانات ورصيد المحفظة من السيرفر
  Future<WalletModel> getWalletBalance();

  // دالة شحن أو تحديث رصيد المحفظة
  Future<void> updateWalletBalance(double amount);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final DioClient _dioClient;

  WalletRemoteDataSourceImpl(this._dioClient);

  @override
  Future<WalletModel> getWalletBalance() async {
    final response = await _dioClient.get('/customer/wallet');
    return WalletModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> updateWalletBalance(double amount) async {
    await _dioClient.post('/customer/wallet/update', data: {'amount': amount});
  }
}
