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

namespace Microsoft.DataReplication;
/**
 * Vault model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VaultModelProperties)
model VaultModel extends TrackedResourceBase {
  /**
   * The vault name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("vaultName")
  @segment("replicationVaults")
  @visibility("read")
  name: string;

  /**
   * Vault properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VaultModelProperties;
}

@armResourceOperations
interface VaultModels {
  /**
   * Gets the details of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vault_Get")
  get is ArmResourceRead<VaultModel>;

  /**
   * Creates the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vault_Create")
  create is ArmResourceCreateOrReplaceAsync<
    VaultModel,
    BaseParameters<VaultModel>,
    ArmLroLocationHeader
  >;

  /**
   * Performs update on the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Vault_Update")
  update is ArmCustomPatchAsync<
    VaultModel,
    VaultModelUpdate,
    BaseParameters<VaultModel>,
    ArmLroLocationHeader
  >;

  /**
   * Removes the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vault_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VaultModel,
    BaseParameters<VaultModel>,
    ArmLroLocationHeader
  >;

  /**
   * Gets the list of vaults in the given subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vault_List")
  list is ArmResourceListByParent<
    VaultModel,
    {
      ...BaseParameters<VaultModel>;

      /**
       * Continuation token from the previous call.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  /**
   * Gets the list of vaults in the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vault_ListBySubscription")
  listBySubscription is ArmListBySubscription<VaultModel>;
}

@@projectedName(VaultModels.create::parameters.resource, "json", "body");
@@extension(VaultModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VaultModels.create::parameters.resource, "Vault properties.");
@@projectedName(VaultModels.update::parameters.properties, "json", "body");
@@extension(VaultModels.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VaultModels.update::parameters.properties, "Vault properties.");
