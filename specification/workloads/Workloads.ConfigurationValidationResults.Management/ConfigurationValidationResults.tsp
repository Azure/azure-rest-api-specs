import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Configuration validation results.")
model ConfigurationValidationResults
  is ProxyResource<ConfigurationValidationResultsProperties> {
  /**
   * Defines the parameters for naming the configuration validation results resource.
   */
  ...ResourceNameParameter<
    Resource = ConfigurationValidationResults,
    KeyName = "configurationValidationResultName",
    SegmentName = "configurationValidationResults",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9_-]{2,80}"
  >;
}

@armResourceOperations
@doc("Operations related to retrieving configuration validation results.")
interface ConfigurationValidationResultsOperations {
  /**
   * The get on configuration validation results.
   */
  get is ArmResourceRead<ConfigurationValidationResults>;
}
