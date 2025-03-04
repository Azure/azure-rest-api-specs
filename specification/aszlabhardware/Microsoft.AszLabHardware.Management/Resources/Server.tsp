import "../Models/ResourceManager.tsp";
import "../Models/UserLabResourceTypes.tsp";
import "../Models/System.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AszLabHardware;

@doc("A Server object which will be connected to a LabServer upon successful reservation")
model Server is TrackedResource<ServerProperties> {
  @doc("The name of the Server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("serverName")
  @segment("servers")
  @path
  name: string;
}

@doc("Details of the AszLabHw Server.")
model ServerProperties {
  @visibility(Lifecycle.Read)
  @doc("The current status of the GoalState")
  resourceManager?: ResourceManager;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  @doc("User name of the account credential to authenticate to the server.")
  userName?: string;

  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  @doc("Keyvault Uri for the password of the account credential to authenticate to the server.")
  userPasswordKeyVaultUri?: url;

  @visibility(Lifecycle.Read)
  @doc("Server association with LabServer status.")
  associationStatus?: UserLabResourceAssociationStatus;

  @visibility(Lifecycle.Read)
  @doc("IP address of the associated LabServer's BMC.")
  bmcIpAddress?: string;

  @visibility(Lifecycle.Read)
  @doc("Inventory Information of the associated LabServer.")
  inventory?: System;

  @visibility(Lifecycle.Read)
  @doc("Maintenance status of the associated LabServer.")
  maintenanceStatus?: UserLabResourceMaintenanceStatus;
}

@armResourceOperations
interface Servers {
  get is ArmResourceRead<Server>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Server>;
  update is ArmCustomPatchAsync<
    Server,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Server,
      ServerProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Server>;
  listByResourceGroup is ArmResourceListByParent<Server>;
  listBySubscription is ArmListBySubscription<Server>;
  @doc("Allows any requested maintenance on this Server")
  allowMaintenance is ArmResourceActionSync<Server, void, void>;
}

scalar ServerResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AszLabHardware/servers",
    }
  ]>;
