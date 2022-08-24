# Service Contract Accuracy Report

The purpose of the Service Contract (Swagger) Accuracy Report is to ensure that service contracts accuractly reflect true service behavior. It is critical that the contract be accurate because we use it to produce many assets such as documentation, SDKs (in many programming languages), and tools (Azure CLI & PowerShell). When the contract is incorrect, these assets are broken and fixing the contract later causes breaking changes and significant pain to all our customers. 

Our tooling ([RESTler](https://github.com/microsoft/restler-fuzzer)) that produces this report tests all service operations and compares the actual requests/responses against the contract for accuracy. 

***
**IMPORTANT: _All operations must be tested and pass before the PR contract can be merged._**
***

For any `Failed Operations`, use the error information (and links provided) to either fix the contract or fix the service behavior. Fix failed operations first as this may enable our tooling to test some of the currently untested operations.

For any `Untested Operations`, you must improve the RESTler configuration files:
 1. Download the RESTler configuation file
    - ...
 2. Modify the configuration file
    - ...
 3. Debug your configuration file changes locally
    - ...
 4. Upload the modified conf file so the PR pipeline can use it and re-run the Service Contract Accuracy report
    - ...
