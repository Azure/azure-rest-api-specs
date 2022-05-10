## Python

- If `[[PackageName]]` is `azure-service-database`, then `[[NameSpace]]` shall be `azure.service.database`, `[[SubFolder]]`
shall be `azure/service/database`.
- If `[[PackageName]]` is `azure-service`, then `[[NameSpace]]` shall be `azure.service`, `[[SubFolder]]`
shall be `azure/service`.
- `[[ServiceName]]` is better same with folder name in swagger repo.

``` yaml $(python)
package-name: [[PackageName]]
namespace: [[NameSpace]]
license-header: MICROSOFT_MIT_NO_VERSION
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/[[ServiceName]]/[[PackageName]]]/[[SubFolder]]
```
