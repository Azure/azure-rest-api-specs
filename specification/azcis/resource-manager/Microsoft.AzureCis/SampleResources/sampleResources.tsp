import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("SampleResource properties")
model SampleResourceProperties {
  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: SampleResourceProvisioningState;
}

@doc("SampleResource Resource")
model SampleResource is ProxyResource<SampleResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("sampleResources")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface SampleResources {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SampleResource>;
  get is ArmResourceRead<SampleResource>;
  listBySubscription is ArmListBySubscription<SampleResource>;
  listByResourceGroup is ArmResourceListByParent<SampleResource>;
}
