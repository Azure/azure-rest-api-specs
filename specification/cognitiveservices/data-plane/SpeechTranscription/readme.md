# Cognitive Services Speech Transcription SDKs

> see https://aka.ms/autorest

Configuration for generating Speech Transcription SDK.

The current release for the Speech Transcription is `release_2026_09_15_preview`.

``` yaml
tag: release_2026_09_15_preview
add-credentials: true
openapi-type: data-plane
```

# Releases

## Speech Transcription 2026-09-15-preview

These settings apply only when `--tag=release_2026_09_15_preview` is specified on the command line.

```yaml $(tag) == 'release_2026_09_15_preview'
input-file:
  - preview/2026-09-15-preview/Transcription.json
```

## Speech Transcription 2025-10-15

These settings apply only when `--tag=release_2025_10_15` is specified on the command line.

```yaml $(tag) == 'release_2025_10_15'
input-file:
  - stable/2025-10-15/Transcription.json
```
