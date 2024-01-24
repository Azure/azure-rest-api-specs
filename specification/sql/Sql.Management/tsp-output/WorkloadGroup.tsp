import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Workload group operations for a data warehouse
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Database)
@Azure.ResourceManager.Private.armResourceInternal(WorkloadGroupProperties)
@includeInapplicableMetadataInPayload(false)
model WorkloadGroup extends ProxyResource {
  /**
   * The name of the workload group.
   */
  @path
  @key("workloadGroupName")
  @segment("workloadGroups")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadGroupProperties;
}

@armResourceOperations
interface WorkloadGroups {
  /**
   * Gets a workload group
   */
  get is ArmResourceRead<WorkloadGroup>;

  /**
   * Creates or updates a workload group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkloadGroup>;

  /**
   * Deletes a workload group.
   */
  delete is ArmResourceDeleteAsync<WorkloadGroup>;

  /**
   * Gets the list of workload groups
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadGroups_ListByDatabase")
  listByDatabase is ArmResourceListByParent<WorkloadGroup>;
}

@@projectedName(WorkloadGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WorkloadGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WorkloadGroups.createOrUpdate::parameters.resource,
  "The requested workload group state."
);
