# pocketbase_flutter_app

A quick app written with PocketBase and Flutter.

Displays user submissions of their Android home screen and lock screen.

<img height="500" src="doc/screenshot.png" title="A screenshot of this app"/>


## Environment Variables

We use two environment variables to skip login for test purposes.

These must be passed to dart with the argument `--dart-define`. VSCode is currently setup to use the following environment variables on your system. Other IDEs will have their own setup.

```
PBF_TEST_EMAIL
PBF_TEST_PASSWORD
```