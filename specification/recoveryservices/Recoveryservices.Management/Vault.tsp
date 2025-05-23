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
@Azure.ResourceManager.Private.armResourceInternal(VaultProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model Vault extends Foundations.TrackedResource {
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

  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: VaultProperties;

  /**
   * Identifies the unique system identifier for each Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * etag for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface VaultOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.CustomProvider,
      },
      KeysOf<ResourceNameParameter<
        Resource = Vault,
        KeyName = "vaultName",
        SegmentName = "vaults",
        NamePattern = ""
      >>
    > {}

interface VaultCreateOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      KeysOf<ResourceNameParameter<
        Resource = Vault,
        KeyName = "vaultName",
        SegmentName = "vaults",
        NamePattern = ""
      >>
    > {}

interface VaultOperationOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      {
        /**
         *The name of the recovery services vault.
         */
        @segment("vaults")
        @path
        vaultName: string,

        /**
         * Certificate friendly name.
         */
        @path
        @segment("certificates")
        certificateName: string,
      }
    > {}

interface VaultStatusOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      {
        /**
         *The name of the recovery services vault.
         */
        @segment("vaults")
        @path
        vaultName: string,

        @path
        @segment("operationStatus")
        operationId: string,
      }
    > {}

interface VaultDeleteOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      {
        /**
         *The name of the recovery services vault.
         */
        @segment("vaults")
        @path
        vaultName: string,

        /**
         * Name of the protection container to unregister.
         */
        @path
        @segment("registeredIdentities")
        identityName: string,
      }
    > {}
interface Vaults {
  /**
   * Get the Vault details.
   */
  get is VaultOps.Read<Vault, ErrorType = CloudError>;

  /**
   * Creates or updates a Recovery Services vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}")
  createOrUpdate is VaultCreateOps.CreateOrUpdateAsync<
    Vault,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    ErrorType = CloudError
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
    },
    ErrorType = CloudError
  >;

  /**
   * Deletes a vault.
   */
  delete is VaultOps.DeleteWithoutOkAsync<
    Vault,
    Response = ArmAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Fetches all the resources of the specified type in the subscription.
   */
  listBySubscriptionId is ArmListBySubscription<
    Vault,
    Response = ArmResponse<VaultList>,
    Error = CloudError
  >;

  /**
   * Uploads a certificate for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @operationId("VaultCertificates_Create")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/certificates/{certificateName}")
  create is VaultOperationOps.ActionNoAutoSync<
    Vault,
    CertificateRequest,
    ArmResponse<VaultCertificateResponse>
  >;

  /**
   * Unregisters the given container from your Recovery Services vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @operationId("RegisteredIdentities_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/registeredIdentities/{identityName}")
  registeredIdentitiesDelete is VaultDeleteOps.ActionNoAutoSync<
    Vault,
    void,
    NoContentResponse
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
  @operationId("GetOperationStatus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/operationStatus/{operationId}")
  getOperationStatus is VaultStatusOps.ActionNoAutoSync<
    Vault,
    void,
    ArmResponse<OperationResource>,
    ErrorType = CloudError
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
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.CustomProvider,
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
    Response = ArmResponse<Vault> | AcceptedResponse,
    ErrorType = CloudError
  >;

  /**
   * Retrieve a list of Vaults.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Vaults_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Vault,
    Response = ArmResponse<VaultList>,
    Error = CloudError
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
