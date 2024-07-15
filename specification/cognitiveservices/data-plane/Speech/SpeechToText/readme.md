# Cognitive Services SpeechToText SDKs

> see https://aka.ms/autorest

Configuration for generating SpeechToText SDK.

The current release for the SpeechToText is `release_3_2`.

``` yaml
tag: release_3_2
add-credentials: true
openapi-type: data-plane
```

# Releases

## Tag: release_2_0
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

## Tag: release_3_0
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

---

## Tag: release_3_1_preview_1
These settings apply only when `--tag=release_3_1_preview_1` is specified on the command line.

``` yaml $(tag) == 'release_3_1_preview_1'
input-file: preview/v3.1-preview.1/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
```

---

## Tag: release_3_1

These settings apply only when `--tag=release_3_1` is specified on the command line.

```yaml $(tag) == 'release_3_1'
input-file:
  - stable/v3.1/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
  - suppress: OperationIdNounVerb
    where: $..paths[($..operationId["Models_*"])]
    reason: There is a sub-route called /models/base/ that refers to the base models. Therefore, the correct operation ID seems to be "Models_GetBaseModel", for example.
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```

---

## Tag: release_3_2_preview_1

These settings apply only when `--tag=release_3_2_preview_1` is specified on the command line.

```yaml $(tag) == 'release_3_2_preview_1'
input-file:
  - preview/v3.2-preview.1/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
  - suppress: OperationIdNounVerb
    where: $..paths[($..operationId["Models_*"])]
    reason: There is a sub-route called /models/base/ that refers to the base models. Therefore, the correct operation ID seems to be "Models_GetBaseModel", for example.
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```

## Tag: release_3_2_preview_2

These settings apply only when `--tag=release_3_2_preview_2` is specified on the command line.

```yaml $(tag) == 'release_3_2_preview_2'
input-file:
  - preview/v3.2-preview.2/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
  - suppress: OperationIdNounVerb
    where: $..paths[($..operationId["Models_*"])]
    reason: There is a sub-route called /models/base/ that refers to the base models. Therefore, the correct operation ID seems to be "Models_GetBaseModel", for example.
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```

## Tag: release_3_2

These settings apply only when `--tag=release_3_2` is specified on the command line.

```yaml $(tag) == 'release_3_2'
input-file:
  - stable/v3.2/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
  - suppress: OperationIdNounVerb
    where: $..paths[($..operationId["Models_*"])]
    reason: There is a sub-route called /models/base/ that refers to the base models. Therefore, the correct operation ID seems to be "Models_GetBaseModel", for example.
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```

## Tag: release_2024_05_15_preview

These settings apply only when `--tag=release_2024_05_15_preview` is specified on the command line.

```yaml $(tag) == 'release_2024_05_15_preview'
input-file:
  - preview/2024-05-15-preview/speechtotext.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolve without updates to the API implementation
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    reason: Does not apply in those two places. The method is a DELETE which lazily deletes blobs, so it's Accepted, not NoContent. 
  - suppress: OperationIdNounVerb
    where: $..paths[($..operationId["Models_*"])]
    reason: There is a sub-route called /models/base/ that refers to the base models. Therefore, the correct operation ID seems to be "Models_GetBaseModel", for example.
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```
