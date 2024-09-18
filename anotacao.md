## Dep
```bash
flutter pub get
```

## Dev
```bash
flutter run -d chrome
```

## Deploy

Inicialize o Firebase Hosting caso não tenha feito:
```bash
firebase init
```
Deploy:

```bash
flutter build web
firebase deploy
```
Obs: dar flutter clean para minimizar bugs

## Android
Com o Android Studio já instalado e com o flutter doctor retornando tudo ok executar 

flutter devices

em seguida

flutter -d run emulador_nome

## Todo

    - [x] Depreciar button custom e usar estilo theming
    - [ ] Adicionar validações nos inputs e exceções para entradas incorretas
    - [ ] Aprender otimização e refatoração

## Web

https://halley-14447.web.app/