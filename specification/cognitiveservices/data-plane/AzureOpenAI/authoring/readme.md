# Cognitive Services AzureOpenAI SDKs

> see https://aka.ms/autorest

Configuration for generating AzureOpenAI SDK.

The current release for the AzureOpenAI is `release_2022_06_01_preview`.

``` yaml
tag: release_2022_06_01_preview
add-credentials: true
openapi-type: data-plane
```

# Releases

## AzureOpenAI 2022-03-01-preview
These settings apply only when `--tag=release_2022_03_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_03_01_preview'
input-file: preview/2022-03-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
```

## AzureOpenAI 2022-06-01-preview
These settings apply only when `--tag=release_2022_06_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2022_06_01_preview'
input-file: preview/2022-06-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
```
