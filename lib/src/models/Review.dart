class Review {
  final int bookingId;
  final int rating; // 1 to 5
  final String comment;
  final DateTime submittedAt;

  Review({
    required this.bookingId,
    required this.rating,
    required this.comment,
    required this.submittedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'rating': rating,
      'comment': comment,
      'submitted_at': submittedAt.toIso8601String(),
    };
  }
}