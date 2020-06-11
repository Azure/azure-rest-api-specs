
## trenton

These settings apply only when `--trenton` is specified on the command line.

<!-- ``` yaml $(trenton)
trenton:
    cli-name: features
    package-name: features
clear-output-folder: true
output-folder: $(trenton-output-folder)/features
``` -->
``` yaml $(trenton)
batch:
  - package-features: true
  - package-policy: true
  - package-managedapplications: true
```

```yaml $(trenton) && $(package-policy)
trenton:
  cli-name: policy
  package-name: policy
output-folder: $(trenton-output-folder)/policy
clear-output-folder: true
```

```yaml $(trenton) && $(package-features)
trenton:
  cli-name: features
  package-name: features
output-folder: $(trenton-output-folder)/features
clear-output-folder: true
```

```yaml $(trenton) && $(package-managedapplications)
trenton:
  cli-name: managedApplications
  package-name: managedapplications
output-folder: $(trenton-output-folder)/managedapplications
clear-output-folder: true

overrides:
  - where:
      resource: "Applications"
      property: "/parameters"
    set:
      - GoVariableName: "appParameters"
      - Gen: "newgen"
```