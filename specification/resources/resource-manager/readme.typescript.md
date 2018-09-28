## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-resources: true
  - package-features: true
  - package-locks: true
  - package-policy: true
  - package-subscriptions: true
  - package-links: true
  - package-managedapplications: true
```

```yaml $(typescript) && $(package-features)
typescript:
  package-name: arm-features
  output-folder: $(typescript-sdks-folder)/packages/arm-features
```

```yaml $(typescript) && $(package-locks)
typescript:
  package-name: arm-locks
  output-folder: $(typescript-sdks-folder)/packages/arm-locks
```

```yaml $(typescript) && $(package-policy)
typescript:
  package-name: arm-policy
  output-folder: $(typescript-sdks-folder)/packages/arm-policy
```

```yaml $(typescript) && $(package-resources)
typescript:
  package-name: arm-resources
  output-folder: $(typescript-sdks-folder)/packages/arm-resources
```

```yaml $(typescript) && $(package-subscriptions)
typescript:
  package-name: arm-subscriptions
  output-folder: $(typescript-sdks-folder)/packages/arm-subscriptions
```

```yaml $(typescript) && $(package-links)
typescript:
  package-name: arm-links
  output-folder: $(typescript-sdks-folder)/packages/arm-links
```

```yaml $(typescript) && $(package-managedapplications)
typescript:
  package-name: arm-managedapplications
  output-folder: $(typescript-sdks-folder)/packages/arm-managedapplications
```
