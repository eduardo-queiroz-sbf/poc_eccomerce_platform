import 'package:foundation/interfaces/builders/screens/home.dart';
import 'package:foundation/interfaces/setup/app_setup_interface.dart';

class SetupEnv implements AppSetupInterface {
  @override
  final Map<String, AppSetupTypeInterface> environments = {
    EnvironmentsSetup.dev: AppSetupTypeInterface(
      appName: "Boilerplate Dev",
      initialRoute: HomeRoute.path,
      cvId: "14",
      apiHost: "https://apigateway.centauro.com.br/ecommerce",
      apiToken:
          "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGlnYXRld2F5LmRjLnNibmV0Iiwic3ViIjoid3d3LmNlbnRhdXJvLmNvbS5iciIsImlhdCI6MTU5MDY1NTkzOSwiY2xpZW50X2lkIjoiNDhiNWVhZWUtN2Q2Yy00ZjkxLTkxNDEtNTJkZDI2Nzk3MDI0In0.525TQWucU59Oesma_p2V1oSqvM8mWvEoTskNseLYeelfIwIb11Gith4oM5daLZ496A4MqBa03Nci4vFGBwqHgvAvVm-l4SkZFGh4Tk3htx1bm0mDkbgayyy9W7bYDeD0xkIyIWK-GwCK2Xdu5AzU79ZK5fNpxdoBGJe7lZgY4XmoLeB9MoGSVU4qsfBmtk7wNN8Qgi-EWk1Rvn4hpnmLDDUnOqjFw0f8lFiBhv04BpGfg80lRWcwqUKxydYcTCO0kpg_X95YsrZ-F8NtmyAJJ9TrN9yE2jJqj2mjBnamYEm8evJknnfx3UYbU8NJCRETIp6jGTProJANiYOZ5l0wdQ",
      authApi: "https://apigateway.centauro.com.br/ecommerce",
      authApiToken:
          "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGlnYXRld2F5LmRjLnNibmV0Iiwic3ViIjoid3d3LmNlbnRhdXJvLmNvbS5iciIsImlhdCI6MTUxNjIzOTAyMiwiY2xpZW50X2lkIjoiZTU3Nzk3ZDYtN2Y3Mi00MzMwLWJjOTItOTM3MWRiNjI0YjQ5In0.Mc2PpOJwltFymE3He95TpGTBPDAbhmxNw-cJEsYTghnGefWwhyiD--EopZquF2uH0bdF7K95SkK5RNaZ05Mh3ShuTbqPtD8D7kSr_zQO80nAyIHleLwQzrqrn5GF9piwVSt7YfVDWxj8rNA5HlXQpdTuu0vEUjHQk4hpapB8MtmE1qg9-bymyhD4Hm7x2XHMa-4AtPxhBotPBUwQKWNTbh3OUbCAETknA2tnwfFCSSS3nXot6Icuwx3hvtnkFTk3XitjPwLZ8xTlIJ5Uyk8MjjdG-poMFHKLrdvF7YzhAHUoNn-9Y91jIaYrSA_hDjgb-1y25Jw7UR_lO5F3ceSimg'",
      searchApi: "https://gateway.plataforma.centauro.com.br/yantar/api",
      searchApiToken:
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImZyb250LWVuZCBjZW50YXVybyIsIm5iZiI6MTU4OTkxOTgxMywiZXhwIjoxOTA1NDUyNjEzLCJpYXQiOjE1ODk5MTk4MTN9.YeCTBYcWozaQb4MnILtfeKTeyCwApNgLSOfGeVVM8D0",
      keyCloak: "https://keycloak.prd.gcp.gruposbf.com.br/auth/realms/nike",
      googleMapsKey: "AIzaSyDuOJw5ry5REt5bNq0Ub-mcrZK-qkU1chk",
      webviewUrlPdpInfo: "https://m.centauro.com.br/app-pdp-info",
      webviewUrlSearchPostalCode:
          "https://buscacepinter.correios.com.br/app/endereco/index.php",
    ),
  };
}
