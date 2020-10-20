## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  payload-flattening-threshold: 2
  namespace: azure.bing.search.customsearch
  package-name: azure-bing-search-customsearch
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/bing/azure-bing-search-customsearch/azure/bing/search/customsearch
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/bing/azure-bing-search-customsearch
```
