import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "Faithful migration: the frozen CRR recoveryPoints path nesting depth exceeds the ARM-standard limit; the legacy path shape must be preserved."
@parentResource(ProtectedItemVirtualResource)
model RecoveryPointResource is ProxyResource<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Optional location"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: Azure.Core.azureLocation;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backward compatibility for optional ETag"
  eTag?: string;
}

@tag("RecoveryPoints_Crr")
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface RecoveryPointsCrr {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  get is ArmResourceRead<RecoveryPointResource, Error = NewErrorResponse>;

  /**
   * Lists the backup copies for the backed up item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @list
  @armResourceList(RecoveryPointResource)
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Fabric name associated with the backed up item.
     */
    @path fabricName: string,

    /**
     * Container name associated with the backed up item.
     */
    @path containerName: string,

    /**
     * Backed up item whose backup copies are to be fetched.
     */
    @path protectedItemName: string,

    ...ArmFilterParameter,
  ): ArmResponse<RecoveryPointResourceList> | NewErrorResponse;
}

@tag("RecoveryPoints_GetAccessToken")
@armResourceOperations(#{ omitTags: true })
interface RecoveryPoints {
  /**
   * Returns the Access token for communication between BMS and Protection service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Returns the Access token for communication between BMS and Protection service")
  @action("accessToken")
  getAccessToken is ArmResourceActionSync<
    RecoveryPointResource,
    AadPropertiesResource,
    ArmResponse<CrrAccessTokenResource>,
    Error = NewErrorResponse
  >;
}

@@doc(RecoveryPointResource.name, "Recovery Point Id");
@@doc(RecoveryPointResource.properties, "RecoveryPointResource properties");
@@doc(
  RecoveryPoints.getAccessToken::parameters.body,
  "Get Access Token request"
);
