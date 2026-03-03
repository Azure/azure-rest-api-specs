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
 * A replication link.
 */
@parentResource(Database)
model ReplicationLink
  is Azure.ResourceManager.ProxyResource<ReplicationLinkProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationLink,
    KeyName = "linkId",
    SegmentName = "replicationLinks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ReplicationLinks {
  /**
   * Gets a replication link.
   */
  get is ArmResourceRead<ReplicationLink>;

  /**
   * Updates the replication link type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ReplicationLink,
    Response = ArmResourceUpdatedResponse<ReplicationLink> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationLink> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the replication link type.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ReplicationLink,
    PatchModel = ReplicationLinkUpdate
  >;

  /**
   * Deletes the replication link.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ReplicationLink,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Gets a list of replication links on database.
   */
  listByDatabase is ArmResourceListByParent<ReplicationLink>;

  /**
   * Fails over from the current primary server to this server.
   */
  failover is ArmResourceActionAsync<
    ReplicationLink,
    void,
    ArmResponse<ReplicationLink>
  >;

  /**
   * Fails over from the current primary server to this server allowing data loss.
   */
  @action("forceFailoverAllowDataLoss")
  failoverAllowDataLoss is ArmResourceActionAsync<
    ReplicationLink,
    void,
    ArmResponse<ReplicationLink>
  >;
}

@@doc(ReplicationLink.name, "The name of the replication link.");
@@doc(ReplicationLink.properties, "Resource properties.");
@@doc(ReplicationLinks.createOrUpdate::parameters.resource, "");
@@doc(ReplicationLinks.update::parameters.properties, "");
