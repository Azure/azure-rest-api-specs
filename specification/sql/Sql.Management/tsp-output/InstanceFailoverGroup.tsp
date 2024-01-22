import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An instance failover group.
 */
model InstanceFailoverGroup is ProxyResource<InstanceFailoverGroupProperties> {
  /**
   * The name of the failover group.
   */
  @path
  @key("failoverGroupName")
  @segment("instanceFailoverGroups")
  name: string;
}

@armResourceOperations
interface InstanceFailoverGroups {
  /**
   * Gets a failover group.
   */
  get is ArmResourceRead<InstanceFailoverGroup>;

  /**
   * Creates or updates a failover group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InstanceFailoverGroup>;

  /**
   * Deletes a failover group.
   */
  delete is ArmResourceDeleteAsync<InstanceFailoverGroup>;

  /**
   * Lists the failover groups in a location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InstanceFailoverGroups_ListByLocation")
  listByLocation is ArmResourceListByParent<InstanceFailoverGroup>;

  /**
   * Fails over from the current primary managed instance to this managed instance.
   */
  failover is ArmResourceActionAsync<
    InstanceFailoverGroup,
    void,
    InstanceFailoverGroup
  >;

  /**
   * Fails over from the current primary managed instance to this managed instance. This operation might result in data loss.
   */
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    InstanceFailoverGroup,
    void,
    InstanceFailoverGroup
  >;
}

@@projectedName(InstanceFailoverGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(InstanceFailoverGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(InstanceFailoverGroups.createOrUpdate::parameters.resource,
  "The failover group parameters."
);
