## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile-content)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-subscriptions: true
```

```yaml $(typescript) && $(package-subscriptions) && !$(profile-content)
typescript:
  package-name: "@azure/arm-resources-subscriptions"
  output-folder: "$(typescript-sdks-folder)/sdk/resources-subscriptions/arm-resources-subscriptions"
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

```yaml $(tag)=='package-subscriptions-2016-06' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-subscriptions-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/subscription/arm-subscriptions-profile-2020-09-01-hybrid"
  batch:
    - tag: package-subscriptions-2016-06
```
