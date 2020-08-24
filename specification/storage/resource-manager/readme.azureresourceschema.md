## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-storage-2019-06-01
  - tag: schema-storage-2019-04-01
  - tag: schema-storage-2018-11-01
  - tag: schema-storage-2018-07-01
  - tag: schema-storage-2018-03-01-preview
  - tag: schema-storage-2018-02-01
  - tag: schema-storage-2017-10-01
  - tag: schema-storage-2017-06-01
  - tag: schema-storage-2016-12-01
  - tag: schema-storage-2016-05-01
  - tag: schema-storage-2016-01-01
  - tag: schema-storage-2015-06-15
  - tag: schema-storage-2015-05-01-preview
require: ../../../profiles/readme.md
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-storage-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2019-06-01/storage.json
  - Microsoft.Storage/stable/2019-06-01/blob.json
  - Microsoft.Storage/stable/2019-06-01/file.json
  - Microsoft.Storage/stable/2019-06-01/queue.json
  - Microsoft.Storage/stable/2019-06-01/table.json

```

### Tag: schema-storage-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2019-04-01/storage.json
  - Microsoft.Storage/stable/2019-04-01/blob.json
  - Microsoft.Storage/stable/2019-04-01/file.json

```

### Tag: schema-storage-2018-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2018-11-01/storage.json
  - Microsoft.Storage/stable/2018-11-01/blob.json

```

### Tag: schema-storage-2018-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2018-07-01/storage.json
  - Microsoft.Storage/stable/2018-07-01/blob.json

```

### Tag: schema-storage-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/preview/2018-03-01-preview/managementpolicy.json
  - Microsoft.Storage/preview/2018-03-01-preview/storage.json
  - Microsoft.Storage/preview/2018-03-01-preview/blob.json

```

### Tag: schema-storage-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2018-02-01/storage.json
  - Microsoft.Storage/stable/2018-02-01/blob.json

```

### Tag: schema-storage-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2017-10-01/storage.json

```

### Tag: schema-storage-2017-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2017-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2017-06-01/storage.json

```

### Tag: schema-storage-2016-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2016-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2016-12-01/storage.json

```

### Tag: schema-storage-2016-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2016-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2016-05-01/storage.json

```

### Tag: schema-storage-2016-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2016-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2016-01-01/storage.json

```

### Tag: schema-storage-2015-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2015-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2015-06-15/storage.json

```

### Tag: schema-storage-2015-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-storage-2015-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/preview/2015-05-01-preview/storage.json
```

<<<<<<< HEAD
```
=======
batch:
  - tag: package-2020-08-preview
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2018-11
  - tag: package-2018-07
  - tag: package-2018-07-only
  - tag: package-2018-03
  - tag: package-2018-02
  - tag: package-2017-10
  - tag: package-2017-06
  - tag: package-2016-12
  - tag: package-2016-05
  - tag: package-2016-01
  - tag: package-2015-06
  - tag: package-2015-05-preview
```

### Tag: package-2020-08-preview and azureresourceschema

These settings apply only when `--tag=package-2020-08-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-06 and azureresourceschema

These settings apply only when `--tag=package-2019-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-04 and azureresourceschema

These settings apply only when `--tag=package-2019-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-11 and azureresourceschema

These settings apply only when `--tag=package-2018-11 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-11' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-07 and azureresourceschema

These settings apply only when `--tag=package-2018-07 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-07-only and azureresourceschema

These settings apply only when `--tag=package-2018-07-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-07-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-03 and azureresourceschema

These settings apply only when `--tag=package-2018-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-02 and azureresourceschema

These settings apply only when `--tag=package-2018-02 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-10 and azureresourceschema

These settings apply only when `--tag=package-2017-10 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-06 and azureresourceschema

These settings apply only when `--tag=package-2017-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-12 and azureresourceschema

These settings apply only when `--tag=package-2016-12 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-05 and azureresourceschema

These settings apply only when `--tag=package-2016-05 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-05' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-01 and azureresourceschema

These settings apply only when `--tag=package-2016-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-06 and azureresourceschema

These settings apply only when `--tag=package-2015-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-05-preview and azureresourceschema

These settings apply only when `--tag=package-2015-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```
>>>>>>> [SRP] Introduce 2020-08-01-preview version.
