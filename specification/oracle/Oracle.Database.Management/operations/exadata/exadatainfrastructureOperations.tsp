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
  @Autorest.example(
    "./examples/exaInfra_addStorageCapacity.json",
    "Perform add storage capacity on exadata infra"
  )
  addStorageCapacity is ArmResourceActionAsync<
    CloudExadataInfrastructure,
    void,
    CloudExadataInfrastructure
  >;
}

@@Autorest.example(CloudExadataInfrastructures.listBySubscription,
  "./examples/exaInfra_listBySubscription.json",
  "List Exadata Infrastructure by subscription"
);
@@Autorest.example(CloudExadataInfrastructures.listByResourceGroup,
  "./examples/exaInfra_listByResourceGroup.json",
  "List Exadata Infrastructure by resource group"
);
@@Autorest.example(CloudExadataInfrastructures.createOrUpdate,
  "./examples/exaInfra_create.json",
  "Create Exadata Infrastructure"
);
@@Autorest.example(CloudExadataInfrastructures.get,
  "./examples/exaInfra_get.json",
  "Get Exadata Infrastructure"
);
@@Autorest.example(CloudExadataInfrastructures.update,
  "./examples/exaInfra_patch.json",
  "Patch Exadata Infrastructure"
);
@@Autorest.example(CloudExadataInfrastructures.delete,
  "./examples/exaInfra_delete.json",
  "Delete Exadata Infrastructure"
);
