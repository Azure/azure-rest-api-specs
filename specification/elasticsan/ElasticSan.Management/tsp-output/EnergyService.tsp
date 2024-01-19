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

namespace Microsoft.OpenEnergyPlatform;

model EnergyService is TrackedResource<EnergyServiceProperties> {
  @doc("The resource name.")
  @path
  @key("resourceName")
  @segment("energyServices")
  name: string;
}

@armResourceOperations
interface EnergyServices {
  @doc("Returns oep resource for a given name.")
  get is ArmResourceRead<EnergyService>;

  @doc("Method that gets called if subscribed for ResourceCreationBegin trigger.")
  create is ArmResourceCreateOrUpdateAsync<
    EnergyService,
    BaseParameters<EnergyService>,
    ArmAsyncOperationHeader
  >;

  update is ArmCustomPatchSync<EnergyService, EnergyResourceUpdate>;

  @doc("Deletes oep resource")
  delete is ArmResourceDeleteAsync<EnergyService>;

  @doc("Returns list of oep resources..")
  listByResourceGroup is ArmResourceListByParent<EnergyService>;

  @doc("Lists a collection of oep resources under the given Azure Subscription ID.")
  listBySubscription is ArmListBySubscription<EnergyService>;

  @doc("Method that gets called if new partition is to be added in a resource.")
  addPartition is ArmResourceActionNoResponseContentAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest
  >;

  @doc("Method that gets called if new partition is to be removed from a resource.")
  removePartition is ArmResourceActionNoResponseContentAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest
  >;

  @doc("Method that gets called when list of partitions is requested.")
  listPartitions is ArmResourceActionSync<
    EnergyService,
    void,
    DataPartitionsListResult
  >;
}

@@projectedName(EnergyServices.create::parameters.resource, "json", "body");
@@extension(EnergyServices.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(EnergyServices.create::parameters.resource, "Request body.");
@@projectedName(EnergyServices.update::parameters.properties, "json", "body");
@@extension(EnergyServices.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(EnergyServices.update::parameters.properties, "");
@@doc(EnergyServices.addPartition::parameters.body,
  "add partition action payload"
);
@@doc(EnergyServices.removePartition::parameters.body,
  "remove partition action payload"
);
