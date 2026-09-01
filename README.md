# Spool Gauge

Filament tracking for a Creality K1. Sign in, open a spool, log the grams each
print uses, and watch the reel count down. Correct the running total by weighing
the spool whenever the estimate drifts.

A single static page. No build step, no server of its own, no keys and no
passwords in this repository.

## What it does

- **Open a spool** — a name and the net weight of filament on the reel
- **Log a print** — the grams, plus what the job was, and the level counts down
- **Read the gauge** — percent and grams remaining, total used, print count, and
  how many more prints the spool holds at your running average
- **Correct by weighing** — enter the true remaining grams from a kitchen scale
  and it replaces the estimate from that point on
- **Several spools** — switch between them, archive one when it runs out

## Setup

The page holds no account of its own. Authentication and storage are a Supabase
project you own — free tier is ample.

1. Create a project at [supabase.com](https://supabase.com).
2. **SQL Editor** → paste [`schema.sql`](./schema.sql) → Run. One table, row-level
   security, realtime.
3. **Authentication → Providers → Email**: leave it enabled, and turn
   **"Confirm email"** off so a new user can sign in immediately.
4. **Authentication → Sign In / Providers → "Allow new users to sign up"**: turn
   this **OFF**. Nobody can create an account; only the user you add by hand works.
5. **Authentication → Users → Add user**: create your single account with the
   email and password you want to sign in with. This is the only place a password
   is ever set.
6. **Authentication → URL Configuration**: add this site's URL to the redirect
   allow-list.
7. Open the site. It asks once for your **Project URL** and **anon public key**
   (both under **Settings → API**), then shows the sign-in form.

Do step 7 once per device. The same username and password works everywhere and
the spool history follows.

### Why this is actually private

Sign-in is checked by Supabase, not by this page — there is no password in the
code to read, and no client-side check to bypass. Every row in `spool_state` is
locked to its owner by row-level security enforced inside the database, so even a
valid session for a different account returns nothing.

The anon key that lives in the browser is a public client key by design. It
identifies the project; it grants nothing. It is kept out of this repository
anyway, so the published site ships with no configuration at all.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The whole application — markup, styles, logic |
| `schema.sql` | One table, row-level security, realtime |

## Notes

- Fonts from Google Fonts, the Supabase client from jsDelivr; everything else
  ships in the page.
- Light and dark both follow the system setting.
- Add it to a phone home screen and it opens like an app.
