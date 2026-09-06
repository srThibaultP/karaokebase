# Fork notes

This is a mirror of [gitlab.com/kara.moe/karaokebase](https://gitlab.com/kara.moe/karaokebase)
(licensed ODbL / CC-BY-SA 4.0 — see `LICENSE.md`), used as the repository for a
private Karaoke Mugen Server instance.

## What differs from upstream

Only the local overrides in [`.github/overrides.sh`](.github/overrides.sh):
`"noLiveDownload"` is cleared on the **Asia**, **West** and **Non-Latin**
collection tags so that non-admin visitors can play those karas in the browser.

## How it stays in sync

`.github/workflows/sync-upstream.yml` runs nightly: it merges `upstream/master`
(preferring upstream on conflicts) and re-applies `overrides.sh`. History only
moves forward — never force-pushed — so the KM Server's shallow `git pull` keeps
working.

To sync immediately: Actions → **sync-upstream** → *Run workflow*.

## Consuming instance

KM Server `config.yml` → `System.Repositories[0]`:

```yaml
Git:
  URL: https://github.com/srThibaultP/karaokebase.git
  Branch: master
SourceArchiveURL: https://github.com/srThibaultP/karaokebase/archive/refs/heads/master.zip
```

A `POST /api/update` (git pull + full DB regen) is what pulls new overrides into
the running DB.
