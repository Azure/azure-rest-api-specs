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
  - package-links: true
  - package-managedapplications: true
```

```yaml $(typescript) && $(package-features)
typescript:
  package-name: "@azure/arm-features"
  output-folder: "$(typescript-sdks-folder)/sdk/features/arm-features"
```

```yaml $(typescript) && $(package-locks)
typescript:
  package-name: "@azure/arm-locks"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks"
```

```yaml $(typescript) && $(package-policy)
typescript:
  package-name: "@azure/arm-policy"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy"
```

```yaml $(typescript) && $(package-resources)
typescript:
  package-name: "@azure/arm-resources"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources"
```

```yaml $(typescript) && $(package-links)
typescript:
  package-name: "@azure/arm-links"
  output-folder: "$(typescript-sdks-folder)/sdk/links/arm-links"
```

```yaml $(typescript) && $(package-managedapplications)
typescript:
  package-name: "@azure/arm-managedapplications"
  output-folder: "$(typescript-sdks-folder)/sdk/managedapplications/arm-managedapplications"
```
