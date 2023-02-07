class ErrCheckFunction {
  static final ErrCheckFunction singleton = ErrCheckFunction._internal();
  ErrCheckFunction._internal();

  factory ErrCheckFunction() {
    return singleton;
  }

  String? checkNull(String? value) {
    return (value == null || value.trim() == "") ? '必須入力です。' : null;
  }

  String? checkEmail(String? value) {
    if (value == null || value.trim() == "") {
      return '必須入力です。';
    } else if (!value.contains("@")) {
      return 'メールアドレスの形式が間違っています。';
    } else {
      return null;
    }
  }

  String? checkPassword(String? value) {
    if (value == null || value.trim() == "") {
      return '必須入力です。';
    } else if (value.length < 6) {
      return 'パスワードは6文字以上で入力してください。';
    } else {
      return null;
    }
  }

  String? checkPasswordRe(String? value, String? compare) {
    if (value == null || value.trim() == "") {
      return '必須入力です。';
    } else if (!(value == compare)) {
      return '上のパスワードと異なります。';
    } else {
      return null;
    }
  }
}
