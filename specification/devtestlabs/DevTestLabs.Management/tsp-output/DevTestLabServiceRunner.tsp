import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
// FIXME: DevTestLabServiceRunner has no properties property
@doc("A container for a managed identity to execute DevTest lab services.")
@parentResource(DevTestLab)
model DevTestLabServiceRunner is TrackedResource<{}> {
  @doc("The name of the service runner.")
  @path
  @key("name")
  @segment("servicerunners")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DevTestLabServiceRunners {
  @doc("Get service runner.")
  get is ArmResourceRead<DevTestLabServiceRunner>;
  @doc("Create or replace an existing service runner.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevTestLabServiceRunner>;
  @doc("Delete service runner.")
  delete is ArmResourceDeleteSync<DevTestLabServiceRunner>;
}
