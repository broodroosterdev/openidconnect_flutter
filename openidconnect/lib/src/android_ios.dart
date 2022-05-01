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
    //Launch the custom tabs window
    await tabs.launch(authorizationUrl);

    //Listen to incoming deep links
    return linkStream.first
        // to avoid an endless loop, timeout after a minute
        .timeout(
      Duration(minutes: 1),
      onTimeout: () => throw AuthenticationException(ERROR_USER_CLOSED),
    )
        // check if the value is null in case something bad happened
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
