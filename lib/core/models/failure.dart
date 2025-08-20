
class Failure {
  String message;
  Failure({required this.message});
}

// New Error Response Class
class UpdatePasswordErrorResponse {
  final bool updated;
  final String message;
  final Map<String, List<String>>? errors;

  UpdatePasswordErrorResponse({
    required this.updated,
    required this.message,
    this.errors,
  });

  factory UpdatePasswordErrorResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordErrorResponse(
      updated: json['updated'] ?? false,
      message: json['message'] ?? '',
      errors: json['errors'] != null
          ? Map<String, List<String>>.from(
        json['errors'].map(
              (key, value) => MapEntry(
            key,
            List<String>.from(value is List ? value : [value.toString()]),
          ),
        ),
      )
          : null,
    );
  }

  // Get all error messages as a single formatted string
  String get formattedErrors {
    if (errors == null || errors!.isEmpty) {
      return message;
    }

    List<String> allErrors = [];
    errors!.forEach((field, messages) {
      // Clean field name (remove "PasswordData." prefix)
      String cleanField = field.replaceAll('PasswordData.', '');

      for (String msg in messages) {
        allErrors.add('• $cleanField: $msg');
      }
    });

    return allErrors.join('\n');
  }

  // Get specific field error
  String? getFieldError(String fieldName) {
    if (errors == null) return null;

    // Try exact match first
    if (errors!.containsKey(fieldName)) {
      return errors![fieldName]!.join(', ');
    }

    // Try with PasswordData prefix
    String prefixedField = 'PasswordData.$fieldName';
    if (errors!.containsKey(prefixedField)) {
      return errors![prefixedField]!.join(', ');
    }

    return null;
  }

  // Get all errors as a list for UI display
  List<String> get errorList {
    if (errors == null || errors!.isEmpty) {
      return [message];
    }

    List<String> allErrors = [];
    errors!.forEach((field, messages) {
      String cleanField = field.replaceAll('PasswordData.', '');
      allErrors.addAll(messages.map((msg) => '$cleanField: $msg'));
    });

    return allErrors;
  }

  Map<String, dynamic> toJson() {
    return {
      'updated': updated,
      'message': message,
      'errors': errors,
    };
  }
}
