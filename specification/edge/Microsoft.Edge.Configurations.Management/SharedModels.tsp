import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Available dynamic configuration types")
union DynamicConfigurationType {
  @doc("Configuration type Shared")
  Shared: "Shared",

  @doc("Configuration type Hierarchy")
  Hierarchy: "Hierarchy",

  string,
}

@doc("Dynamic Configuration Properties")
model DynamicConfigurationProperties {
  @doc("Current Version of dynamic configuration")
  currentVersion: string;

  @doc("Type of dynamic configuration")
  dynamicConfigurationType: DynamicConfigurationType;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}
