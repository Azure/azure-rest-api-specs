## Java

``` yaml $(java)
java:
    namespace: com.azure.maps.creator
    license-header: MICROSOFT_MIT_SMALL
    payload-flattening-threshold: 0
    output-folder: $(azure-libraries-for-java-folder)/azure-maps-creator
    add-context-parameter: true
    context-client-method-parameter: true
    client-logger: true
    sync-methods: all
    generate-sync-async-clients: true
    polling:
      default:
        strategy: new com.azure.maps.creator.polling.OperationResourcePollingStrategy<>({httpPipeline})
```