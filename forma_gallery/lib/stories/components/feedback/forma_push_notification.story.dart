import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaPushNotification story — push notification preview banner.
GalleryComponent formaPushNotificationComponent() {
  return GalleryComponent(
    'FormaPushNotification',
    docs: const ComponentDocs(
      description:
          'Push notification preview banner resembling an iOS/Android system '
          'notification with app icon, app name, timestamp, and message body.',
      props: [
        PropDoc(
          'appName',
          'String',
          required: true,
          description: 'App name shown in the header.',
        ),
        PropDoc(
          'body',
          'String',
          required: true,
          description: 'The notification message body.',
        ),
        PropDoc(
          'appIcon',
          'Widget?',
          description: 'Optional app icon; defaults to an initial avatar.',
        ),
        PropDoc(
          'timestamp',
          'String',
          defaultValue: "'agora'",
          description: 'Timestamp label next to the app name.',
        ),
      ],
      codeSnippet: '''
FormaPushNotification(
  appName: 'Plantao Facil',
  body: 'Ana quer trocar seu plantao de amanha.',
  timestamp: 'agora',
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final appName = k.string(
          label: 'App Name',
          initialValue: 'Plantao Facil',
        );
        final body = k.string(
          label: 'Body',
          initialValue:
              'Ana quer trocar seu plantao de amanha. Toque para responder.',
        );
        final timestamp = k.string(label: 'Timestamp', initialValue: 'agora');

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaPushNotification(
            appName: appName,
            body: body,
            timestamp: timestamp,
          ),
        );
      }),
    ],
  );
}
