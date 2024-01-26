import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HealthcareApis;

interface WorkspacePrivateEndpointConnectionsOperations {
  /**
   * Lists all private endpoint connections for a workspace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections")
  @get
  listByWorkspace is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the service instance.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of workspace resource.
       */
      @maxLength(24)
      @minLength(3)
      @path
      workspaceName: string;
    },
    ResourceListResult<PrivateEndpointConnectionDescription>
  >;

  /**
   * Gets the specified private endpoint connection associated with the workspace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the service instance.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of workspace resource.
       */
      @maxLength(24)
      @minLength(3)
      @path
      workspaceName: string;

      /**
       * The name of the private endpoint connection associated with the Azure resource
       */
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnectionDescription
  >;

  /**
   * Update the state of the specified private endpoint connection associated with the workspace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the service instance.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of workspace resource.
       */
      @maxLength(24)
      @minLength(3)
      @path
      workspaceName: string;

      /**
       * The name of the private endpoint connection associated with the Azure resource
       */
      @path
      privateEndpointConnectionName: string;

      /**
       * The private endpoint connection properties.
       */
      @body
      properties: PrivateEndpointConnectionDescription;
    },
    PrivateEndpointConnectionDescription
  >;

  /**
   * Deletes a private endpoint connection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the service instance.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of workspace resource.
       */
      @maxLength(24)
      @minLength(3)
      @path
      workspaceName: string;

      /**
       * The name of the private endpoint connection associated with the Azure resource
       */
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}

interface WorkspacePrivateLinkResourcesOperations {
  /**
   * Gets the private link resources that need to be created for a workspace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateLinkResources")
  @get
  listByWorkspace is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the service instance.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of workspace resource.
       */
      @maxLength(24)
      @minLength(3)
      @path
      workspaceName: string;
    },
    ResourceListResult<PrivateLinkResourceDescription>
  >;

  /**
   * Gets a private link resource that need to be created for a workspace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateLinkResources/{groupName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the service instance.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of workspace resource.
       */
      @maxLength(24)
      @minLength(3)
      @path
      workspaceName: string;

      /**
       * The name of the private link resource group.
       */
      @path
      groupName: string;
    },
    PrivateLinkResourceDescription
  >;
}
