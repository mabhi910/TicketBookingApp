import 'package:floor/floor.dart';

@Entity(tableName: 'booking')
class Booking {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'email')
  final String? email;
  @ColumnInfo(name: 'seat_id')
  final String? seatId;
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  Booking(
      {this.id,
        this.seatId,
        this.email,
        this.createdAt,
        this.updatedAt,});


}
