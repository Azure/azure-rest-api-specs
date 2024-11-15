import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

// Python specific customizations
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
model MyClientOptions {
  /**
   * Used to guarantee real-time consistency between requests.
   */
  syncToken?: string;
}
@@clientInitialization(AzureAppConfiguration, MyClientOptions, "python");
@@clientName(KeyValueFields, "ConfigurationSettingFields", "python");
@@clientName(CompositionType, "SnapshotComposition", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
@@access(SnapshotUpdateParameters, Access.public, "python");
