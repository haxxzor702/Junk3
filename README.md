# Emberwild v43 — Web-ready project (iPhone Safari test)

This contains the latest v42 game code, with a Godot **Web** export preset and
mobile browser settings. It is **source**, not yet a playable website.

## Easy export using Godot on a Windows / Mac / Linux computer

1. Install Godot 4.4.1 and its matching export templates.
2. Open this folder as a Godot project.
3. Choose **Project → Export**, select the included **Web** preset.
4. Keep **Thread Support OFF**; export **Project** to `build/web/index.html`.
5. Open `build/web/` and ZIP the **files inside**, with index.html at the ZIP root.
6. On itch.io, create an HTML game page, upload that ZIP, and enable
   “This file will be played in the browser.”
7. Have your friend open the resulting URL in Safari in landscape orientation.

## Alternative: build and host without a computer, using GitHub Actions

Included: `.github/workflows/publish-web.yml`.

1. Create a repository on GitHub and upload the CONTENTS of this project folder
   to its repository root (so project.godot is at the top level).
   GitHub's web UI may not upload the hidden `.github` folder conveniently on a phone:
   create the workflow file at `.github/workflows/publish-web.yml` manually if needed.
2. In repository Settings → Pages → Build and deployment, choose GitHub Actions.
3. Visit repository Actions → “Publish Emberwild Web” → Run workflow, or push to main.
4. After a successful action, the site URL is listed in the deployment step and
   in Settings → Pages. Share that URL with your friend.

GitHub workflow needs to fetch Godot plus matching export templates, check the
GDScript in headless editor import, create a browser build, and publish it.
If a script has a parsing error, the build fails with logs instead of publishing.

## iPhone details

- Turn the iPhone to landscape and use the same left joystick and right attack stick.
- The Web preset is single-threaded: no special cross-origin-isolation headers.
- Web export uses the GL Compatibility renderer and Godot WebGL 2.
- Mobile Safari has known WebGL 2 quirks and might still need adjustments.
- Godot browser save data stays on that iPhone/browser profile, separate from Android.
  Clearing site data / private browsing can lose progress; there is no cloud sync.
- If touches scroll/zoom the page, ensure the included `html/head_include` CSS is present.
- Export through **Project**, not Export PCK/ZIP; PCK/ZIP alone isn't playable.
- The Godot Android Editor may not provide Web export functionality, so use
  desktop Godot or the included GitHub Actions workflow instead.

## What changed from v42

- Named game "Emberwild" for the web page.
- Added Web export preset with mobile Safari-friendly CSS and viewport resizing.
- Added automated browser build + GitHub Pages deployment workflow.
- Preserved all class models, character selection, inventory, monsters, saves,
  updated attack speeds, and green arrows from v42.

Note: The engine/export templates weren't available in the packaging environment,
so this project hasn't been compiled or run-tested as an HTML5 game here.
