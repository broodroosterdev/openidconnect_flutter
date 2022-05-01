part of openidconnect;

class OpenIdConnectAndroidiOS {
  static Future<String> authorizeInteractive({
    required BuildContext context,
    required String title,
    required String authorizationUrl,
    required String redirectUrl,
    required int popupWidth,
    required int popupHeight,
  }) async {
    //Create the url
    await tabs.launch(authorizationUrl);
    return linkStream.first
        .timeout(
      Duration(minutes: 1),
      onTimeout: () => throw AuthenticationException(ERROR_USER_CLOSED),
    )
        .then(
      (value) {
        if (value == null) {
          throw AuthenticationException(ERROR_USER_CLOSED);
        }
        return Future.value(value);
      },
    );
  }
}
