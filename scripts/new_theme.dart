// scripts/new_theme.dart
// Uso: dart scripts/new_theme.dart --name=artesier
import 'dart:io';

void main(List<String> args) {
  final name = args
      .firstWhere((a) => a.startsWith('--name='), orElse: () => '')
      .replaceFirst('--name=', '');

  if (name.isEmpty) {
    print('Uso: dart scripts/new_theme.dart --name=<slug>');
    exit(1);
  }

  final slug = name.toLowerCase().replaceAll(' ', '_');
  final pascal =
      slug.split('_').map((w) => '${w[0].toUpperCase()}${w.substring(1)}').join();
  final dir = 'packages/forma_theme_$slug';
  final templateDir = 'packages/_template';

  if (!Directory(templateDir).existsSync()) {
    print('Template directory not found: $templateDir');
    exit(1);
  }

  if (Directory(dir).existsSync()) {
    print('Directory already exists: $dir');
    exit(1);
  }

  _copyTemplate(templateDir, dir, slug, pascal);
  print('Variante "$pascal" criada em $dir');
  print('   Proximos passos:');
  print('   1. Edite $dir/lib/tokens/${slug}_colors.dart');
  print('   2. Edite $dir/lib/theme/${slug}_theme.dart');
  print('   3. Adicione ao Storybook em storybook/lib/themes/all_themes.dart');
  print('   4. Rode: melos bootstrap');
}

void _copyTemplate(String src, String dst, String slug, String pascal) {
  final srcDir = Directory(src);

  for (final entity in srcDir.listSync(recursive: true)) {
    final relativePath = entity.path.substring(src.length);
    final newRelativePath = relativePath
        .replaceAll('template', slug)
        .replaceAll('Template', pascal);
    final newPath = '$dst$newRelativePath';

    if (entity is Directory) {
      Directory(newPath).createSync(recursive: true);
    } else if (entity is File) {
      final parent = File(newPath).parent;
      if (!parent.existsSync()) {
        parent.createSync(recursive: true);
      }

      var content = entity.readAsStringSync();
      content = content
          .replaceAll('template', slug)
          .replaceAll('Template', pascal)
          .replaceAll('TEMPLATE_SLUG', slug)
          .replaceAll('TemplatePascal', pascal);
      File(newPath).writeAsStringSync(content);
    }
  }
}
