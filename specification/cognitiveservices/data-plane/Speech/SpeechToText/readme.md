# Cognitive Services SpeechToText SDKs

> see https://aka.ms/autorest

Configuration for generating SpeechToText SDK.

The current release for the SpeechToText is `release_3_0`.

``` yaml
tag: release_3_0
add-credentials: true
openapi-type: data-plane
```

# Releases

## SpeechToText 2.0
These settings apply only when `--tag=release_2_0` is specified on the command line.

``` yaml $(tag) == 'release_2_0'
input-file: stable/v2.0/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Changing casing will break existing clients/consumers
  - suppress: GuidUsage
    reason: Changing casing will break existing clients/consumers
```

---

## SpeechToText 3.0
These settings apply only when `--tag=release_3_0` is specified on the command line.

``` yaml $(tag) == 'release_3_0'
input-file: stable/v3.0/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
```