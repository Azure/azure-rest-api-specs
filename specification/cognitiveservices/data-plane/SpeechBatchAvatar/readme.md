# Cognitive Services BatchAvatar SDKs

> see https://aka.ms/autorest

Configuration for generating BatchAvatar SDK.

The current release for the BatchAvatar is `release_2024_08_01`.

``` yaml
tag: release_2024_08_01
add-credentials: true
openapi-type: data-plane
```

# Releases

## BatchAvatar 2024-04-15-preview

These settings apply only when `--tag=release_2024_04_15_preview` is specified on the command line.

```yaml $(tag) == 'release_2024_04_15_preview'
input-file:
  - preview/2024-04-15-preview/batchavatar.json
```

## BatchAvatar 2024-08-01

These settings apply only when `--tag=release_2024_08_01` is specified on the command line.

```yaml $(tag) == 'release_2024_08_01'
input-file:
  - stable/2024-08-01/batchavatar.json
```