import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DesktopVirtualizationAPIClient;

interface OperationsOperations {
  @doc("""
List all of the available operations the Desktop Virtualization resource
provider supports.
""")
  @route("/providers/Microsoft.DesktopVirtualization/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, ResourceProviderOperationList>;
}

interface WorkspacesOperations {
  @doc("Get a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;
    },
    Workspace
  >;

  @doc("Create or update a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;

      @doc("Object containing Workspace definitions.")
      @body
      workspace: Workspace;
    },
    Workspace
  >;

  @doc("Remove a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;
    },
    void
  >;

  @doc("Update a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;

      @doc("Object containing Workspace definitions.")
      @body
      workspace: WorkspacePatch;
    },
    Workspace
  >;

  @doc("List workspaces.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    WorkspaceList
  >;

  @doc("List workspaces in subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DesktopVirtualization/workspaces")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    WorkspaceList
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("List private endpoint connections.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;
    },
    PrivateEndpointConnectionListResultWithSystemData
  >;

  @doc("Get a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  GetByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnectionWithSystemData
  >;

  @doc("Remove a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  DeleteByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("Approve or reject a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  UpdateByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("Object containing the updated connection.")
      @body
      connection: PrivateEndpointConnection;
    },
    PrivateEndpointConnectionWithSystemData
  >;

  @doc("List private endpoint connections associated with hostpool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    PrivateEndpointConnectionListResultWithSystemData
  >;

  @doc("Get a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  GetByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
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
  DeleteByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
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
  UpdateByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
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

interface PrivateLinkResourcesOperations {
  @doc("List the private link resources available for this workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateLinkResources")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace")
      @path
      workspaceName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    PrivateLinkResourceListResult
  >;

  @doc("List the private link resources available for this hostpool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateLinkResources")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    PrivateLinkResourceListResult
  >;
}

interface ScalingPlansOperations {
  @doc("Get a scaling plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;
    },
    ScalingPlan
  >;

  @doc("Create or update a scaling plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("Object containing scaling plan definitions.")
      @body
      scalingPlan: ScalingPlan;
    },
    ScalingPlan
  >;

  @doc("Remove a scaling plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;
    },
    void
  >;

  @doc("Update a scaling plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("Object containing scaling plan definitions.")
      @body
      scalingPlan: ScalingPlanPatch;
    },
    ScalingPlan
  >;

  @doc("List scaling plans.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ScalingPlanList
  >;

  @doc("List scaling plans in subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DesktopVirtualization/scalingPlans")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ScalingPlanList
  >;

  @doc("List scaling plan associated with hostpool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/scalingPlans")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ScalingPlanList
  >;
}

interface ScalingPlanPooledSchedulesOperations {
  @doc("Get a ScalingPlanPooledSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/pooledSchedules/{scalingPlanScheduleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;
    },
    ScalingPlanPooledSchedule
  >;

  @doc("Create or update a ScalingPlanPooledSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/pooledSchedules/{scalingPlanScheduleName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;

      @doc("Object containing ScalingPlanPooledSchedule definitions.")
      @body
      scalingPlanSchedule: ScalingPlanPooledSchedule;
    },
    ScalingPlanPooledSchedule
  >;

  @doc("Remove a ScalingPlanPooledSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/pooledSchedules/{scalingPlanScheduleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;
    },
    void
  >;

  @doc("Update a ScalingPlanPooledSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/pooledSchedules/{scalingPlanScheduleName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;

      @doc("Object containing ScalingPlanPooledSchedule definitions.")
      @body
      scalingPlanSchedule: ScalingPlanPooledSchedulePatch;
    },
    ScalingPlanPooledSchedule
  >;

  @doc("List ScalingPlanPooledSchedules.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/pooledSchedules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ScalingPlanPooledScheduleList
  >;
}

interface ScalingPlanPersonalSchedulesOperations {
  @doc("Get a ScalingPlanPersonalSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/personalSchedules/{scalingPlanScheduleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;
    },
    ScalingPlanPersonalSchedule
  >;

  @doc("Create or update a ScalingPlanPersonalSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/personalSchedules/{scalingPlanScheduleName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;

      @doc("Object containing ScalingPlanPersonalSchedule definitions.")
      @body
      scalingPlanSchedule: ScalingPlanPersonalSchedule;
    },
    ScalingPlanPersonalSchedule
  >;

  @doc("Remove a ScalingPlanPersonalSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/personalSchedules/{scalingPlanScheduleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;
    },
    void
  >;

  @doc("Update a ScalingPlanPersonalSchedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/personalSchedules/{scalingPlanScheduleName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("The name of the ScalingPlanSchedule")
      @path
      scalingPlanScheduleName: string;

      @doc("Object containing ScalingPlanPersonalSchedule definitions.")
      @body
      scalingPlanSchedule: ScalingPlanPersonalSchedulePatch;
    },
    ScalingPlanPersonalSchedule
  >;

  @doc("List ScalingPlanPersonalSchedules.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/scalingPlans/{scalingPlanName}/personalSchedules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the scaling plan.")
      @path
      scalingPlanName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ScalingPlanPersonalScheduleList
  >;
}

interface ApplicationGroupsOperations {
  @doc("Get an application group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;
    },
    ApplicationGroup
  >;

  @doc("Create or update an applicationGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("Object containing ApplicationGroup definitions.")
      @body
      applicationGroup: ApplicationGroup;
    },
    ApplicationGroup
  >;

  @doc("Remove an applicationGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;
    },
    void
  >;

  @doc("Update an applicationGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("Object containing ApplicationGroup definitions.")
      @body
      applicationGroup: ApplicationGroupPatch;
    },
    ApplicationGroup
  >;

  @doc("List applicationGroups.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
OData filter expression. Valid properties for filtering are
applicationGroupType.
""")
      @query
      $filter: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ApplicationGroupList
  >;

  @doc("List applicationGroups in subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DesktopVirtualization/applicationGroups")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("""
OData filter expression. Valid properties for filtering are
applicationGroupType.
""")
      @query
      $filter: string;
    },
    ApplicationGroupList
  >;
}

interface StartMenuItemsOperations {
  @doc("List start menu items in the given application group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/startMenuItems")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    StartMenuItemList
  >;
}

interface ApplicationsOperations {
  @doc("Get an application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/applications/{applicationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("The name of the application within the specified application group")
      @path
      applicationName: string;
    },
    Application
  >;

  @doc("Create or update an application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/applications/{applicationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("The name of the application within the specified application group")
      @path
      applicationName: string;

      @doc("Object containing Application definitions.")
      @body
      application: Application;
    },
    Application
  >;

  @doc("Remove an application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/applications/{applicationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("The name of the application within the specified application group")
      @path
      applicationName: string;
    },
    void
  >;

  @doc("Update an application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/applications/{applicationName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("The name of the application within the specified application group")
      @path
      applicationName: string;

      @doc("Object containing Application definitions.")
      @body
      application: ApplicationPatch;
    },
    Application
  >;

  @doc("List applications.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/applications")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    ApplicationList
  >;
}

interface DesktopsOperations {
  @doc("Get a desktop.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/desktops/{desktopName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("The name of the desktop within the specified desktop group")
      @path
      desktopName: string;
    },
    Desktop
  >;

  @doc("Update a desktop.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/desktops/{desktopName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("The name of the desktop within the specified desktop group")
      @path
      desktopName: string;

      @doc("Object containing Desktop definitions.")
      @body
      desktop: DesktopPatch;
    },
    Desktop
  >;

  @doc("List desktops.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/applicationGroups/{applicationGroupName}/desktops")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the application group")
      @path
      applicationGroupName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    DesktopList
  >;
}

interface HostPoolsOperations {
  @doc("Get a host pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;
    },
    HostPool
  >;

  @doc("Create or update a host pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Object containing HostPool definitions.")
      @body
      hostPool: HostPool;
    },
    HostPool
  >;

  @doc("Remove a host pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Force flag to delete sessionHost.")
      @query
      force: boolean;
    },
    void
  >;

  @doc("Update a host pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Object containing HostPool definitions.")
      @body
      hostPool: HostPoolPatch;
    },
    HostPool
  >;

  @doc("List hostPools.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    HostPoolList
  >;

  @doc("List hostPools in subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DesktopVirtualization/hostPools")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    HostPoolList
  >;

  @doc("Registration token of the host pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/retrieveRegistrationToken")
  @post
  RetrieveRegistrationToken is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;
    },
    RegistrationInfo
  >;
}

interface UserSessionsOperations {
  @doc("List userSessions.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/userSessions")
  @get
  ListByHostPool is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("""
OData filter expression. Valid properties for filtering are userprincipalname
and sessionstate.
""")
      @query
      $filter: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    UserSessionList
  >;

  @doc("Get a userSession.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}/userSessions/{userSessionId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("The name of the user session within the specified session host")
      @path
      userSessionId: string;
    },
    UserSession
  >;

  @doc("Remove a userSession.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}/userSessions/{userSessionId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("The name of the user session within the specified session host")
      @path
      userSessionId: string;

      @doc("Force flag to login off userSession.")
      @query
      force: boolean;
    },
    void
  >;

  @doc("List userSessions.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}/userSessions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    UserSessionList
  >;

  @doc("Disconnect a userSession.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}/userSessions/{userSessionId}/disconnect")
  @post
  Disconnect is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("The name of the user session within the specified session host")
      @path
      userSessionId: string;
    },
    void
  >;

  @doc("Send a message to a user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}/userSessions/{userSessionId}/sendMessage")
  @post
  SendMessage is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("The name of the user session within the specified session host")
      @path
      userSessionId: string;

      @doc("Object containing message includes title and message body")
      @body
      sendMessage: SendMessage;
    },
    void
  >;
}

interface SessionHostsOperations {
  @doc("Get a session host.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;
    },
    SessionHost
  >;

  @doc("Remove a SessionHost.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("Force flag to force sessionHost deletion even when userSession exists.")
      @query
      force: boolean;
    },
    void
  >;

  @doc("Update a session host.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts/{sessionHostName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("The name of the session host within the specified host pool")
      @path
      sessionHostName: string;

      @doc("Force flag to update assign, unassign or reassign personal desktop.")
      @query
      force: boolean;

      @doc("Object containing SessionHost definitions.")
      @body
      sessionHost: SessionHostPatch;
    },
    SessionHost
  >;

  @doc("List sessionHosts.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHosts")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    SessionHostList
  >;
}

interface MSIXPackagesOperations {
  @doc("Get a msixpackage.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/msixPackages/{msixPackageFullName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("""
The version specific package full name of the MSIX package within specified
hostpool
""")
      @path
      msixPackageFullName: string;
    },
    MsixPackage
  >;

  @doc("Create or update a MSIX package.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/msixPackages/{msixPackageFullName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("""
The version specific package full name of the MSIX package within specified
hostpool
""")
      @path
      msixPackageFullName: string;

      @doc("Object containing  MSIX Package definitions.")
      @body
      msixPackage: MsixPackage;
    },
    MsixPackage
  >;

  @doc("Remove an MSIX Package.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/msixPackages/{msixPackageFullName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("""
The version specific package full name of the MSIX package within specified
hostpool
""")
      @path
      msixPackageFullName: string;
    },
    void
  >;

  @doc("Update an  MSIX Package.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/msixPackages/{msixPackageFullName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("""
The version specific package full name of the MSIX package within specified
hostpool
""")
      @path
      msixPackageFullName: string;

      @doc("Object containing MSIX Package definitions.")
      @body
      msixPackage: MsixPackagePatch;
    },
    MsixPackage
  >;

  @doc("List MSIX packages in hostpool.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/msixPackages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Number of items per page.")
      @query
      pageSize: int32;

      @doc("Indicates whether the collection is descending.")
      @query
      isDescending: boolean;

      @doc("Initial number of items to skip.")
      @query
      initialSkip: int32;
    },
    MsixPackageList
  >;
}

interface MsixImagesOperations {
  @doc("Expands and Lists MSIX packages in an Image, given the Image Path.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/expandMsixImage")
  @post
  Expand is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the host pool within the specified resource group")
      @path
      hostPoolName: string;

      @doc("Object containing URI to MSIX Image")
      @body
      msixImageURI: MsixImageURI;
    },
    ExpandMsixImageList
  >;
}
