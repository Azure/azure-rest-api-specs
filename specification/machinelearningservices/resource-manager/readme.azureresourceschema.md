## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.MachineLearningServices/stable/2020-06-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2020-05-15-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2020-04-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2020-03-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2020-01-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2019-11-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2019-06-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2019-05-01/machineLearningServices.json
  - Microsoft.MachineLearningServices/stable/2018-11-19/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2020-09-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2020-05-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2020-04-01-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2020-02-18-preview/machineLearningServices.json
  - Microsoft.MachineLearningServices/preview/2018-03-01-preview/machineLearningServices.json

```