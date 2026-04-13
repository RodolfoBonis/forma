import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaPushNotification story — push notification preview banner.
WidgetbookComponent formaPushNotificationComponent() {
  return WidgetbookComponent(
    name: 'FormaPushNotification',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final appName = context.knobs.string(
            label: 'App Name',
            initialValue: 'Plantao Facil',
          );
          final body = context.knobs.string(
            label: 'Body',
            initialValue:
                'Ana quer trocar seu plantao de amanha. Toque para responder.',
          );
          final timestamp = context.knobs.string(
            label: 'Timestamp',
            initialValue: 'agora',
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaPushNotification(
              appName: appName,
              body: body,
              timestamp: timestamp,
            ),
          );
        },
      ),
    ],
  );
}
