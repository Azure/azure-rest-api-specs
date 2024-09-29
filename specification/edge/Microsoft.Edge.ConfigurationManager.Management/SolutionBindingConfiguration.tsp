import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionBinding.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Solution Binding Configuration Properties")
model SolutionBindingConfigurationProperties {
  @doc("Value of Solution Binding Configuration")
  value: string;

  @doc("Revision of Solution Binding Configuration")
  revision: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Binding Configuration Resource")
@parentResource(SolutionBinding)
model SolutionBindingConfiguration
  is ProxyResource<SolutionBindingConfigurationProperties> {
  ...ResourceNameParameter<SolutionBindingConfiguration>;
}

@armResourceOperations
interface SolutionBindingConfigurations {
  @doc("Get a Solution Binding Configuration Resource")
  get is ArmResourceRead<SolutionBindingConfiguration>;

  @doc("Create or update a Solution Binding Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionBindingConfiguration>;

  @doc("update a Solution Binding Configuration Resource")
  update is ArmResourcePatchSync<
    SolutionBindingConfiguration,
    SolutionBindingConfigurationProperties
  >;

  @doc("Delete a Solution Binding Configuration Resource")
  delete is ArmResourceDeleteSync<SolutionBindingConfiguration>;

  @doc("List Solution Binding Configuration resource")
  listBySolutionBinding is ArmResourceListByParent<SolutionBindingConfiguration>;
}
