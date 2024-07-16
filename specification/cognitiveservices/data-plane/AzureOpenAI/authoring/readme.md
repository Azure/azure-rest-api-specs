# Cognitive Services AzureOpenAI SDKs

> see https://aka.ms/autorest

Configuration for generating AzureOpenAI SDK.

The current release for the AzureOpenAI is `release_2024_02_15_preview`.

``` yaml
tag: release_2022_12_01
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

## AzureOpenAI 2022-12-01
These settings apply only when `--tag=release_2022_12_01` is specified on the command line.

``` yaml $(tag) == 'release_2022_12_01'
input-file: stable/2022-12-01/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-03-15-preview
These settings apply only when `--tag=release_2023_03_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_03_15_preview'
input-file: preview/2023-03-15-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-06-01-preview
These settings apply only when `--tag=release_2023_06_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_06_01_preview'
input-file: preview/2023-06-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-05-15
These settings apply only when `--tag=release_2023_05_15` is specified on the command line.

``` yaml $(tag) == 'release_2023_05_15'
input-file: stable/2023-05-15/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-07-01-preview
These settings apply only when `--tag=release_2023_07_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_07_01_preview'
input-file: preview/2023-07-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-08-01-preview
These settings apply only when `--tag=release_2023_08_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_08_01_preview'
input-file: preview/2023-08-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-09-01-preview
These settings apply only when `--tag=release_2023_09_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_09_01_preview'
input-file: preview/2023-09-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-10-01-preview
These settings apply only when `--tag=release_2023_10_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_10_01_preview'
input-file: preview/2023-10-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2023-12-01-preview
These settings apply only when `--tag=release_2023_12_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2023_12_01_preview'
input-file: preview/2023-12-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```

## AzureOpenAI 2024-02-15-preview
These settings apply only when `--tag=release_2024_02_15_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024_02_15_preview'
input-file: preview/2024-02-15-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```


## AzureOpenAI 2024-03-01-preview
These settings apply only when `--tag=release_2024_03_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024_03_01_preview'
input-file: preview/2024-03-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```


## AzureOpenAI 2024-04-01-preview
These settings apply only when `--tag=release_2024_04_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024_04_01_preview'
input-file: preview/2024-04-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```


## AzureOpenAI 2024-05-01-preview
These settings apply only when `--tag=release_2024_05_01_preview` is specified on the command line.

``` yaml $(tag) == 'release_2024_05_01_preview'
input-file: preview/2024-05-01-preview/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```


## AzureOpenAI 2024-06-01
These settings apply only when `--tag=release_2024_06_01` is specified on the command line.

``` yaml $(tag) == 'release_2024_06_01'
input-file: stable/2024-06-01/azureopenai.json
```

AutoRest-Linter Suppressions

``` yaml
# Ignore autorest-linter issues that cannot be resolved without breaking compatibility to existing openai api
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing external API uses property names like n_epochs, created_at, not following naming/casing guidelines from azure. 
  - suppress: ValidFormats
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
  - suppress: IntegerTypeMustHaveFormat
    reason: API stewardship board recommend to use format "unixtime" which is not supported by linter at the moment. 
```
