import 'package:card/feature/user/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_log/fast_log.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:serviced/serviced.dart';

class UserService extends StatelessService {
  /// Retrieve the current user data from the user id: [uid].
  Future<User> getUserData(String uid,
          {String? firstName,
          String? lastName,
          ValueChanged<User>? onSignedUp}) =>
      FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .get()
          .then((value) async {
        verbose("User Data: ${value.data()}");
        User us = User.fromJson(value.data() ?? <String, dynamic>{});
        if (!value.exists) {
          verbose("User data does not exist. Creating it...");
          us.firstName = firstName ?? us.firstName;
          us.lastName = lastName ?? us.lastName;

          if (!(us.registered ?? false)) {
            verbose("User is not registered. Registering...");
            us.registered = true;
            verbose("Calling onSignedUp");
            onSignedUp?.call(us);
            verbose(
                "Setting registration email as ${auth.FirebaseAuth.instance.currentUser?.email}");
            us.emailAddress ??= auth.FirebaseAuth.instance.currentUser?.email;
          }

          warn("User data does not exist. Creating it...");
          await FirebaseFirestore.instance
              .collection("user")
              .doc(uid)
              .set(us.toJson());
          verbose("User data created.");
        }

        if (auth.FirebaseAuth.instance.currentUser != null &&
            auth.FirebaseAuth.instance.currentUser!.email != us.emailAddress) {
          warn(
              "Updating email address to ${auth.FirebaseAuth.instance.currentUser!.email}");
          us.emailAddress = auth.FirebaseAuth.instance.currentUser!.email;
          // userUidForEmail().then((value) {
          //   if (value.ok ?? false) {
          //     success("Updated email address to ${us.emailAddress}");
          //   }
          // });
        }

        us.uid = uid;
        return us;
      });
}
