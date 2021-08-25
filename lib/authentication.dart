import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider {
  //1. class          instance (salinan)
  // variable Firebase Auth
  final FirebaseAuth firebaseAuth;

  //2. Constructor
  AuthenticationProvider(this.firebaseAuth);

  //Guna Stream utk dengar perubahan keadaan Authentication
  // Keadaan dia login atau logout
  //User ne adalah FirebaseUser bukan User dari kelas kita tadi
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  //KITA AKAN BUAT 3 FUNCTIONS: SignUp, SignIn, SignOut
  //
  //1. SignUp
  Future signUp({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //2. SignIn
  Future signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //3. SignOut
  Future signOut() async {
    await firebaseAuth.signOut();
  }
  
}
