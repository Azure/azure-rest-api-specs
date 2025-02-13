import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;

@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DeletedManagedHsm
  is Azure.ResourceManager.ProxyResource<DeletedManagedHsmProperties> {
  ...ResourceNameParameter<
    Resource = DeletedManagedHsm,
    KeyName = "name",
    SegmentName = "deletedManagedHSMs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedManagedHsms {
  /**
   * Gets the specified deleted managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedHsms_GetDeleted")
  getDeleted is ArmResourceRead<
    DeletedManagedHsm,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Permanently deletes the specified managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("purge")
  @operationId("ManagedHsms_PurgeDeleted")
  purgeDeleted is ArmResourceActionAsync<
    DeletedManagedHsm,
    void,
    void,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(DeletedManagedHsm.name, "The name of the deleted managed HSM.");
@@doc(DeletedManagedHsm.properties, "Properties of the deleted managed HSM");
