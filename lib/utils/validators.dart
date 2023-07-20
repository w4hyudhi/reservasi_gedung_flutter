// File For Reusing Validators Of User Input Accross The App

class EmailValidator {
  static String? validate(String? value) {
    String ern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(ern);
    if (value != null && !regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    return (value != null && value.length < 6)
        ? 'Enter a password 6+ chars long'
        : null;
  }
}

class NameValidator {
  static String? validate(String? value) {
    return (value != null && value.length < 1) ? 'Masukan Nama Anda' : null;
  }
}

class AgeValidator {
  static String? validate(String? value) {
    return (value != null &&
            value.length >= 2 &&
            (int.parse(value) < 100 && int.parse(value) > 4))
        ? null
        : 'Masukan umur yang benar ';
  }
}

// class StudentValidationMixin {
//   static String? validateFirstName(String ? value) {
//     if (value == null) return "İsim boş olamaz!";

//     if ((value.length >= 2 &&
//             (int.parse(value) < 100 && int.parse(value) > 4))) {
//       return 'İsim en az iki karakter olmalıdır';
//     }
//     return null;
//   }
// }

class WeightValidator {
  static String? validate(String? value) {
    return (value != null &&
            value.length >= 2 &&
            (int.parse(value) <= 120 && int.parse(value) >= 20))
        ? null
        : 'Masukan berat yang benar antara 20kg -120kg';
  }
}

class HeightValidator {
  static String? validate(String? value) {
    return (value != null &&
            value.length >= 2 &&
            (int.parse(value) <= 250 && int.parse(value) >= 70))
        ? null
        : 'masukan tinggi yang benar antara 80cm - 240cm';
  }
}
