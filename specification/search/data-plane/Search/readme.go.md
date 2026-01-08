## Go
These settings apply only when `--go` is specified on the command line.
``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```
### Go multi-api
``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-05-searchindex
  - tag: package-2019-05-searchservice
```

### Tag:  package-2019-05-searchindex and go

 These settings apply only when `--tag=package-2019-05-searchindex --go` is specified on the command line.
 Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

 ``` yaml $(tag) == 'package-2019-05-searchindex' && $(go)
 namespace: searchindex
 output-folder: $(go-sdk-folder)/services/search/2019-05-01/$(namespace)
 ```


 ### Tag:  package-2019-05-searchservice and go

  These settings apply only when `--tag=package-2019-05-searchservice --go` is specified on the command line.
  Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

  ``` yaml $(tag) == 'package-2019-05-searchservice' && $(go)
  namespace: searchservice
  output-folder: $(go-sdk-folder)/services/search/2019-05-01/$(namespace)
  ```
