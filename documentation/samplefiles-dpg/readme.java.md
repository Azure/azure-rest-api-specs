## Java

- If `[[PackageName]]` is `azure-service-database`, then `[[Namespace]]` shall be `azure.service.database`, see [Namespace](https://azure.github.io/azure-sdk/java_introduction.html#namespaces).
- `[[ServiceName]]`, see [Service Client](https://azure.github.io/azure-sdk/java_introduction.html#service-client).

`[[PackageName]]` and `[[Namespace]]` is required to be reviewed by [SDK arch board](https://github.com/Azure/azure-sdk/issues).

``` yaml $(java)
output-folder: $(java-sdks-folder)/sdk/[[ServiceFolder]]/[[PackageName]]]
data-plane: true
namespace: [[Namespace]]

service-name: [[ServiceName]]

generate-samples: true
generate-tests: true
```
