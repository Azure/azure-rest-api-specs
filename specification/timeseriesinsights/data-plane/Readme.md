
# Azure Time Series Insights Data Plane API

## Getting Started 

To build the SDKs for Azure Time Series Insights Data Plane API, simply [Install AutoRest](#Installing-AutoRest) and run:
> `Autorest.exe readme.md`

To see additional help and options, run:
> `Autorest.exe help readme.md`

### Installing AutoRest

AutoRest is most easily installed via the Node JS package `autorest`:
> npm install -g autorest 

For other options on installation see [Installing AutoRest](https://aka.ms/installing-autorest.md) on the AutoRest github page.

## AutoRest configuration

``` yaml
input-file: 
	- .\Spec\Microsoft.TimeSeriesInsights\preview\2018-11-01-preview\timeseriesinsights.json

azure-validator: true
model-validator: true
semantic-validator: true
add-credentials: true
openapi-type: data-plane
license-header: MICROSOFT_MIT
sync-methods: none

csharp:
  namespace: Microsoft.Azure.TimeSeriesInsights
  output-folder: Generated/CSharp

```

## Suppression

``` yaml
directive:
  - suppress: R2001
    reason: Adding flattening does not improve the code - array of properties is not supported by flattening.
```

``` yaml
directive:
  - suppress: R3017
    reason: GUIDs are required to enforce referential constraints and reduce number of updates.
```
