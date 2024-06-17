import "../commons.tsp";
import "../../../models/exadata/exadatainfra.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations(CloudExadataInfrastructure)
interface CloudExadataInfrastructures
  extends OracleTrackedResource<
      CloudExadataInfrastructure,
      CloudExadataInfrastructureProperties
    > {
  //OCI addStorageCapacityCloudExadataInfrastructure API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/CloudExadataInfrastructure/AddStorageCapacityCloudExadataInfrastructure
  @doc("Perform add storage capacity on exadata infra")
  @example(
    "./examples/exaInfra_addStorageCapacity.json",
    "Perform add storage capacity on exadata infra"
  )
  addStorageCapacity is ArmResourceActionAsync<
    CloudExadataInfrastructure,
    void,
    CloudExadataInfrastructure
  >;
}

@@example(CloudExadataInfrastructures.listBySubscription,
  "./examples/exaInfra_listBySubscription.json",
  "List Exadata Infrastructure by subscription"
);
@@example(CloudExadataInfrastructures.listByResourceGroup,
  "./examples/exaInfra_listByResourceGroup.json",
  "List Exadata Infrastructure by resource group"
);
@@example(CloudExadataInfrastructures.createOrUpdate,
  "./examples/exaInfra_create.json",
  "Create Exadata Infrastructure"
);
@@example(CloudExadataInfrastructures.get,
  "./examples/exaInfra_get.json",
  "Get Exadata Infrastructure"
);
@@example(CloudExadataInfrastructures.update,
  "./examples/exaInfra_patch.json",
  "Patch Exadata Infrastructure"
);
@@example(CloudExadataInfrastructures.delete,
  "./examples/exaInfra_delete.json",
  "Delete Exadata Infrastructure"
);
