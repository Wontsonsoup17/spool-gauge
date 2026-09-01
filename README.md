# Spool Gauge

Filament tracking for a Creality K1. Log the grams each print uses, watch the reel
deplete, and correct the running count by weighing the spool.

A single static page. No build step, no server of its own, no keys in this
repository.

## Using it

Open the page, name a spool and give the net weight of filament on the reel
(the filament, not the plastic reel). After each print, enter the grams the
slicer reported. The gauge shows what is left, how much has gone, and — once
there is a few prints of history — roughly how many more prints the spool holds.

Estimates drift, because purge lines, priming, brims and failed prints all burn
filament the slicer never counted. **Correct by weighing** is the fix: put the
spool on a kitchen scale, subtract the empty reel's weight, and enter what is
actually left. That figure replaces the estimate from that point forward.

## Storage

Out of the box the page stores everything in the browser it is opened in. That
works, but a phone and a laptop each keep their own separate copy.

To sync across devices, connect a Supabase project — yours, free tier is ample:

1. Create a project at supabase.com.
2. Open the **SQL Editor**, paste in [`schema.sql`](./schema.sql), run it.
3. In **Authentication → Providers**, make sure Email is enabled. No password is
   used; sign-in is a one-time link sent to your inbox.
4. In **Authentication → URL Configuration**, add this page's URL to the
   redirect allow-list.
5. Open the page. It asks for your **Project URL** and **anon public key**, both
   under **Settings → API**. Enter them, then sign in with your email.

Repeat step 5 on each device you want to use, signing in with the same email.

### About that key

The anon key belongs in client code — that is what it is for. It grants nothing
on its own: the row-level security policies in `schema.sql` are what restrict
every row to the user who owns it, and they are enforced by the database, not by
this page. It is still kept out of this repository and stored in the browser, so
the published site carries no configuration at all.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The whole application — markup, styles and logic |
| `schema.sql` | One table, row-level security, realtime |

## Notes

- Fonts come from Google Fonts; the Supabase client from jsDelivr. Everything
  else ships in the page.
- Light and dark themes both follow the system setting.
- Add it to a phone home screen and it opens like an app.
