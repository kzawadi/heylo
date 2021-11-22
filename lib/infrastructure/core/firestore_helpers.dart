import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zawadi/domain/auth/use_cases/get_signed_in_user_use_case.dart';
import 'package:zawadi/domain/core/errors.dart';
import 'package:zawadi/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<GetSignedInUserUseCase>().call();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
