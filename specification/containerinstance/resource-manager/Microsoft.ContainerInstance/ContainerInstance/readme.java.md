## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
remove-inner: Container,Operation,CachedImages,Capabilities
rename-model: ContainerGroupPropertiesProperties:ContainerGroupProperties,UserAssignedIdentities:ContainerGroupIdentityUserAssignedIdentities
enable-sync-stack: false
```