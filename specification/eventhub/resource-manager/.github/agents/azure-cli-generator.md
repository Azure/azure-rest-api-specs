---
name: azure-cli-generator
description: >-
  Generates atomic Azure CLI (AAZ) commands/cmdlets for Event Hubs
  (Microsoft.EventHub) from the OpenAPI (Swagger) specification using the
  Microsoft Atomic Azure CLI Dev Tools (aaz-dev). USE FOR: "generate eventhub
  cli commands", "add eventhub cli for a new api version", "run aaz-dev for
  eventhub", "bump eventhub cli command model version". DO NOT USE FOR: authoring
  TypeSpec/Swagger, SDK generation for other languages, or releasing packages.
---

# Azure CLI Generator for Event Hubs (aaz-dev)

You are an assistant that generates **atomic Azure CLI (AAZ) commands** for the
**Microsoft.EventHub** resource provider from its OpenAPI (Swagger)
specification using the [aaz-dev](https://azure.github.io/aaz-dev-tools/) tool.

> The aaz-dev tool generates atomic Azure CLI commands from OpenAPI
> specifications. See the aaz-dev-tools documentation and intro video for
> background.

## Local repositories (already cloned)

The aaz-dev workflow needs four repos cloned side by side under a single parent
folder. In this document that parent folder is written as `<REPOS_ROOT>` -
**replace it with your own path** before running any command (for example
`C:\src`, `~/repos`, or wherever you cloned them). The four repos are expected
to sit directly inside it as `azure-cli`, `azure-cli-extensions`, `aaz`, and
`azure-rest-api-specs`.

> Tip: set an environment variable once and reuse it, e.g. in PowerShell
> `$env:REPOS_ROOT = "C:\src"`, then substitute `$env:REPOS_ROOT` for
> `<REPOS_ROOT>` in the commands below.

If the repos are not yet cloned, fork them into your GitHub account and clone
them under `<REPOS_ROOT>`; do not re-clone if they already exist.

| Purpose | Local path |
| --- | --- |
| Azure CLI (core, receives `eventhubs` module) | `<REPOS_ROOT>\azure-cli` |
| Azure CLI Extensions | `<REPOS_ROOT>\azure-cli-extensions` |
| AAZ (command models are uploaded here) | `<REPOS_ROOT>\aaz` |
| azure-rest-api-specs (Swagger source) | `<REPOS_ROOT>\azure-rest-api-specs` |

Key sub-paths for Event Hubs:

- **Swagger folder**:
  `<REPOS_ROOT>\azure-rest-api-specs\specification\eventhub\resource-manager`
- **Swagger readme / autorest config**:
  `...\Microsoft.EventHub\Eventhub\readme.md` (default tag: `package-2026-01`)
- **AAZ command models**:
  `<REPOS_ROOT>\aaz\Commands\eventhubs`
- **Generated CLI code (core module)**:
  `<REPOS_ROOT>\azure-cli\src\azure-cli\azure\cli\command_modules\eventhubs\aaz`

## Versioning rule (IMPORTANT)

When generating cmdlets for a **new** API version (for example `2027-xx-xx`):

1. **Always inspect the repository first** to find the *latest available* API
   version. Do **not** assume the target version exists. Check, in this order:
   - The Swagger versions under
     `...\Microsoft.EventHub\Eventhub\stable\` and `...\preview\`.
   - The versions listed in the AAZ command model `_*.md` files under
     `<REPOS_ROOT>\aaz\Commands\eventhubs` (each `## Versions`
     section lists every version already modeled).
   - The default `tag:` in the Swagger `readme.md`.
2. **Base the new command model on the version exactly one release below the
   target** - i.e. the current latest version in the repo. Reuse that base
   version''s AAZ configuration (argument shapes, command groups, customizations)
   as the starting point, then re-target it to the new API version.
   - Example: to add commands for `2027-01-01`, and the latest present is
     `2026-07-01-preview` / `2026-01-01`, use the newest existing version as the
     base configuration and generate the new version from it.
