# DevTestLab

> see <https://aka.ms/autorest>

This is the AutoRest configuration file for DevTestLab.

---

## Getting Started

To build the SDK for DevTestLab, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

### Basic Information

These are the global settings for the DevTestLab API.

``` yaml
openapi-type: arm
azure-arm: true
version: "latest"
license-header: MICROSOFT_MIT_NO_VERSION
tag: package-2025-06-preview
```

## Tag: package-2025-06-preview

``` yaml $(tag) == 'package-2025-06-preview'
input-file:
- ./DTL.json
```

## C\#

These settings apply only when --csharp is specified on the command line.

``` yaml $(csharp)
csharp:
  clear-output-folder: true
  output-folder: ../../../DevTestLabs/NET/_generated
  namespace: Microsoft.Azure.Management.DevTestLabs
```

## Typescript

These settings apply only when --typescript is specified on the command line.

``` yaml $(typescript)
typescript:
  clear-output-folder: true
  generate-metadata: true
  package-name: dtl-ts
  output-folder: ..\..\..\DevTestLabs\NET\_generated\lib
  package-version: '42.42.4242'
```