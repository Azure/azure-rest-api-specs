import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL Database sync member.
 */
@parentResource(SyncGroup)
model SyncMember is Azure.ResourceManager.ProxyResource<SyncMemberProperties> {
  ...ResourceNameParameter<
    Resource = SyncMember,
    KeyName = "syncMemberName",
    SegmentName = "syncMembers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SyncMembers {
  /**
   * Gets a sync member.
   */
  get is ArmResourceRead<SyncMember>;

  /**
   * Creates or updates a sync member.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SyncMember,
    Response = ArmResourceUpdatedResponse<SyncMember> | ArmResourceCreatedResponse<
      SyncMember,
      ArmLroLocationHeader<FinalResult = SyncMember> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing sync member.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<SyncMember, PatchModel = SyncMember>;

  /**
   * Deletes a sync member.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SyncMember,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists sync members in the given sync group.
   */
  listBySyncGroup is ArmResourceListByParent<SyncMember>;

  /**
   * Refreshes a sync member database schema.
   */
  @action("refreshSchema")
  refreshMemberSchema is ArmResourceActionAsync<SyncMember, void, OkResponse>;

  /**
   * Gets a sync member database schema.
   */
  @list
  @get
  @action("schemas")
  listMemberSchemas is ArmResourceActionSync<
    SyncMember,
    void,
    ArmResponse<SyncFullSchemaPropertiesListResult>
  >;
}

@@doc(SyncMember.name, "The name of the sync member.");
@@doc(SyncMember.properties, "Resource properties.");
@@doc(SyncMembers.createOrUpdate::parameters.resource,
  "The requested sync member resource state."
);
@@doc(SyncMembers.update::parameters.properties,
  "The requested sync member resource state."
);
