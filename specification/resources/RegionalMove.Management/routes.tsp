import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";

using Azure.ResourceManager;

namespace RegionalMoveClient;

@armResourceOperations
interface RegionalMoveContainers {
  get is ArmResourceRead<RegionalMoveContainer>;

  listBySubscription is ArmListBySubscription<RegionalMoveContainer>;

  listByResourceGroup is ArmResourceListByParent<RegionalMoveContainer>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<RegionalMoveContainer>;

  update is ArmTagsPatchSync<RegionalMoveContainer>;

  delete is ArmResourceDeleteSync<RegionalMoveContainer>;
}
