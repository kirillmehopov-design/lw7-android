# Homework & Lab 7 - Multi-Screen Navigation

**Sole Space** is a Flutter sneaker store demo using photographs of real sneaker models.

## Features

- Feed: four real-world sneaker models with catalog photographs, titles, categories and demo prices
- Favorites: save and remove items
- Profile: account view and working Notifications switch
- DetailScreen: Navigator.push passes the complete Product object
- Two working Navigator.pop controls: AppBar back arrow and in-body button
- Favorite items and selected tab remain in memory after navigating back

## Products and photo sources

- Nike Air Force 1 '07 (white) — [SNIPES](https://www.snipes.com/de-ch/p/nike-air-force-1-07-whitewhite-air-force-1-07-weiss-1727)
- adidas Samba (white/black) — [BeyondStyle](https://www.beyondstyle.us/prod/adidas-originals-samba-mens?id=champssports_B75806)
- Converse Chuck Taylor All Star High Top (black) — [Converse](https://www.converse.hr/chuck-taylor-all-star-cm9160c)
- New Balance 574 Greenleaf (grey) — [Super Runners Shop](https://superrunnersshop.com/products/mens-new-balance-574-greenleaf-ml574evg)

The photos are loaded from external product listings and are credited to their respective websites; the demo does not claim to own them. An internet connection is needed to load photos, and a fallback icon is shown if an external source cannot be reached. Prices are fictional demo prices, not current store offers.

## Run

Requires Flutter SDK (Dart >= 3.0).

1. Open this folder in Android Studio.
2. Run `flutter create .` if platform folders are missing.
3. Run `flutter pub get`.
4. Run `flutter run`.

## Test

Run `flutter test`.

## Required short recording

Record the running app: Feed > product details > save to favorites > in-body Back > Favorites > open saved product > AppBar Back > Profile. Record on an emulator or phone and submit your MP4 alongside the GitHub repo URL.

No screen recording is included because the app has not been launched in this environment.
