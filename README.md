# pocketbase_flutter_app

<a href="https://twitch.tv/lukepighetti">
    <img src="https://img.shields.io/twitch/status/lukepighetti?logo=twitch&logoColor=FFFFFF&label=Twitch&color=9C34A3" alt="Twitch status">
</a>
<a href="https://discord.gg/g84tgDYVnb">
    <img src="https://img.shields.io/discord/1014298178033557637?logo=discord&label=Discord&color=9C34A3&logoColor=FFFFFF" alt="chat on Discord">
</a>

A quick app written with PocketBase and Flutter live on [Twitch](https://twitch.tv/lukepighetti).

Displays user submissions of their Android home screen and lock screen.

<img height="500" src="doc/screenshot.png" title="A screenshot of this app"/>

## Secrets

Copy `pb_app/lib/secrets.ci.dart` to `pb_app/lib/secrets.dart` and add your own secrets.

## Setup

To get started, you can follow the Pocketbase setup instructions [here](https://pocketbase.io/docs/)

After creating an admin account at `http://127.0.0.1:8090/_/`, create a user account that matches the login information found in
`pb_app/lib/secrets.dart`

## Contributing

<a href="https://github.com/lukepighetti/pocketbase_flutter_app/search?q=TODO+filename%3A*.dart" alt="TODOs">
    <img src="https://shields.io/github/search/lukepighetti/pocketbase_flutter_app/TODO%20filename%3A%2A.dart?label=TODOs&color=9C34A3" />
</a>

Contributions are encouraged, but I expect a high standard of quality. I promise to give a thoughtful review and guide you towards success, even if you're new to coding.

Since your time is valuable, keep these points in mind:

1. Commit the minimum diffs to make your change
2. New UI should be _Material Plus_ (Material with a little extra sparkle ✨)
3. New UX should be simple and thoughtful
4. New code should follow existing patterns
