class Validator {
  /// 1- to handle error in all textfield ///
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return 'لا يمكن أن يكون الحقل فارغا';
    }

    return null;
  }

  /// 2- to get error if idDocs less than 3 characters
  static String? validateUserID({required String uid}) {
    if (uid.isEmpty) {
      return 'لا يمكن أن يكون الحقل فارغا';
    } else if (uid.length <= 3) {
      return 'يجب أن تكون مستندات الهوية أكبر من 3 أحرف';
    }

    return null;
  }
}