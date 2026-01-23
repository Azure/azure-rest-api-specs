import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.AppConfiguration;
using Azure.ClientGenerator.Core;

// Fix the property name change in KeyValue model - eTag should remain as etag
@@clientName(Microsoft.AppConfiguration.KeyValueProperties.eTag,
  "etag",
  "java"
);

@@clientName(Microsoft.AppConfiguration,
  "AppConfigurationManagementClient",
  "javascript,python"
);
