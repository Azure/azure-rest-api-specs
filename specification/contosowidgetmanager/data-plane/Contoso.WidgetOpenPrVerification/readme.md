# Widget open-PR verification

Test-only copy of the Contoso Widget sample for
[issue #17024](https://github.com/Azure/azure-sdk-tools/issues/17024).
Keep the spec PR and generated SDK PRs unmerged. Do not publish these packages.

The generated model documentation includes `OPEN-PR-VERIFICATION-17024`.
Namespace and all five SDK package identities are distinct from existing samples.

## Basic Information

```yaml
tag: package-2022-12-01
openapi-type: data-plane
```

## Tag package-2022-12-01

```yaml $(tag) == 'package-2022-12-01'
input-file:
  - stable/2022-12-01/widgets.json
```

## Tag package-2022-11-01-preview

```yaml $(tag) == 'package-2022-11-01-preview'
input-file:
  - preview/2022-11-01-preview/widgets.json
```
