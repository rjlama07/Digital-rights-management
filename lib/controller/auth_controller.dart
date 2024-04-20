import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/services/access_token_service.dart';
import 'package:nepalihiphub/services/auth_service.dart';
import 'package:nepalihiphub/view/follow_artist/follow_artist_page.dart';
import 'package:nepalihiphub/view/nav_bar/nav_bar.dart';

class AuthController extends GetxController {
  Box box = Hive.box('localData');
  RxBool isLoggedIn = false.obs;
  RxBool isSignup = false.obs;
  RxBool isSignUpLoading = false.obs;
  RxBool isLoginLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  RxBool isgoogleauth = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthState();
  }

  void checkAuthState() {
    bool checkLoginIn = box.get("isLoggedIn") ?? false;
    isLoggedIn.value = checkLoginIn;
  }

  void signUp(String firstName, String lastName, String email, String password,
      Function onsucess) async {
    isSignUpLoading.value = true;
    final response =
        await AuthServices().sigup(firstName, lastName, email, password);
    isSignUpLoading.value = false;
    response.fold(
        (l) => {
              isSignup.value = false,
              onsucess(),
            },
        (r) => {Get.snackbar("", r, backgroundColor: Colors.red)});
  }

  Future<void> login(String email, String password) async {
    isLoginLoading.value = true;
    final response = await AuthServices().login(email, password);
    isLoginLoading.value = false;
    response.fold(
        (l) => {
              box.put("isLoggedIn", true),
              isLoggedIn.value = true,
              AccessTokenService().saveAccessToken(l.accessToken),
              if (l.artistFollowing.isEmpty)
                {
                  Get.off(() => const FollowArtistPage()),
                }
              else
                {Get.to(() => const NavBar())}
            },
        (r) => {Get.snackbar("", r, backgroundColor: Colors.red)});
  }

  void logOut() {
    box.delete("accessToken");
    // box.put("isLoggedIn", false);
    // isLoggedIn.value = false;
  }

  void googleSignWithGoogle({
    required Function onsucess,
    required void Function(String) onerror,
  }) async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuthentication =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuthentication.accessToken,
          idToken: googleAuthentication.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        isgoogleauth.value = true;
        final serverResponse =
            await AuthServices().googleSignup(googleAuthentication.idToken!);
        serverResponse.fold((l) {
          box.put("isLoggedIn", true);
          isLoggedIn.value = true;
          onsucess();
        }, (r) {
          onerror(r);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // showMessage(
          //   "Error",
          //   'The account already exists with a different credential.',
          //   () {
          //     Get.back();
          //   },
          //   () {
          //     Get.back();
          //   },
          //   buttonText1: "Try Again",
          //   buttonText2: "Cancel",
          // );
        } else if (e.code == 'invalid-credential') {
          // showMessage(
          //   "Error",
          //   'Error occurred while accessing credentials. Try again.',
          //   () {
          //     Get.back();
          //   },
          //   () {
          //     Get.back();
          //   },
          //   buttonText1: "Try Again",
          //   buttonText2: "Cancel",
          // );
        }
      } catch (e) {
        // showMessage(
        //   "Error",
        //   'Error occurred using Google Sign-In. Try again.',
        //   () {
        //     Get.back();
        //   },
        //   () {
        //     Get.back();
        //   },
        //   buttonText1: "Try Again",
        //   buttonText2: "Cancel",
        // );
      }
    }
  }
}
