## Python

- If `[[PackageName]]` is `azure-service-database`, then `[[NameSpace]]` shall be `azure.service.database`, `[[SubFolder]]`
shall be `azure/service/database`. See [Namespace](https://azure.github.io/azure-sdk/python_design.html#namespaces), [PackageName](https://azure.github.io/azure-sdk/python_design.html#azure-sdk-distribution-packages)
- `[[ServiceName]]` is better same with folder name in swagger repo.
- `[[PackageName]]` and `[[Namespace]]` is required to be reviewed by [SDK arch board](https://github.com/Azure/azure-sdk/issues).
- See [AutoRest/Python flags](https://github.com/Azure/autorest/blob/main/docs/generate/flags.md#python-flags)

``` yaml $(python)
package-name: [[PackageName]]
namespace: [[NameSpace]]
license-header: MICROSOFT_MIT_NO_VERSION
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
output-folder: $(python-sdks-folder)/[[ServiceName]]/[[PackageName]]]/[[SubFolder]]
```
