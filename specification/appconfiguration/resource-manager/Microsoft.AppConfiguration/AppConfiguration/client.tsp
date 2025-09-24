import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.AppConfiguration;
using Azure.ClientGenerator.Core;

// Fix the manager service client name change to maintain backward compatibility
@@clientName(Microsoft.AppConfiguration, "AppConfigurationManagement", "java");

// Fix the property name change in KeyValue model - eTag should remain as etag
@@clientName(Microsoft.AppConfiguration.KeyValueProperties.eTag,
  "etag",
  "java"
);
