## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  fluent: true
  namespace: com.azure.quantum.jobs
  license-header: MICROSOFT_MIT_NO_CODEGEN
  output-folder: $(azure-libraries-for-java-folder)/quantum/azure-quantum-jobs
```
