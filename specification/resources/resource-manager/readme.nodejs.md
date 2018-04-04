## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

```yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-resource
  package-version: 3.1.1-preview
  generate-license-txt: false
  generate-package-json: false
  generate-readme-md: false
  output-folder: $(node-sdks-folder)/lib/services/resourceManagement
  batch:
  - tag: package-features
  - tag: package-locks
  - tag: package-policy
  - tag: package-resources
  - tag: package-subscriptions
  - tag: package-links
  - tag: package-management
```

```yaml $(nodejs) && $(tag) == 'package-features'
nodejs:
  source-code-folder-path: lib/feature
```

```yaml $(nodejs) && $(tag) == 'package-locks'
nodejs:
  source-code-folder-path: lib/lock
```

```yaml $(nodejs) && $(tag) == 'package-policy'
nodejs:
  source-code-folder-path: lib/policy
```

```yaml $(nodejs) && $(tag) == 'package-resources'
nodejs:
  source-code-folder-path: lib/resource
```

```yaml $(nodejs) && $(tag) == 'package-subscriptions'
nodejs:
  source-code-folder-path: lib/subscription
```

```yaml $(nodejs) && $(tag) == 'package-links'
nodejs:
  source-code-folder-path: lib/link
```

```yaml $(nodejs) && $(tag) == 'package-management'
nodejs:
  source-code-folder-path: lib/management
  override-client-name: ManagementGroupsClient
```