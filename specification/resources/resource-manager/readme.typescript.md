## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  batch: true
  package-name: arm-resource
  generate-metadata: false
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

```yaml $(typescript) && $(package-features)
typescript:
  source-code-folder-path: lib/feature
```

```yaml $(typescript) && $(package-locks)
typescript:
  source-code-folder-path: lib/lock
```

```yaml $(typescript) && $(package-policy)
typescript:
  source-code-folder-path: lib/policy
```

```yaml $(typescript) && $(package-resources)
typescript:
  source-code-folder-path: lib/resource
```

```yaml $(typescript) && $(package-subscriptions)
typescript:
  source-code-folder-path: lib/subscription
```

```yaml $(typescript) && $(package-links)
typescript:
  source-code-folder-path: lib/link
```

```yaml $(typescript) && $(package-managedapplications)
typescript:
  source-code-folder-path: lib/managedapplications
```
