
// import 'package:flutter/material.dart';
// import 'package:property_system/client/reservation%20_for_client/get_and_delet_reservation_service.dart';
// import 'package:property_system/client/reservation%20_for_client/get_reservation_client_model.dart';
// import 'package:property_system/client/reservation%20_for_client/reserved_property_card.dart';

// class ClientReservedPropertyForSellPage extends StatefulWidget {
//   const ClientReservedPropertyForSellPage({super.key});

//   @override
//   State<ClientReservedPropertyForSellPage> createState() =>
//       _ClientReservedPropertyForSellPageState();
// }

// class _ClientReservedPropertyForSellPageState
//     extends State<ClientReservedPropertyForSellPage> {
//   List<GetReservationClientModel> reservations = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchReservations();
//   }

//   Future<void> fetchReservations() async {
//     // لو عندك endpoint خاص بـ get all, استعمله هنا
//     final service = GetOneAndDeletClientReservationService();
//     // مثال: تجيب ID للحجز وتستدعي getOne
//     // حالياً رح أخليها فاضية لأن ما عندنا API للكل
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> removeReservation(String reservationId) async {
//     final success =
//         await GetOneAndDeletClientReservationService().deleteReservation(reservationId);

//     if (success) {
//       setState(() {
//         reservations.removeWhere((r) => r.reservationId == reservationId);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (reservations.isEmpty) {
//       return const Center(child: Text("لا يوجد عقارات محجوزة"));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: reservations.length,
//       itemBuilder: (context, index) {
//         final reservation = reservations[index];
//         return ReservedPropertyCard(
//           reservation: reservation,
//           onDelete: () => removeReservation(reservation.reservationId),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/reservation%20_for_client/get_and_delet_reservation_service.dart';
import 'package:property_system/client/reservation%20_for_client/get_reservation_client_model.dart';
import 'package:property_system/client/reservation%20_for_client/reserved_property_card.dart';

class ClientReservedPropertyForSellPage extends StatefulWidget {
  const ClientReservedPropertyForSellPage({super.key});

  @override
  State<ClientReservedPropertyForSellPage> createState() =>
      _ClientReservedPropertyForSellPageState();
}

class _ClientReservedPropertyForSellPageState
    extends State<ClientReservedPropertyForSellPage> {
  List<GetReservationClientModel> reservations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    final service = GetOneAndDeletClientReservationService();
    // هنا لازم تجيب كل الحجوزات إذا عندك API جاهز
    setState(() {
      isLoading = false;
    });
  }

  Future<void> removeReservation(String reservationId) async {
    final success =
        await GetOneAndDeletClientReservationService().deleteReservation(reservationId);

    if (success) {
      setState(() {
        reservations.removeWhere((r) => r.reservationId == reservationId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم حذف الحجز ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل حذف الحجز ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reservations.isEmpty
              ? const Center(child: Text("لا يوجد عقارات محجوزة"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = reservations[index];
                    return ReservedPropertyCard(
                      reservation: reservation,
                      onDelete: () =>
                          removeReservation(reservation.reservationId),
                    );
                  },
                ),
    );
  }
}
