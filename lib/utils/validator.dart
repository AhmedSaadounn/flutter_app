class Validator {
  /// 1- to handle error in all textfield ///
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }

    return null;
  }

  /// 2- to get error if idDocs less than 3 characters
  static String? validateUserID({required String uid}) {
    if (uid.isEmpty) {
      return 'id Docs can\'t be empty';
    } else if (uid.length <= 3) {
      return 'id Docs should be greater than 3 characters';
    }

    return null;
  }
}