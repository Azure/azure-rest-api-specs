## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
tag: package-2024-03-01

resource-collection-associations:
- resource: SharedPrivateLinkResource
  collection: WebPubSubSharedPrivateLinkResources
```
