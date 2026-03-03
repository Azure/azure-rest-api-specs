import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL Database sync group.
 */
@parentResource(Database)
model SyncGroup is Azure.ResourceManager.ProxyResource<SyncGroupProperties> {
  ...ResourceNameParameter<
    Resource = SyncGroup,
    KeyName = "syncGroupName",
    SegmentName = "syncGroups",
    NamePattern = ""
  >;

  /**
   * The name and capacity of the SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface SyncGroups {
  /**
   * Gets a sync group.
   */
  get is ArmResourceRead<SyncGroup>;

  /**
   * Creates or updates a sync group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SyncGroup,
    Response = ArmResourceUpdatedResponse<SyncGroup> | ArmResourceCreatedResponse<
      SyncGroup,
      ArmLroLocationHeader<FinalResult = SyncGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a sync group.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<SyncGroup, PatchModel = SyncGroup>;

  /**
   * Deletes a sync group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SyncGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists sync groups under a hub database.
   */
  listByDatabase is ArmResourceListByParent<SyncGroup>;

  /**
   * Cancels a sync group synchronization.
   */
  cancelSync is ArmResourceActionSync<SyncGroup, void, OkResponse>;

  /**
   * Gets a collection of hub database schemas.
   */
  @list
  @get
  @action("hubSchemas")
  listHubSchemas is ArmResourceActionSync<
    SyncGroup,
    void,
    ArmResponse<SyncFullSchemaPropertiesListResult>
  >;

  /**
   * Gets a collection of sync group logs.
   */
  @list
  @get
  @action("logs")
  listLogs is ArmResourceActionSync<
    SyncGroup,
    void,
    ArmResponse<SyncGroupLogListResult>,
    Parameters = {
      /**
       * Get logs generated after this time.
       */
      @query("startTime")
      startTime: string;

      /**
       * Get logs generated before this time.
       */
      @query("endTime")
      endTime: string;

      /**
       * The types of logs to retrieve.
       */
      @query("type")
      type: SyncGroupsType;

      /**
       * The continuation token for this operation.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  /**
   * Refreshes a hub database schema.
   */
  refreshHubSchema is ArmResourceActionAsync<SyncGroup, void, OkResponse>;

  /**
   * Triggers a sync group synchronization.
   */
  triggerSync is ArmResourceActionSync<SyncGroup, void, OkResponse>;
}

@@doc(SyncGroup.name, "The name of the sync group.");
@@doc(SyncGroup.properties, "Resource properties.");
@@doc(SyncGroups.createOrUpdate::parameters.resource,
  "The requested sync group resource state."
);
@@doc(SyncGroups.update::parameters.properties,
  "The requested sync group resource state."
);
