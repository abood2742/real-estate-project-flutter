import 'package:flutter/material.dart';
import 'package:property_system/client/reservation%20_for_client/get_reservation_client_model.dart';

class ReservedPropertyCard extends StatelessWidget {
  final GetReservationClientModel reservation;
  final VoidCallback onDelete;

  const ReservedPropertyCard({
    super.key,
    required this.reservation,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final property = reservation.property;
    final imageUrl =
        property.photos.isNotEmpty ? property.photos.first.url : null;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة العقار
          if (imageUrl != null)
            Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 40),
              ),
            )
          else
            Container(
              height: 180,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 40),
            ),

          // تفاصيل
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان (نوع العقار)
                Text(
                  property.propertyType.name,
                  style: const TextStyle(
                    color: Colors.green,
                    fontFamily: 'Pacifico',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        property.location.city,
                        style: const TextStyle(
                          fontFamily: 'Pacifico',
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      property.price,
                      style: const TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.space_bar, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      '${property.space} m²',
                      style: const TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reservation.createdAt != null
                          ? 'تاريخ الحجز: ${reservation.createdAt!.toLocal().toString().split(' ').first}'
                          : 'تاريخ الحجز: غير متوفر',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    RawMaterialButton(
                      onPressed: onDelete,
                      elevation: 2.0,
                      fillColor: const Color(0xFF1565C0),
                      constraints: const BoxConstraints(minWidth: 0.0),
                      child: const Icon(
                        Icons.delete_outline_sharp,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      shape: const CircleBorder(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
