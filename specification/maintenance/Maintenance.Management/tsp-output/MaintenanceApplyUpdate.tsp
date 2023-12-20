import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Maintenance;
@doc("Apply Update request")
model MaintenanceApplyUpdate is ProxyResource<ApplyUpdateProperties> {
  @doc("applyUpdate Id")
  @path
  @key("applyUpdateName")
  @segment("applyUpdates")
  name: string;
}

@armResourceOperations
interface MaintenanceApplyUpdates {
  @doc("Track maintenance updates to resource")
  get is ArmResourceRead<MaintenanceApplyUpdate>;
  @doc("Apply maintenance updates to resource")
  createOrUpdateOrCancel is ArmResourceCreateOrReplaceSync<MaintenanceApplyUpdate>;
  @doc("Get Configuration records within a subscription")
  list is ArmListBySubscription<MaintenanceApplyUpdate>;
}
