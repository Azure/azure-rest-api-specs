import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Represents a Sql pool replication link.
 */
@parentResource(SqlPool)
model ReplicationLink
  is Azure.ResourceManager.ProxyResource<ReplicationLinkProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationLink,
    KeyName = "linkId",
    SegmentName = "replicationLinks",
    NamePattern = ""
  >;

  /**
   * Location of the workspace that contains this firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ReplicationLinks {
  /**
   * Get SQL pool replication link by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolReplicationLinks_GetByName")
  getByName is ArmResourceRead<ReplicationLink>;

  /**
   * Lists a Sql pool's replication links.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolReplicationLinks_List")
  list is ArmResourceListByParent<ReplicationLink>;
}

@@doc(ReplicationLink.name, "The ID of the replication link.");
@@doc(ReplicationLink.properties, "The properties representing the resource.");
