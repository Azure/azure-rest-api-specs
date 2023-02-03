## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile-content)
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
  - package-templatespecs: true
  - package-subscriptions: true
  - package-changes: true
```

```yaml $(typescript) && $(package-features) && !$(profile-content)
typescript:
  package-name: "@azure/arm-features"
  output-folder: "$(typescript-sdks-folder)/sdk/features/arm-features"
```

```yaml $(typescript) && $(package-locks) && !$(profile-content)
typescript:
  package-name: "@azure/arm-locks"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks"
```

```yaml $(typescript) && $(package-policy) && !$(profile-content)
typescript:
  package-name: "@azure/arm-policy"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy"
```

```yaml $(typescript) && $(package-resources) && !$(profile-content)
typescript:
  package-name: "@azure/arm-resources"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources"
```

```yaml $(typescript) && $(package-links) && !$(profile-content)
typescript:
  package-name: "@azure/arm-links"
  output-folder: "$(typescript-sdks-folder)/sdk/links/arm-links"
```

```yaml $(typescript) && $(package-managedapplications) && !$(profile-content)
typescript:
  package-name: "@azure/arm-managedapplications"
  output-folder: "$(typescript-sdks-folder)/sdk/managedapplications/arm-managedapplications"
```

```yaml $(typescript) && $(package-templatespecs) && !$(profile-content)
typescript:
  package-name: "@azure/arm-templatespecs"
  output-folder: "$(typescript-sdks-folder)/sdk/templatespecs/arm-templatespecs"
```

```yaml $(typescript) && $(package-subscriptions) && !$(profile-content)
typescript:
  package-name: "@azure/arm-resources-subscriptions"
  output-folder: "$(typescript-sdks-folder)/sdk/resources-subscriptions/arm-resources-subscriptions"
```

```yaml $(typescript) && $(package-changes) && !$(profile-content)
typescript:
  package-name: "@azure/arm-changes"
  output-folder: "$(typescript-sdks-folder)/sdk/changes/arm-changes"
```

```yaml $(tag)=='package-resources-2018-05' && $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-resources-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources-profile-2019-03-01-hybrid"
  batch:
    - tag: package-resources-2018-05
```

```yaml $(tag)=='package-policy-2016-12' && $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-policy-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy-profile-2019-03-01-hybrid"
  batch:
    - tag: package-policy-2016-12
```

```yaml $(tag)=='package-locks-2016-09' && $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-locks-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks-profile-2019-03-01-hybrid"
  batch:
    - tag: package-locks-2016-09
```

```yaml $(tag)=='package-subscriptions-2016-06' && $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-subscriptions-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/subscription/arm-subscriptions-profile-2019-03-01-hybrid"
  batch:
    - tag: package-subscriptions-2016-06
```

```yaml $(tag)=='package-resources-2019-10' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-resources-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/resources/arm-resources-profile-2020-09-01-hybrid"
  batch:
    - tag: package-resources-2019-10
```

```yaml $(tag)=='package-policy-2016-12' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-policy-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy-profile-2020-09-01-hybrid"
  batch:
    - tag: package-policy-2016-12
```

```yaml $(tag)=='package-locks-2016-09' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-locks-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks-profile-2020-09-01-hybrid"
  batch:
    - tag: package-locks-2016-09
```

```yaml $(tag)=='package-subscriptions-2016-06' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-subscriptions-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/subscription/arm-subscriptions-profile-2020-09-01-hybrid"
  batch:
    - tag: package-subscriptions-2016-06
```
