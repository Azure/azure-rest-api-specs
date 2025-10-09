## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
modelerfour:
  lenient-model-deduplication: true
rename-model: AllowedMethods:CorsRuleAllowedMethodsItem,AccountType:ActiveDirectoryPropertiesAccountType
property-include-always: EncryptionIdentity.encryptionUserAssignedIdentity
enable-sync-stack: false
```
