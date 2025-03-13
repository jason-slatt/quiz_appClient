//implementing leaderBoard data
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Map<String, dynamic>>> getLeaderboard() {
  return FirebaseFirestore.instance
      .collection('leaderboard')
      .orderBy('totalPoints', descending: true)
      .limit(10)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}

void updateUserScore(String userId, String username, int newPoints) async {
  final leaderboardRef = FirebaseFirestore.instance.collection('leaderboard');

  await leaderboardRef.doc(userId).set({
    'username': username,
    'totalPoints': FieldValue.increment(newPoints),
  }, SetOptions(merge: true));
}

Future<Map<String, dynamic>?> getUserRankAndPoints(String userId) async {
  final leaderboardRef = FirebaseFirestore.instance.collection('leaderboard');

  // Get all users sorted by totalPoints (descending)
  final querySnapshot =
      await leaderboardRef.orderBy('totalPoints', descending: true).get();

  List<Map<String, dynamic>> allUsers = querySnapshot.docs
      .map((doc) => {
            'userId': doc.id,
            'username': doc['username'],
            'totalPoints': doc['totalPoints'],
          })
      .toList();

  // Find the rank of the current user
  for (int i = 0; i < allUsers.length; i++) {
    if (allUsers[i]['userId'] == userId) {
      return {
        'rank': i + 1, // Rank is index + 1 (since index starts at 0)
        'totalPoints': allUsers[i]['totalPoints'],
      };
    }
  }

  return null; // User not found in leaderboard
}
