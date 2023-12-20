import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotCentral;
@doc("The IoT Central application.")
model IotCentralApp is TrackedResource<AppProperties> {
  @doc("The ARM resource name of the IoT Central application.")
  @path
  @key("resourceName")
  @segment("iotApps")
  name: string;

  ...Azure.ResourceManager.ManagedSystemAssignedIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface IotCentralApps {
  @doc("Get the metadata of an IoT Central application.")
  get is ArmResourceRead<IotCentralApp>;
  @doc("Create or update the metadata of an IoT Central application. The usual pattern to modify a property is to retrieve the IoT Central application metadata and security metadata, and then combine them with the modified values in a new body to update the IoT Central application.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IotCentralApp>;
  @doc("Update the metadata of an IoT Central application.")
  update is ArmResourcePatchAsync<IotCentralApp, AppProperties>;
  @doc("Delete an IoT Central application.")
  delete is ArmResourceDeleteWithoutOkAsync<IotCentralApp>;
  @doc("Get all the IoT Central Applications in a resource group.")
  listByResourceGroup is ArmResourceListByParent<IotCentralApp>;
  @doc("Get all IoT Central Applications in a subscription.")
  listBySubscription is ArmListBySubscription<IotCentralApp>;
  @doc("Get all available application templates.")
  listTemplates is ArmListBySubscription<IotCentralApp>;
}
