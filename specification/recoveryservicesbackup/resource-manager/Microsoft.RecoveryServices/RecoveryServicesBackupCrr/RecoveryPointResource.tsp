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
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "Faithful migration: the frozen CRR recoveryPoints path nesting depth exceeds the ARM-standard limit; the legacy path shape must be preserved."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Faithful migration: RecoveryPointResource carries a legacy optional 'location' and is modeled with Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation to reproduce the original envelope exactly. It is a read-only proxy resource, not a true tracked resource."
@parentResource(ProtectedItemVirtualResource)
model RecoveryPointResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
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
@@TypeSpec.OpenAPI.extension(
  RecoveryPointsCrr.list,
  "x-ms-odata",
  "#/definitions/BMSRPQueryObject"
);
