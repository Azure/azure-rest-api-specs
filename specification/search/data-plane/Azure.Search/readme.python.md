## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
package-name: azure-search-documents
clear-output-folder: true
no-namespace-folders: true
```

### Tag: package-2020-06-searchservice-preview

These settings apply only when `--tag=package-2020-06-searchservice-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-searchservice-preview'
namespace: azure.search.documents.indexes
output-folder: $(python-sdks-folder)/search/azure-search-documents/azure/search/documents/indexes/_generated
```

### Tag: package-2020-06-searchindex-preview

These settings apply only when `--tag=package-2020-06-searchindex-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-searchindex-preview'
namespace: azure.search.documents
output-folder: $(python-sdks-folder)/search/azure-search-documents/azure/search/documents/_generated
```

### Tag: package-2021-04-searchservice-preview

These settings apply only when `--tag=package-2021-04-searchservice-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-searchservice-preview'
namespace: azure.search.documents.indexes
output-folder: $(python-sdks-folder)/search/azure-search-documents/azure/search/documents/indexes/_generated
```

### Tag: package-2021-04-searchindex-preview

These settings apply only when `--tag=package-2021-04-searchindex-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-searchindex-preview'
namespace: azure.search.documents
output-folder: $(python-sdks-folder)/search/azure-search-documents/azure/search/documents/_generated
```