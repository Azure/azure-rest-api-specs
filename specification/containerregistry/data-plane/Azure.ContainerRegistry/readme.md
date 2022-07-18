# ContainerRegistry

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerRegistry.

---

## Configuration

### Basic Information

These are the global settings for the ContainerRegistry API.

``` yaml
# common
title: ContainerRegistryClient
openapi-type: data-plane
tag: package-2019-08
```
### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file: preview/2019-08-15-preview/containerregistry.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file: stable/2021-07-01/containerregistry.json
```
---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp: true
model-namespace: false
directive:
  - from: containerregistry.json
    where: $.definitions.DeletedRepository
    transform: >
      $["x-accessibility"] = "internal"

  - from: containerregistry.json
    where: $.definitions.ManifestAttributes_manifest_references
    transform: >
      $["x-accessibility"] = "internal"
```

## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
java: true
```

## TypeScript

These settings apply only when `--typescript` is specified on the command line.

``` yaml $(typescript)
typescript: true
v3: true
package-name: "@azure/container-registry"
title: GeneratedClient
description: Container Registry Client
generate-metadata: false
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: false
override-client-name: GeneratedClient
disable-async-iterators: true
hide-clients: true
use-extension:
  "@autorest/typescript": "6.0.0-beta.4"
output-folder: ../
source-code-folder-path: ./src/generated
```

## Python
These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python: true
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: containerregistry.json
    where: $.definitions.AccessToken.properties.access_token
    reason: Property name is used in compliance with Docker's own specs for compatibility purposes. Specifics https://docs.docker.com/registry/spec/auth/oauth/
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: containerregistry.json
    where: $.definitions.RefreshToken.properties.refresh_token
    reason: Property name is used in compliance with Docker's own specs for compatibility purposes. Specifics https://docs.docker.com/registry/spec/auth/oauth/
  - suppress: LROStatusCodesReturnTypeSchema
    reason: No content is returned by put Manifest in compliance with Docker's own specs for compatibility purposes. Specifics https://docs.docker.com/registry/spec/api/#put-manifest
    from: containerregistry.json
    where: $.paths["/v2/{name}/manifests/{reference}"].put.responses["201"]
  - suppress: LROStatusCodesReturnTypeSchema
    reason: No content is returned by put End Upload in compliance with Docker's own specs for compatibility purposes. Specifics https://docs.docker.com/v17.12/registry/spec/api/
    from: containerregistry.json
    where: $.paths["/{nextBlobUuidLink}"].put.responses["201"]
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These default values are specified by the Open Container Initiative. Used for cross compatibility. Specifics https://github.com/opencontainers/image-spec/blob/master/annotations.md#rules
    from: containerregistry.json
    where:
      - $.definitions.Platform.properties["os.version"]
      - $.definitions.Platform.properties["os.features"]
      - $.definitions.Annotations.properties["org.opencontainers.image.created"]
      - $.definitions.Annotations.properties["org.opencontainers.image.authors"]
      - $.definitions.Annotations.properties["org.opencontainers.image.url"]
      - $.definitions.Annotations.properties["org.opencontainers.image.documentation"]
      - $.definitions.Annotations.properties["org.opencontainers.image.source"]
      - $.definitions.Annotations.properties["org.opencontainers.image.version"]
      - $.definitions.Annotations.properties["org.opencontainers.image.revision"]
      - $.definitions.Annotations.properties["org.opencontainers.image.vendor"]
      - $.definitions.Annotations.properties["org.opencontainers.image.licenses"]
      - $.definitions.Annotations.properties["org.opencontainers.image.ref.name"]
      - $.definitions.Annotations.properties["org.opencontainers.image.title"]
      - $.definitions.Annotations.properties["org.opencontainers.image.description"]
  - suppress: RequiredReadOnlyProperties
    reason: These are used in output types to mark readonly properties as non-optional. It should be allowed https://github.com/Azure/azure-openapi-validator/issues/243
    from: containerregistry.json
    where:
      - $.definitions.RepositoryAttributes.properties["registry"]
      - $.definitions.RepositoryAttributes.properties["imageName"]
      - $.definitions.RepositoryAttributes.properties["createdTime"]
      - $.definitions.RepositoryAttributes.properties["lastUpdateTime"]
      - $.definitions.RepositoryAttributes.properties["manifestCount"]
      - $.definitions.RepositoryAttributes.properties["tagCount"]
      - $.definitions.TagAttributes.properties["registry"]
      - $.definitions.TagAttributes.properties["imageName"]
      - $.definitions.TagAttributes.properties["tag"]
      - $.definitions.TagAttributesBase.properties["name"]
      - $.definitions.TagAttributesBase.properties["digest"]
      - $.definitions.TagAttributesBase.properties["createdTime"]
      - $.definitions.TagAttributesBase.properties["lastUpdateTime"]
      - $.definitions.ManifestAttributes_manifest_references.properties["digest"]
      - $.definitions.ManifestAttributesBase.properties["digest"]
      - $.definitions.ManifestAttributesBase.properties["createdTime"]
      - $.definitions.ManifestAttributesBase.properties["lastUpdateTime"]
      - $.definitions.ManifestAttributes.properties["manifest"]
```
