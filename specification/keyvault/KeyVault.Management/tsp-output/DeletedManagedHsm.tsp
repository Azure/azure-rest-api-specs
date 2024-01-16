import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;

@locationResource
model DeletedManagedHsm is ProxyResource<DeletedManagedHsmProperties> {
  @doc("The name of the deleted managed HSM.")
  @path
  @key("name")
  @segment("deletedManagedHSMs")
  name: string;
}

@armResourceOperations
interface DeletedManagedHsms {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified deleted managed HSM.")
  @operationId("ManagedHsms_GetDeleted")
  getDeleted is ArmResourceRead<DeletedManagedHsm>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Permanently deletes the specified managed HSM.")
  @operationId("ManagedHsms_PurgeDeleted")
  purgeDeleted is ArmResourceActionNoResponseContentAsync<
    DeletedManagedHsm,
    void
  >;
}
