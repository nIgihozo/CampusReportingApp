import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    // Allow signup only for users with an ALU emails.
    Future<String?> signUp({
        required String role,
        required String email,
        required String name,
        required String password,
        String? extraDetail,
    }) async {
        if (!email.endsWith('@alustudent.com') && !email.endsWith('@alueducation.com')) {
            return 'Must use student or faculty ALU emails for you to be able to continue with creating account on this app.';
        }

        try {
            UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );  

            // Saving User Data and Their Roles To The Firestore
            await _db.collection('users').doc(userCredential.user!.uid).set({
                'uid': userCredential.user!.uid,
                'name': name,
                'email': email,
                'role': role,
                'extraDetail': extraDetail ?? '',
                'createdAt': FieldValue.serverTimestamp(),
            });

            await userCredential.user!.sendEmailVerification();
            return null;
        } on FirebaseAuthException catch (e) {
            return e.message;
        } catch (e) {
            return e.toString();
        }
    }

    // Handling signIn for user that created an account
    Future<String?> signIn(String email, String password) async {
        try {
            await _auth.signInWithEmailAndPassword(email: email, password: password);
            return null;
        } on FirebaseAuthException catch (e) {
            return e.message;
        } 
    }

    // Reset Password
    Future<String?> resetPassword(String email) async {
        try {
            await _auth.sendPasswordResetEmail(email: email);
            return null;
        } on FirebaseAuthException catch (e) {
            return e.message;
        } catch (e) {
            return e.toString();
        }
    }
}