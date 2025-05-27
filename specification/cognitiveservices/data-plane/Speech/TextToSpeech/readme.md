# Cognitive Services TextToSpeech SDKs

> see https://aka.ms/autorest

Configuration for generating TextToSpeech SDK.

The current release for the TextToSpeech is `release_2024_02_01_preview`.

``` yaml
tag: release_2024_02_01_preview
add-credentials: true
openapi-type: data-plane
```

# Releases

## TextToSpeech 2023-12-01-preview

These settings apply only when `--tag=release_2023_12_01_preview` is specified on the command line.

```yaml $(tag) == 'release_2023_12_01_preview'
input-file:
  - preview/2023-12-01-preview/texttospeech.json
```

## TextToSpeech 2024-02-01-preview

These settings apply only when `--tag=release_2024_02_01_preview` is specified on the command line.

```yaml $(tag) == 'release_2024_02_01_preview'
input-file:
  - preview/2024-02-01-preview/texttospeech.json
```