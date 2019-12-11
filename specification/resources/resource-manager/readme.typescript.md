## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile)
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

```yaml $(typescript) && $(package-features) && !$(profile)
typescript:
  package-name: "@azure/arm-features"
  output-folder: "$(typescript-sdks-folder)/sdk/features/arm-features"
  clear-output-folder: true
```

```yaml $(typescript) && $(package-locks) && !$(profile)
typescript:
  package-name: "@azure/arm-locks"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks"
  clear-output-folder: true
```

```yaml $(typescript) && $(package-policy) && !$(profile)
typescript:
  package-name: "@azure/arm-policy"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy"
  clear-output-folder: true
```

```yaml $(typescript) && $(package-resources) && !$(profile)
typescript:
  package-name: "@azure/arm-resources"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources"
  clear-output-folder: true
```

```yaml $(typescript) && $(package-links) && !$(profile)
typescript:
  package-name: "@azure/arm-links"
  output-folder: "$(typescript-sdks-folder)/sdk/links/arm-links"
  clear-output-folder: true
```

```yaml $(typescript) && $(package-managedapplications) && !$(profile)
typescript:
  package-name: "@azure/arm-managedapplications"
  output-folder: "$(typescript-sdks-folder)/sdk/managedapplications/arm-managedapplications"
  clear-output-folder: true
```

```yaml $(tag)=='package-resources-2018-05' && $(profile)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-resources-profile-hybrid-2019-03-01"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources-profile-hybrid-2019-03-01"
  clear-output-folder: true
  batch:
    - tag: package-resources-2018-05
```

```yaml $(tag)=='package-policy-2016-12' && $(profile)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-policy-profile-hybrid-2019-03-01"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-policy-profile-hybrid-2019-03-01"
  clear-output-folder: true
  batch:
    - tag: package-policy-2016-12
```

```yaml $(tag)=='package-locks-2016-09' && $(profile)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-locks-profile-hybrid-2019-03-01"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-locks-profile-hybrid-2019-03-01"
  clear-output-folder: true
  batch:
    - tag: package-locks-2016-09
```

```yaml $(tag)=='package-subscriptions-2016-06' && $(profile)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-subscriptions-profile-hybrid-2019-03-01"
  output-folder: "$(typescript-sdks-folder)/sdk/subscription/arm-subscriptions-profile-hybrid-2019-03-01"
  clear-output-folder: true
  batch:
    - tag: package-subscriptions-2016-06
```