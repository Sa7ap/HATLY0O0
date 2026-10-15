import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../customer_orders/presentation/bloc/customer_order_bloc.dart';
import '../../customer_orders/presentation/bloc/customer_order_event.dart';
import '../../customer_orders/presentation/bloc/customer_order_state.dart';
import '../../customer_orders/domain/entities/address_entity.dart';
import 'add_address_page.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  @override
  void initState() {
    super.initState();
    // إطلاق حدث استدعاء وجلب العناوين الجغرافية المسجلة فور فتح الشاشة
    context.read<CustomerOrderBloc>().add(GetSavedAddressesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'عناويني المحفوظة 📍',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // يتبع مباشرة الجزء 2 من 2 لبناء جسم الـ BlocBuilder وكروت العرض...
      body: SafeArea(
        child: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
          builder: (context, state) {
            List<AddressEntity> addressesList = [];

            if (state is GetSavedAddressesSuccessState) {
              addressesList = state.addresses;
            }

            if (state is CustomerOrderLoadingState && addressesList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: addressesList.isEmpty
                      ? const Center(
                          child: Text(
                            'لا توجد عناوين مسجلة حالياً.',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: addressesList.length,
                          itemBuilder: (context, index) {
                            final addr = addressesList[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.06),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(alpha: 0.06),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.green,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          addr.title,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${addr.city} - ${addr.fullAddress}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddAddressPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_location_alt_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'إضافة عنوان جديد',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
