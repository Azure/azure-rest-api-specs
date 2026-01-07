# Microsoft.Pki

Contains Swagger files for the Microsoft.Pki resource provider.

> see https://aka.ms/autorest

Install autorest using the official guidance.

Run the following command in this directory with `autorest`:

```sh
autorest readme.md --csharp --namespace=<your-namespace>
```

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2025-01-01-preview
azure-arm: true
sample-gen:
    output-folder: samples
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
clear-output-folder: true
client-side-validation: false
```

### Tag: package-2025-01-01-preview

```yaml $(tag) == 'package-2025-01-01-preview'
input-file:
  - Microsoft.Pki/preview/2025-01-01-preview/certificateAuthorities.json
  - Microsoft.Pki/preview/2025-01-01-preview/definitions.json
  - Microsoft.Pki/preview/2025-01-01-preview/enrollmentPolicies.json
  - Microsoft.Pki/preview/2025-01-01-preview/pkis.json
```

### Tag: package-2024-01-01-preview

```yaml $(tag) == 'package-2024-01-01-preview'
input-file:
  - Microsoft.Pki/preview/2024-01-01-preview/certificateAuthorities.json
  - Microsoft.Pki/preview/2024-01-01-preview/definitions.json
  - Microsoft.Pki/preview/2024-01-01-preview/enrollmentPolicies.json
  - Microsoft.Pki/preview/2024-01-01-preview/pkis.json
```

### Tag: package-2022-09-01-preview

```yaml $(tag) == 'package-2022-09-01-preview'
input-file:
  - Microsoft.Pki/preview/2022-09-01-preview/certificateAuthorities.json
  - Microsoft.Pki/preview/2022-09-01-preview/definitions.json
  - Microsoft.Pki/preview/2022-09-01-preview/enrollmentPolicies.json
  - Microsoft.Pki/preview/2022-09-01-preview/pkis.json
```

### Tag: package-2021-03-01-preview

```yaml $(tag) == 'package-2021-03-01-preview'
input-file:
  - Microsoft.Pki/preview/2021-03-01-preview/certificateAuthorities.json
  - Microsoft.Pki/preview/2021-03-01-preview/definitions.json
  - Microsoft.Pki/preview/2021-03-01-preview/enrollmentPolicies.json
  - Microsoft.Pki/preview/2021-03-01-preview/pkis.json
```
