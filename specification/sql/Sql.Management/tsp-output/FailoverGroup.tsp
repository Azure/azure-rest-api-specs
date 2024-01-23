import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A failover group.
 */
@parentResource(Server)
model FailoverGroup is ProxyResource<FailoverGroupProperties> {
  /**
   * The name of the failover group.
   */
  @path
  @key("failoverGroupName")
  @segment("failoverGroups")
  name: string;
}

@armResourceOperations
interface FailoverGroups {
  /**
   * Gets a failover group.
   */
  get is ArmResourceRead<FailoverGroup>;

  /**
   * Creates or updates a failover group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FailoverGroup>;

  /**
   * Updates a failover group.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<FailoverGroup, FailoverGroupUpdate>;

  /**
   * Deletes a failover group.
   */
  delete is ArmResourceDeleteAsync<FailoverGroup>;

  /**
   * Lists the failover groups in a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FailoverGroups_ListByServer")
  listByServer is ArmResourceListByParent<FailoverGroup>;

  /**
   * Fails over from the current primary server to this server.
   */
  failover is ArmResourceActionAsync<FailoverGroup, void, FailoverGroup>;

  /**
   * Fails over from the current primary server to this server. This operation might result in data loss.
   */
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    FailoverGroup,
    void,
    FailoverGroup
  >;

  /**
   * Fails over from the current primary server to this server. This operation tries planned before forced failover but might still result in data loss.
   */
  tryPlannedBeforeForcedFailover is ArmResourceActionAsync<
    FailoverGroup,
    void,
    FailoverGroup,
    BaseParameters<FailoverGroup>,
    ArmLroLocationHeader
  >;
}

@@projectedName(FailoverGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(FailoverGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(FailoverGroups.createOrUpdate::parameters.resource,
  "The failover group parameters."
);
@@projectedName(FailoverGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(FailoverGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(FailoverGroups.update::parameters.properties,
  "The failover group parameters."
);
