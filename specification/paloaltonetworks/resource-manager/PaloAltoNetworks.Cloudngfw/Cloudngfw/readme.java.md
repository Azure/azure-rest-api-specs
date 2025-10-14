## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
service-name: PaloAlto Networks Ngfw
directive:
  - from: PaloAltoNetworks.Cloudngfw.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listAppIds"].post
    transform: |
      delete $["x-ms-pageable"]
  - from: PaloAltoNetworks.Cloudngfw.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listCountries"].post
    transform: |
      delete $["x-ms-pageable"]
  - from: PaloAltoNetworks.Cloudngfw.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/PaloAltoNetworks.Cloudngfw/localRulestacks/{localRulestackName}/listPredefinedUrlCategories"].post
    transform: |
      delete $["x-ms-pageable"]
```
