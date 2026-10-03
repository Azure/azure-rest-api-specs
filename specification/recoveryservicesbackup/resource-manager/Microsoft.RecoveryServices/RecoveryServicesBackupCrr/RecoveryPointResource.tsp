import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;

/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
model RecoveryPointResource extends Resource {
  /**
   * RecoveryPointResource properties
   */
  properties?: RecoveryPoint;
}

interface RecoveryPointResources {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID.
   */
  @tag("RecoveryPoints_Crr")
  @operationId("RecoveryPointsCrr_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Fabric name associated with backed up item.
     */
    @path fabricName: string,

    /**
     * Container name associated with backed up item.
     */
    @path containerName: string,

    /**
     * Backed up item name whose backup data needs to be fetched.
     */
    @path protectedItemName: string,

    /**
     * RecoveryPointID represents the backed up data to be fetched.
     */
    @path recoveryPointId: string,
  ): LegacyOkResponseBody<RecoveryPointResource> | NewErrorResponse;

  /**
   * Lists the backup copies for the backed up item.
   */
  @tag("RecoveryPoints_Crr")
  @operationId("RecoveryPointsCrr_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/")
  @get
  @extension("x-ms-odata", "#/definitions/BMSRPQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
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

    /**
     * OData filter options.
     */
    @query("$filter") $filter?: string,
  ): LegacyOkResponseBody<RecoveryPointResourceList> | NewErrorResponse;

  /**
   * Returns the Access token for communication between BMS and Protection service
   */
  @tag("RecoveryPoints_GetAccessToken")
  @summary("Returns the Access token for communication between BMS and Protection service")
  @operationId("RecoveryPoints_GetAccessToken")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/accessToken")
  @post
  getAccessToken(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Fabric name associated with the container.
     */
    @path fabricName: string,

    /**
     * Name of the container.
     */
    @path containerName: string,

    /**
     * Name of the Protected Item.
     */
    @path protectedItemName: string,

    /**
     * Recovery Point Id
     */
    @path recoveryPointId: string,

    /**
     * Get Access Token request
     */
    @body parameters: AADPropertiesResource,
  ):
    | LegacyOkResponseBody<CrrAccessTokenResource>
    | TypeSpec.Http.BadRequestResponse
    | NewErrorResponse;
}
