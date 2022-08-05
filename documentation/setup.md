# Setup

O processo para configurar um novo app consiste nas seguintes etapas:

- [Setup](#setup)
  - [Criar um novo app](#criar-um-novo-app)
  - [Configurar o pubspec.yaml](#configurar-o-pubspecyaml)
  - [Configurar o build.yaml](#configurar-o-buildyaml)
  - [Configurar o foundation](#configurar-o-foundation)
  - [Instalar uma feature](#instalar-uma-feature)
  - [Configurar o environment](#configurar-o-environment)
  - [Configurar o theme](#configurar-o-theme)
  - [Implementar o main](#implementar-o-main)
  - [Rodar o projeto](#rodar-o-projeto)

## Criar um novo app

Dentro da pasta `apps` crie um novo app utilizando o comando:

```sh
flutter create your_app_name --org com.yourdomain
```

ou copie um projeto existente e mova-o para a pasta `apps`.

## Configurar o pubspec.yaml

No `pubspec.yaml` adicione os seguintes packages como dependências:

```yaml
dependencies:
  flutter:
    sdk: flutter
  foundation:
    path: "./../../foundation"
  fairplay_ds:
    path: "./../../fairplay_ds"
  get_it: 7.2.0
  injectable: 1.5.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  build_runner: ^2.2.0
```

## Configurar o build.yaml

Na raiz do seu app `(/apps/<my-app>)` crie o arquivo `build.yaml` com o seguinte código:

```yaml
targets:
  $default:
    builders:
      foundation:foundation_builder:
        generate_for:
          include:
            - "lib/features/search/**"
            - "lib/theme/**"
            - "lib/routes.dart"
            - "lib/foundation/router/**"
            - "lib/setup.dart"
          exclude:
            - "lib/foundation/context/**"
```

## Configurar o foundation

Faça uma copia da pasta `apps/boilerplate/lib/foundation` e cole-a dentro da pasta `lib` do seu app, ficando com a seguinte estrutura: `apps/my-app/lib/foundation`.

Exclua o arquivo `apps/my-app/lib/foundation/context/locator.config.dart` pois ele será gerado automaticamente quando rodarmos o `build_runner` do projeto.


## Instalar uma feature

Adicione a feature desejada no `pubspec.yaml` do seu app. Neste caso vou usar a feature "home" como exemplo:

```yaml
dependencies:
  home:
    path: "./../../features/home"
```

## Configurar o environment

Dentro da pasta `lib` do seu app, crie o arquivo `setup.dart` contendo as configurações básicas do projeto. Exemplo:

```dart
import 'package:foundation/interfaces/builders/screens/home.dart';
import 'package:foundation/interfaces/setup/app_setup_interface.dart';

class SetupEnv implements AppSetupInterface {
  @override
  final Map<String, AppSetupTypeInterface> environments = {
    EnvironmentsSetup.dev: AppSetupTypeInterface(
      appName: "My app name",
      initialRoute: HomeRoute.path,
      cvId: "00",
      apiHost: "https://my-site",
      apiToken: "Bearer 000",
      authApi: "https://my-site/ecommerce",
      authApiToken: "Bearer 000",
      searchApi: "https://my-site/search/api",
      searchApiToken: "Bearer 000",
      keyCloak: "https://my-keycloak/",
      googleMapsKey: "123",
      webviewUrlPdpInfo: "https://m.centauro.com.br/app-pdp-info",
      webviewUrlSearchPostalCode:
          "https://buscacepinter.correios.com.br/app/endereco/index.php",
    ),
  };
}
```

## Configurar o theme

Faça uma copia da pasta `apps/boilerplate/lib/theme` e cole-a dentro da pasta `lib` do seu app, ficando com a seguinte estrutura: `apps/my-app/lib/theme`.

## Implementar o main

Segue abaixo uma implementação simples do arquivo `apps/my-app/lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:foundation/interfaces/setup/setup_widget.dart';

import 'foundation/context/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const FoundationSetup(setupLocator, CircularProgressIndicator());
  }
}
```

## Rodar o projeto

Para rodar o projeto execute os seguintes comandos:

```sh
flutter pub get
```

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

```sh
flutter run build
```
