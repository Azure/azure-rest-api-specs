## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-containerinstance-2019-12-01
  - tag: schema-containerinstance-2018-10-01
  - tag: schema-containerinstance-2018-09-01
  - tag: schema-containerinstance-2018-06-01
  - tag: schema-containerinstance-2018-04-01
  - tag: schema-containerinstance-2018-02-01-preview
  - tag: schema-containerinstance-2017-12-01-preview
  - tag: schema-containerinstance-2017-10-01-preview
  - tag: schema-containerinstance-2017-08-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-containerinstance-2019-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/stable/2019-12-01/containerInstance.json

```

### Tag: schema-containerinstance-2018-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/stable/2018-10-01/containerInstance.json

```

### Tag: schema-containerinstance-2018-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2018-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/stable/2018-09-01/containerInstance.json

```

### Tag: schema-containerinstance-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/stable/2018-06-01/containerInstance.json

```

### Tag: schema-containerinstance-2018-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2018-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/stable/2018-04-01/containerInstance.json

```

### Tag: schema-containerinstance-2018-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2018-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/preview/2018-02-01-preview/containerInstance.json

```

### Tag: schema-containerinstance-2017-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2017-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/preview/2017-12-01-preview/containerInstance.json

```

### Tag: schema-containerinstance-2017-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2017-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/preview/2017-10-01-preview/containerInstance.json

```

### Tag: schema-containerinstance-2017-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerinstance-2017-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerInstance/preview/2017-08-01-preview/containerInstance.json

```
