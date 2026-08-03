import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Distributed availability group between box and Sql Managed Instance.
 */
@parentResource(ManagedInstance)
model DistributedAvailabilityGroup
  is ProxyResource<DistributedAvailabilityGroupProperties> {
  /**
   * The distributed availability group name.
   */
  @path
  @key("distributedAvailabilityGroupName")
  @segment("distributedAvailabilityGroups")
  name: string;
}

@armResourceOperations
interface DistributedAvailabilityGroups {
  /**
   * Gets a distributed availability group info.
   */
  get is ArmResourceRead<DistributedAvailabilityGroup>;

  /**
   * Creates a distributed availability group between Sql On-Prem and Sql Managed Instance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DistributedAvailabilityGroup>;

  /**
   * Updates a distributed availability group replication mode.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    DistributedAvailabilityGroup,
    DistributedAvailabilityGroup
  >;

  /**
   * Drops a distributed availability group between Sql On-Prem and Sql Managed Instance.
   */
  delete is ArmResourceDeleteAsync<DistributedAvailabilityGroup>;

  /**
   * Gets a list of a distributed availability groups in instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DistributedAvailabilityGroups_ListByInstance")
  listByInstance is ArmResourceListByParent<DistributedAvailabilityGroup>;
}

@@projectedName(DistributedAvailabilityGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DistributedAvailabilityGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DistributedAvailabilityGroups.createOrUpdate::parameters.resource,
  "The distributed availability group info."
);
@@projectedName(DistributedAvailabilityGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DistributedAvailabilityGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DistributedAvailabilityGroups.update::parameters.properties,
  "The distributed availability group info."
);
