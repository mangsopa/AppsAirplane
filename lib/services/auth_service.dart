import 'package:airplaneapps/models/user_model.dart';
import 'package:airplaneapps/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await UserService().getUserById(userCredentials.user!.uid);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String hobby = '',
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        hobby: hobby,
        balance: 5000000,
      );

      await UserService().setUser(user);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
