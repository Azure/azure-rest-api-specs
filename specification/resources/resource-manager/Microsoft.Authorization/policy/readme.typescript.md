## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile-content)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-policy: true
```

```yaml $(typescript) && $(package-policy) && !$(profile-content)
typescript:
  package-name: "@azure/arm-policy"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy"

modelerfour: 
  treat-type-object-as-anything: true 
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

```yaml $(tag)=='package-policy-2016-12' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-policy-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/policy/arm-policy-profile-2020-09-01-hybrid"
  batch:
    - tag: package-policy-2016-12
```
