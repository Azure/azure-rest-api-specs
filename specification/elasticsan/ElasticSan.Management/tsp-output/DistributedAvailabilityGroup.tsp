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
@doc("Distributed availability group between box and Sql Managed Instance.")
@parentResource(ManagedInstance)
model DistributedAvailabilityGroup
  is ProxyResource<DistributedAvailabilityGroupProperties> {
  @doc("The distributed availability group name.")
  @path
  @key("distributedAvailabilityGroupName")
  @segment("distributedAvailabilityGroups")
  name: string;
}

@armResourceOperations
interface DistributedAvailabilityGroups {
  @doc("Gets a distributed availability group info.")
  get is ArmResourceRead<DistributedAvailabilityGroup>;

  @doc("Creates a distributed availability group between Sql On-Prem and Sql Managed Instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DistributedAvailabilityGroup>;

  @doc("Updates a distributed availability group replication mode.")
  update is ArmCustomPatchAsync<
    DistributedAvailabilityGroup,
    DistributedAvailabilityGroup
  >;

  @doc("Drops a distributed availability group between Sql On-Prem and Sql Managed Instance.")
  delete is ArmResourceDeleteAsync<DistributedAvailabilityGroup>;

  @doc("Gets a list of a distributed availability groups in instance.")
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
