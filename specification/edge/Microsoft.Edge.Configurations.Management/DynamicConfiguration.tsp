import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Dynamic Configuration Properties")
model DynamicConfigurationProperties {
  @doc("Current Version of dynamic configuration")
  currentVersion: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Dynamic Configuration Resource")
@parentResource(Configuration)
model DynamicConfiguration is ProxyResource<DynamicConfigurationProperties> {
  ...ResourceNameParameter<DynamicConfiguration>;
}

@armResourceOperations
interface DynamicConfigurations {
  @doc("Get a Dynamic Configuration Resource")
  get is ArmResourceRead<DynamicConfiguration>;

  @doc("Create or update a Dynamic Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DynamicConfiguration>;

  @doc("Update a Dynamic Configuration Resource")
  update is ArmResourcePatchSync<
    DynamicConfiguration,
    DynamicConfigurationProperties
  >;

  @doc("Delete a Dynamic Configuration Resource")
  delete is ArmResourceDeleteSync<DynamicConfiguration>;

  @doc("List Dynamic Configuration Resources")
  listByParent is ArmResourceListByParent<DynamicConfiguration>;

  @doc("Post request to resolve configuration")
  resolveConfiguration is ArmResourceActionSync<
    DynamicConfiguration,
    void,
    DynamicConfigurationProperties
  >;
}
