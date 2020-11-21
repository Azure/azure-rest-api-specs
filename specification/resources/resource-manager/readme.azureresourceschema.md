## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-solutions-2020-08-21-preview
  - tag: schema-solutions-2019-07-01
  - tag: schema-solutions-2018-06-01
  - tag: schema-solutions-2017-09-01
  - tag: schema-solutions-2016-09-01-preview
  - tag: schema-resources-2020-10-01
  - tag: schema-resources-2020-06-01
  - tag: schema-resources-2020-01-01
  - tag: schema-resources-2019-11-01
  - tag: schema-resources-2019-10-01-preview
  - tag: schema-resources-2019-10-01
  - tag: schema-resources-2019-08-01
  - tag: schema-resources-2019-07-01
  - tag: schema-resources-2019-06-01-preview
  - tag: schema-resources-2019-06-01
  - tag: schema-resources-2019-05-10
  - tag: schema-resources-2019-05-01
  - tag: schema-resources-2019-03-01
  - tag: schema-resources-2018-06-01
  - tag: schema-resources-2018-05-01
  - tag: schema-resources-2018-02-01
  - tag: schema-resources-2017-05-10
  - tag: schema-resources-2016-09-01
  - tag: schema-resources-2016-07-01
  - tag: schema-resources-2016-06-01
  - tag: schema-resources-2016-02-01
  - tag: schema-resources-2015-11-01
  - tag: schema-features-2015-12-01
  - tag: schema-authorization-2020-07-01-preview
  - tag: schema-authorization-2020-03-01
  - tag: schema-authorization-2019-09-01
  - tag: schema-authorization-2019-06-01
  - tag: schema-authorization-2019-01-01
  - tag: schema-authorization-2018-05-01
  - tag: schema-authorization-2018-03-01
  - tag: schema-authorization-2017-06-01-preview
  - tag: schema-authorization-2016-12-01
  - tag: schema-authorization-2016-09-01
  - tag: schema-authorization-2016-04-01
  - tag: schema-authorization-2015-10-01-preview
  - tag: schema-authorization-2015-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-solutions-2020-08-21-preview and azureresourceschema

``` yaml $(tag) == 'schema-solutions-2020-08-21-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Solutions/preview/2020-08-21-preview/managedapplications.json

```

### Tag: schema-solutions-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-solutions-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Solutions/stable/2019-07-01/managedapplications.json

```

### Tag: schema-solutions-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-solutions-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Solutions/stable/2018-06-01/managedapplications.json

```

### Tag: schema-solutions-2017-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-solutions-2017-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Solutions/stable/2017-09-01/managedapplications.json

```

### Tag: schema-solutions-2016-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-solutions-2016-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Solutions/preview/2016-09-01-preview/managedapplications.json

```

### Tag: schema-resources-2020-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2020-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2020-10-01/deploymentScripts.json

```

### Tag: schema-resources-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2020-06-01/resources.json

```

### Tag: schema-resources-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2020-01-01/subscriptions.json

```

### Tag: schema-resources-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-11-01/subscriptions.json

```

### Tag: schema-resources-2019-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/preview/2019-10-01-preview/deploymentScripts.json

```

### Tag: schema-resources-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-10-01/resources.json

```

### Tag: schema-resources-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-08-01/resources.json

```

### Tag: schema-resources-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-07-01/resources.json

```

### Tag: schema-resources-2019-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/preview/2019-06-01-preview/templateSpecs.json

```

### Tag: schema-resources-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-06-01/subscriptions.json

```

### Tag: schema-resources-2019-05-10 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-05-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-05-10/resources.json

```

### Tag: schema-resources-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-05-01/resources.json

```

### Tag: schema-resources-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2019-03-01/resources.json

```

### Tag: schema-resources-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2018-06-01/subscriptions.json

```

### Tag: schema-resources-2018-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2018-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2018-05-01/resources.json

```

### Tag: schema-resources-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2018-02-01/resources.json

```

### Tag: schema-resources-2017-05-10 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2017-05-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2017-05-10/resources.json

```

### Tag: schema-resources-2016-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2016-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2016-09-01/resources.json
  - Microsoft.Resources/stable/2016-09-01/links.json

```

### Tag: schema-resources-2016-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2016-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2016-07-01/resources.json

```

### Tag: schema-resources-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2016-06-01/subscriptions.json

```

### Tag: schema-resources-2016-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2016-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2016-02-01/resources.json

```

### Tag: schema-resources-2015-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-resources-2015-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Resources/stable/2015-11-01/resources.json
  - Microsoft.Resources/stable/2015-11-01/subscriptions.json

```

### Tag: schema-features-2015-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-features-2015-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Features/stable/2015-12-01/features.json

```

### Tag: schema-authorization-2020-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2020-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2020-07-01-preview/policyExemptions.json

```

### Tag: schema-authorization-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2020-03-01/policyAssignments.json
  - Microsoft.Authorization/stable/2020-03-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2020-03-01/policySetDefinitions.json

```

### Tag: schema-authorization-2019-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2019-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2019-09-01/policyAssignments.json
  - Microsoft.Authorization/stable/2019-09-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2019-09-01/policySetDefinitions.json

```

### Tag: schema-authorization-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2019-06-01/policyAssignments.json
  - Microsoft.Authorization/stable/2019-06-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2019-06-01/policySetDefinitions.json

```

### Tag: schema-authorization-2019-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2019-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2019-01-01/policyAssignments.json
  - Microsoft.Authorization/stable/2019-01-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2019-01-01/policySetDefinitions.json

```

### Tag: schema-authorization-2018-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2018-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2018-05-01/policyAssignments.json
  - Microsoft.Authorization/stable/2018-05-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2018-05-01/policySetDefinitions.json

```

### Tag: schema-authorization-2018-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2018-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2018-03-01/policyAssignments.json
  - Microsoft.Authorization/stable/2018-03-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2018-03-01/policySetDefinitions.json

```

### Tag: schema-authorization-2017-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2017-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2017-06-01-preview/policyAssignments.json
  - Microsoft.Authorization/preview/2017-06-01-preview/policySetDefinitions.json

```

### Tag: schema-authorization-2016-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2016-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2016-12-01/policyAssignments.json

```

### Tag: schema-authorization-2016-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2016-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2016-09-01/locks.json

```

### Tag: schema-authorization-2016-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2016-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2016-04-01/policy.json

```

### Tag: schema-authorization-2015-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2015-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/preview/2015-10-01-preview/policy.json

```

### Tag: schema-authorization-2015-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-authorization-2015-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Authorization/stable/2015-01-01/locks.json

```
