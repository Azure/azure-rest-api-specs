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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("operationStatus")
        operationId: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("replicationUsages")
  @operationId("ReplicationUsages_List")
  list is VaultOps.ActionSync<Vault, void, ArmResponse<ReplicationUsageList>>;

  /**
   * Gets the operation status for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GetOperationResult")
  getOperationResult is GetOperationResultOps.Read<
    Vault,
    Response = ArmResponse<Vault> | AcceptedResponse,
    ErrorType = CloudError
  >;

  /**
   * Retrieve a list of Vaults.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
