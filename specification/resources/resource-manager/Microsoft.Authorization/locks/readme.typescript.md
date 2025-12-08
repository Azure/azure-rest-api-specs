## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript) && !$(profile-content)
typescript:
  azure-arm: true
  batch: true
  generate-metadata: true
batch:
  - package-locks: true
```

```yaml $(typescript) && $(package-locks) && !$(profile-content)
typescript:
  package-name: "@azure/arm-locks"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks"
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

```yaml $(tag)=='package-locks-2016-09' && $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  azure-arm: true
  generate-metadata: true
  package-name: "@azure/arm-locks-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/locks/arm-locks-profile-2020-09-01-hybrid"
  batch:
    - tag: package-locks-2016-09
```
