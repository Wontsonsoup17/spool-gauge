# Spool Gauge

Filament tracking for a Creality K1. Sign in, open a spool with its weight, log
the grams each print uses, and watch the level count down.

One static page on GitHub Pages. No server, no accounts service, no build step,
no dependencies beyond a webfont.

## What it does

- **New spool** — a name and the net weight of filament on the reel
- **Log a print** — the grams it will use, plus what the job was; the level
  counts down by that amount
- **The gauge** — percent and grams left, total used, print count, and how many
  more prints the spool holds at your running average
- **Correct by weighing** — put the spool on a kitchen scale, subtract the empty
  reel's weight, enter what is actually left; it replaces the estimate from
  there on
- **Several spools** — switch between them, archive one when it runs out
- **Backup and transfer** — export a JSON file, import it on another device

## The login

First time you open the page it asks you to create a username and password.
After that it asks for them each session. The password is never stored — only a
PBKDF2 hash of it, with a random salt, in this browser's local storage.

**Be clear about what this is.** A static page has no server, so nothing can
truly verify anything: the check runs in the browser, and anyone who opens
developer tools can bypass it or clear the stored data. It keeps a passer-by out
of your filament log. It is not protection for anything that matters. That
tradeoff is deliberate — this stays a single file on GitHub Pages, with nothing
else to run or pay for.

There is no password reset, because there is nothing that could confirm who you
are. The sign-in screen offers to clear the login, which also clears the spool
history stored in that browser.

## Storage, and the one real limitation

Everything lives in the browser you are using. Nothing leaves the device.

That means **your phone and your computer keep separate histories.** There is no
shared place to sync through without a backend, and a backend is exactly what
this project chose not to have. **Backup & transfer** is the workaround: export a
file from one device and import it on the other whenever you want them level.

Clearing site data, or a browser's own cleanup of it, erases the history. Export
a backup occasionally if the log matters to you.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The whole application — markup, styles, logic |

## Notes

- The one external request is the webfont from Google Fonts.
- Light and dark themes both follow the system setting.
- Add it to a phone home screen and it opens like an app.