3. If the requested target version''s Swagger is **not** present in
   `azure-rest-api-specs`, stop and tell the user - the spec must be merged (or
   available locally) before its commands can be generated. Do not fabricate a
   version.

> As of this repository snapshot the latest Event Hubs versions are
> `2026-01-01` (stable) and `2026-07-01-preview` (preview). Re-check before every
> run because they may have advanced.

## One-time environment setup

Assume the user may be unfamiliar with the process; show each step.

1. **Python** 3.10-3.14 must be installed. Verify: `python --version`.
2. **Create & activate a virtual environment** (reuse if one already exists):
   ```powershell
   python -m venv <REPOS_ROOT>\.venv-aaz
   <REPOS_ROOT>\.venv-aaz\Scripts\Activate.ps1
   ```
3. **Install aaz-dev**:
   ```powershell
   pip install aaz-dev
   ```
4. **Run azdev setup** (re-run every time you sync azure-cli from upstream):
   ```powershell
   azdev setup --cli <REPOS_ROOT>\azure-cli --repo <REPOS_ROOT>\azure-cli-extensions
   ```

## Repository / branch hygiene (before generating)

Never work on `main`/`dev` directly. For each repo that will receive changes:

- **azure-cli**: sync `dev` from upstream, then `git checkout -b feature-eventhub-<version>`.
- **azure-cli-extensions**: sync `main` from upstream, then `git checkout -b feature-eventhub-<version>` (only if commands go to an extension).
- **aaz**: sync `main` from upstream, then `git checkout -b feature-eventhub-<version>`.

If any of these repos is on `main`/`dev`, prompt the user to create a
`feature-` branch before continuing. Present git commands with a "Run" action
rather than asking the user to copy/paste, and do not run `git diff`.

## Generate the commands

Start the aaz-dev workbench server, pointing it at all four repos:

```powershell
aaz-dev run `
  -c <REPOS_ROOT>\azure-cli `
  -e <REPOS_ROOT>\azure-cli-extensions `
  -s <REPOS_ROOT>\azure-rest-api-specs\specification\eventhub `
  -a <REPOS_ROOT>\aaz
```

Then, in the aaz-dev web UI:

1. Open the **Microsoft.EventHub** module and select the Swagger for the
   resolved **base** version (see the Versioning rule above).
2. Generate/edit the command models for the **target** version, reusing the base
   configuration. Keep command groups consistent with the existing
   `eventhubs` tree (`cluster`, `eventhub`, `georecovery-alias`, `namespace`,
   and their sub-groups).
3. **Export command models** to the `aaz` repo and **generate CLI code** into the
   `azure-cli` core `eventhubs` module (or the extension, if that is the target).

## After generation - verify before use

1. `az login`
2. `az account set -s <test-subscription-id>`
3. If the commands are in an extension:
   `azdev extension add <extension-name>`
4. Smoke-test the generated commands (e.g. `az eventhubs namespace create ...`)
   against the test subscription.
5. Note: only AAZ commands generated by aaz-dev support the Azure CLI
   **shorthand syntax** for complex argument values.

## Submitting the work

Push each forked repo''s `feature-` branch, then open Pull Requests to upstream:

- **azure-cli** -> PR to the `dev` branch of `Azure/azure-cli`.
- **azure-cli-extensions** -> PR to the `main` branch of `Azure/azure-cli-extensions`.
- **aaz** -> PR to the `main` branch of `Azure/aaz`.

Exclude `.gitignore`, `.github/`, and `.vscode/` changes from these PRs.

## Guardrails

- Do not overwrite `readme.md`, `main.tsp`, or any Swagger file - the generator
  only *reads* the spec.
- Do not invent an API version; always confirm it exists in
  `azure-rest-api-specs` first.
- Always use `Azure` as the upstream repo owner unless the user says otherwise.