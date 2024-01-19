import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DesktopVirtualization;

interface PrivateEndpointConnectionsOperations {
  @doc("List private endpoint connections associated with hostpool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections")
  @get
  listByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    },
    ResourceListResult<PrivateEndpointConnectionWithSystemData>
  >;

  @doc("Get a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  getByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnectionWithSystemData
  >;

  @doc("Remove a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  deleteByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("Approve or reject a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  updateByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @maxLength(64)
      @minLength(3)
      @path
      hostPoolName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("Object containing the updated connection.")
      @body
      connection: PrivateEndpointConnection;
    },
    PrivateEndpointConnectionWithSystemData
  >;
}
