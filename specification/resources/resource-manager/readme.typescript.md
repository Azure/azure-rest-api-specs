## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  batch: true
  package-name: arm-resource
  generate-license-txt: true
  generate-package-json: false
  generate-readme-md: false
  output-folder: $(typescript-sdks-folder)/packages/arm-resource
batch:
  - package-features: true
  - package-locks: true
  - package-policy: true
  - package-resources: true
  - package-subscriptions: true
  - package-links: true
  - package-managedapplications: true
```

```yaml $(nodejs) && $(package-features)
nodejs:
  source-code-folder-path: lib/feature
```

```yaml $(nodejs) && $(package-locks)
nodejs:
  source-code-folder-path: lib/lock
```

```yaml $(nodejs) && $(package-policy)
nodejs:
  source-code-folder-path: lib/policy
```

```yaml $(nodejs) && $(package-resources)
nodejs:
  source-code-folder-path: lib/resource
```

```yaml $(nodejs) && $(package-subscriptions)
nodejs:
  source-code-folder-path: lib/subscription
```

```yaml $(nodejs) && $(package-links)
nodejs:
  source-code-folder-path: lib/link
```

```yaml $(nodejs) && $(package-management)
nodejs:
  source-code-folder-path: lib/management
  override-client-name: ManagementGroupsClient
```