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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityData;

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: VaultProperties;

  /**
   * Identifies the unique system identifier for each Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * etag for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
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
      >>,
      ErrorType = ErrorResponse
    > {}

@armResourceOperations
interface VaultOpsWithCloudError
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
      >>,
      ErrorType = CloudError
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VaultCreateOps
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VaultCreateOpsWithCloudError
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
      >>,
      ErrorType = CloudError
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VaultOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VaultStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         *The name of the recovery services vault.
         */
        @segment("vaults")
        @path
        vaultName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("operationStatus")
        operationId: string,
      },
      ErrorType = CloudError
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VaultDeleteOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface Vaults {
  /**
   * Get the Vault details.
   */
  get is VaultOpsWithCloudError.Read<Vault>;

  /**
   * Creates or updates a Recovery Services vault.
   */
  createOrUpdate is VaultCreateOpsWithCloudError.CreateOrUpdateAsync<
    Vault,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = Vault> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the vault.
   */
  @patch(#{ implicitOptionality: false })
  update is VaultOpsWithCloudError.CustomPatchAsync<
    Vault,
    PatchModel = PatchVault,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/certificates/{certificateName}")
  create is Azure.ResourceManager.Legacy.UpdateOperation<
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      /**
       * The name of the recovery services vault.
       */
      @path
      vaultName: string;

      /**
       * Certificate friendly name.
       */
      @path
      @segment("certificates")
      certificateName: string;
    },
    CertificateRequest,
    ArmResourceUpdatedResponse<VaultCertificateResponse>,
    ErrorResponse
  >;

  /**
   * Unregisters the given container from your Recovery Services vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  registeredIdentitiesDelete is VaultDeleteOps.DeleteSync<
    Vault,
    {},
    NoContentResponse
  >;

  /**
   * Fetches the replication usages of the vault.
   */
  @get
  @action("replicationUsages")
  list is VaultOps.ActionSync<Vault, void, ArmResponse<ReplicationUsageList>>;

  /**
   * Fetches the usages of the vault.
   */
  @get
  @action("usages")
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
      >>,
      ErrorType = CloudError
    > {}

@armResourceOperations
interface GetOperationResult {
  /**
   * Retrieve a list of Vaults.
   */
  listByResourceGroup is ArmResourceListByParent<
    Vault,
    Response = ArmResponse<VaultList>,
    Error = CloudError
  >;
}

/**
 * Gets the operation status for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@get
op getOperationStatus is VaultStatusOps.Read<
  Vault,
  Response = ArmResponse<OperationResource>
>;

/**
 * Gets the operation result for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("Vaults")
op getOperationResult is GetOperationResultOps.Read<
  Vault,
  Response = ArmResponse<Vault> | AcceptedResponse
>;

@@doc(Vault.name, "The name of the recovery services vault.");
@@doc(Vault.properties, "Properties of the vault.");
@@doc(Vaults.createOrUpdate::parameters.resource,
  "Recovery Services Vault to be created."
);
@@doc(Vaults.update::parameters.properties,
  "Recovery Services Vault to be created."
);

@@doc(Vaults.create::parameters.properties,
  "Input parameters for uploading the vault certificate."
);
