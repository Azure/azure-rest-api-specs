import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop OneLake connector resource to capture the configuration pertaining to an existing OneLake instance.")
@resource("oneLakeConnectors")
model OneLakeConnector is TrackedResource<OneLakeConnectorProperties> {
  @doc("The name of the OneLake connector resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("oneLakeConnectorName")
  @segment("oneLakeConnectors")
  @path
  name: string;
}

@doc("The properties to configure the OneLakeConnector resource.")
model OneLakeConnectorProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this oneLakeConnector resource to.")
  hubResourceId: HubResourceId;

  @doc("Optional string to specify the host of the Microsoft Fabric instance in the form of https://<host>.fabric.microsoft.com. By default, the host https://onelake.dfs.fabric.microsoft.com/ will be used.")
  @pattern(".+\\.fabric\\.microsoft\\.com")
  host?: url;

  @doc("GUID of the lakehouse to connect to.")
  lakehouseId: string;

  @doc("GUID of the workspace to connect to.")
  workspaceId: string;

  @doc("Optional string to specify the folder path to use when reading/writing the files from/to a lakehouse. If not specified, the root of the lakehouse file directory will be used.")
  folderPath?: string;
}

@armResourceOperations
interface OneLakeConnectors {
  get is ArmResourceRead<OneLakeConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OneLakeConnector>;
  update is ArmResourcePatchAsync<OneLakeConnector, OneLakeConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<OneLakeConnector>;
  listByResourceGroup is ArmResourceListByParent<OneLakeConnector>;
  listBySubscription is ArmListBySubscription<OneLakeConnector>;
}
