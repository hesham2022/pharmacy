DateTime? parseToNullOrDate(String? date) =>
    date != null ? DateTime.parse(date) : null;
