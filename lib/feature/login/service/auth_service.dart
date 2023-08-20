import 'package:card/feature/user/service/user_service.dart';
import 'package:fast_log/fast_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serviced/serviced.dart';
import 'package:snackbar/snackbar.dart';

class AuthService extends StatelessService {
  bool isSignedIn() => FirebaseAuth.instance.currentUser != null;

  Future<void> signOut() => Future.wait(
      [FirebaseAuth.instance.signOut(), GoogleSignIn.standard().signOut()]);

  String? extractFirstName(User user) {
    List<String> dns = getPotentialExtractionNames(user);

    if (dns.isNotEmpty) {
      return dns.first.contains(" ") ? dns.first.split(" ").first : dns.first;
    }

    return null;
  }

  List<String> getPotentialExtractionNames(User user) {
    List<String> dns = user.providerData
        .where((element) => element.displayName != null)
        .map((e) => e.displayName!)
        .toList();
    if (user.displayName != null) {
      dns.add(user.displayName!);
    }

    success(
        "Extracted ${dns.length} display names from user: ${dns.join(",")}");
    return dns;
  }

  String? extractLastName(User user) {
    List<String> dns = getPotentialExtractionNames(user);

    if (dns.isNotEmpty) {
      return dns.first.contains(" ")
          ? dns.first.split(" ").sublist(1).join(" ")
          : dns.first;
    }

    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    late UserCredential c;

    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        c = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        GoogleSignInAccount? googleUser =
            await GoogleSignIn.standard().signIn();
        GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth == null) {
          error("Google Auth is null!");
          snack("Authentication Failure!");
        }

        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        c = await FirebaseAuth.instance.signInWithCredential(credential);
      }
      Map<String, dynamic> profile = c.additionalUserInfo?.profile ?? {};
      String? firstName = profile["given_name"] ?? extractFirstName(c.user!);
      String? lastName = profile["family_name"] ?? extractLastName(c.user!);
      //String? profilePictureUrl = profile["picture"];

      verbose("Google First Name: $firstName");
      verbose("Google Last Name: $lastName");
      await services().get<UserService>().getUserData(c.user!.uid,
          firstName: firstName, lastName: lastName, onSignedUp: (user) {
        info("User Signed Up!");
      });
    } catch (e, es) {
      error(e);
      error(es);
    }
    return c;
  }
}
