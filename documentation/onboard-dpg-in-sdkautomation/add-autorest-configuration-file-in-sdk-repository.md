# Add Autorest Configuration in SDK Repository

## Prerequisites
There should be a basic readme.md together with swagger, and you can refer to the [sample](../samplefiles-dp).

## Add Autorest Configuration for .Net SDK
//TODO

## Add Autorest Configuration for Java SDK
//TODO

## Add Autorest Configuration for Python SDK
//TODO

## Add Autorest Configuration for JS SDK
The autorest configuration file `README.md` should be in `azure-sdk-for-js-<pr>/sdk/[[ServiceName]]/[[PackageFolderName]]/swagger/README.md`.
  - `[[ServiceName]]`: It's recommended to keep it same as the one under `specification` in swagger repository.
  - `[[PackageFolderName]]`: The package name of dataplane js sdk should be in format `xxx-rest`, which ends with `-rest`.
If the package is single client (only contains one swagger file), please refer to [Sample JS README.md for Single Client](js/singleClientREADMESample.md) to write README.md.
If the package is multi client (contains more than one swagger file), please refer to [Sample JS README.md for Multi Client](js/multiClientREADMESample.md)to write README.md.