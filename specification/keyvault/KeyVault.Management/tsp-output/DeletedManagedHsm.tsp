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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@includeInapplicableMetadataInPayload(false)
model DeletedManagedHsm {
  /**
   * The name of the deleted managed HSM.
   */
  @path
  @key("name")
  @segment("deletedManagedHSMs")
  @visibility("read")
  name: string;

  /**
   * The Azure Resource Manager resource ID for the deleted managed HSM Pool.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource type of the managed HSM Pool.
   */
  @visibility("read")
  type?: string;

  /**
   * Properties of the deleted managed HSM
   */
  @extension("x-ms-client-flatten", true)
  properties?: DeletedManagedHsmProperties;
}

@armResourceOperations
interface DeletedManagedHsms {
  /**
   * Gets the specified deleted managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedHsms_GetDeleted")
  getDeleted is ArmResourceRead<DeletedManagedHsm>;

  /**
   * Permanently deletes the specified managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedHsms_PurgeDeleted")
  purgeDeleted is ArmResourceActionNoResponseContentAsync<
    DeletedManagedHsm,
    void
  >;
}
