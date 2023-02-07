import 'package:cooking_record/const/custom_type.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionHandler {
  static FirebaseAuthResultStatus handleException(FirebaseAuthException e) {
    FirebaseAuthResultStatus result;
    switch (e.code) {
      case 'invalid-email':
        result = FirebaseAuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        result = FirebaseAuthResultStatus.wrongPassword;
        break;
      case 'user-disabled':
        result = FirebaseAuthResultStatus.userDisabled;
        break;
      case 'user-not-found':
        result = FirebaseAuthResultStatus.userNotFound;
        break;
      case 'operation-not-allowed':
        result = FirebaseAuthResultStatus.operationNotAllowed;
        break;
      case 'too-many-requests':
        result = FirebaseAuthResultStatus.tooManyRequests;
        break;
      case 'email-already-exists':
        result = FirebaseAuthResultStatus.emailAlreadyExists;
        break;
      case 'network-request-failed':
        result = FirebaseAuthResultStatus.networkError;
        break;
      default:
        result = FirebaseAuthResultStatus.undefined;
    }
    return result;
  }

  static String exceptionMessage(FirebaseAuthResultStatus result) {
    String? message = '';
    switch (result) {
      case FirebaseAuthResultStatus.successful:
        message = 'ログインに成功しました。';
        break;
      case FirebaseAuthResultStatus.emailAlreadyExists:
        message = '指定されたメールアドレスは既に使用されています。';
        break;
      case FirebaseAuthResultStatus.wrongPassword:
        message = 'パスワードが違います。';
        break;
      case FirebaseAuthResultStatus.invalidEmail:
        message = 'メールアドレスが不正です。';
        break;
      case FirebaseAuthResultStatus.userNotFound:
        message = '指定されたユーザーは存在しません。';
        break;
      case FirebaseAuthResultStatus.userDisabled:
        message = '指定されたユーザーは無効です。';
        break;
      case FirebaseAuthResultStatus.operationNotAllowed:
        message = '指定されたユーザーはこの操作を許可していません。';
        break;
      case FirebaseAuthResultStatus.tooManyRequests:
        message = '指定されたユーザーはこの操作を許可していません。';
        break;
      case FirebaseAuthResultStatus.networkError:
        message = 'ネットワークに接続できません。';
        break;
      case FirebaseAuthResultStatus.undefined:
        message = '不明なエラーが発生しました。';
        break;
    }
    return message;
  }
}
