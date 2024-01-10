import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KeyVault;

@locationResource
model DeletedManagedHsm is ProxyResource<DeletedManagedHsmProperties> {
  @doc("The name of the deleted managed HSM.")
  @key("name")
  @segment("deletedManagedHSMs")
  name: string;
}

@armResourceOperations
@projectedName("client", "ManagedHsms")
interface DeletedManagedHsms_ManagedHsms {
  @doc("Gets the specified deleted managed HSM.")
  getDeleted is ArmResourceRead<DeletedManagedHsm>;

  @doc("Permanently deletes the specified managed HSM.")
  purgeDeleted is ArmResourceActionNoResponseContentAsync<
    DeletedManagedHsm,
    void
  >;
}
