import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Resource information, as returned by the resource provider.
 */
model Vault is Azure.ResourceManager.TrackedResource<VaultProperties> {
  ...ResourceNameParameter<
    Resource = Vault,
    KeyName = "vaultName",
    SegmentName = "vaults",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityData;

  /**
   * Identifies the unique system identifier for each Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface VaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = Vault,
        KeyName = "vaultName",
        SegmentName = "vaults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Vaults {
  /**
   * Get the Vault details.
   */
  get is VaultOps.Read<Vault>;

  /**
   * Creates or updates a Recovery Services vault.
   */
  createOrUpdate is VaultOps.CreateOrUpdateAsync<
    Vault,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the vault.
   */
  @patch(#{ implicitOptionality: false })
  update is VaultOps.CustomPatchAsync<
    Vault,
    PatchModel = PatchVault,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;

  /**
   * Deletes a vault.
   */
  delete is VaultOps.DeleteWithoutOkAsync<Vault>;

  /**
   * Fetches all the resources of the specified type in the subscription.
   */
  listBySubscriptionId is VaultOps.ListBySubscription<
    Vault,
    Response = ArmResponse<VaultList>
  >;

  /**
   * Uploads a certificate for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("{certificateName}")
  @operationId("VaultCertificates_Create")
  create is VaultOps.ActionSync<
    Vault,
    CertificateRequest,
    ArmResponse<VaultCertificateResponse>,
    Parameters = {
      /**
       * Certificate friendly name.
       */
      @path
      certificateName: string;
    }
  >;

  /**
   * Unregisters the given container from your Recovery Services vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{identityName}")
  @operationId("RegisteredIdentities_Delete")
  registeredIdentitiesDelete is VaultOps.ActionSync<
    Vault,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Name of the protection container to unregister.
       */
      @path
      identityName: string;
    }
  >;

  /**
   * Fetches the replication usages of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("replicationUsages")
  @operationId("ReplicationUsages_List")
  list is VaultOps.ActionSync<Vault, void, ArmResponse<ReplicationUsageList>>;

  /**
   * Gets the operation status for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("GetOperationStatus")
  getOperationStatus is VaultOps.ActionSync<
    Vault,
    void,
    ArmResponse<OperationResource>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @path
      operationId: string;
    }
  >;

  /**
   * Fetches the usages of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("usages")
  @operationId("Usages_ListByVaults")
  listByVaults is VaultOps.ActionSync<Vault, void, ArmResponse<VaultUsageList>>;
}
@armResourceOperations
interface GetOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Vault,
          KeyName = "vaultName",
          SegmentName = "vaults",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Vault,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface GetOperationResult {
  /**
   * Gets the operation result for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetOperationResult")
  getOperationResult is GetOperationResultOps.Read<
    Vault,
    Response = ArmResponse<Vault> | AcceptedResponse
  >;

  /**
   * Retrieve a list of Vaults.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Vaults_ListByResourceGroup")
  listByResourceGroup is GetOperationResultOps.List<
    Vault,
    Response = ArmResponse<VaultList>
  >;
}

@@doc(Vault.name, "The name of the recovery services vault.");
@@doc(Vault.properties, "Properties of the vault.");
@@doc(Vaults.createOrUpdate::parameters.resource,
  "Recovery Services Vault to be created."
);
@@doc(Vaults.update::parameters.properties,
  "Recovery Services Vault to be created."
);
@@doc(Vaults.create::parameters.body,
  "Input parameters for uploading the vault certificate."
);
