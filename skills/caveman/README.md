# caveman

Terse caveman voice for any coding agent: answer first, fluff gone, every technical fact kept.

## Install

```sh
./install.sh
```

Then invoke in a session:

- `/caveman` — turn on
- `/caveman off` — turn off
- `/caveman status` — report current mode
- natural language: "caveman mode", "talk like caveman", "be brief", "less tokens"

Persists for the session until "stop caveman" or "normal mode".

## What it does

Cuts output tokens by removing filler, greetings, hedging, and recap while preserving code, paths, numbers, errors, and every negation verbatim. See `SKILL.md` for the full ruleset.

## Upstream

Pulled from [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) (`skills/caveman/SKILL.md`, Apache-2.0). The original project also ships a Go proxy (`caveman-engine`) that enforces the rewrite on the wire — this entry is the prompt-only version. Run the proxy for guaranteed savings; the skill alone depends on the agent following it.

## Validate

```sh
./scripts/validate.sh
```
