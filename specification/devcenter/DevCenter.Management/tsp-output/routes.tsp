import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DevCenter;

interface AttachedNetworksOperations {
  @doc("Lists the attached NetworkConnections for a DevCenter.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks")
  @get
  listByDevCenter is Azure.Core.Foundations.Operation<
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

      @doc("The name of the devcenter.")
      @path
      devCenterName: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    ResourceListResult<AttachedNetworkConnection>
  >;

  @doc("Gets an attached NetworkConnection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}")
  @get
  getByDevCenter is Azure.Core.Foundations.Operation<
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

      @doc("The name of the devcenter.")
      @path
      devCenterName: string;

      @doc("The name of the attached NetworkConnection.")
      @path
      attachedNetworkConnectionName: string;
    },
    AttachedNetworkConnection
  >;

  @doc("Creates or updates an attached NetworkConnection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
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

      @doc("The name of the devcenter.")
      @path
      devCenterName: string;

      @doc("The name of the attached NetworkConnection.")
      @path
      attachedNetworkConnectionName: string;

      @doc("Represents an attached NetworkConnection.")
      @body
      body: AttachedNetworkConnection;
    },
    AttachedNetworkConnection
  >;

  @doc("Un-attach a NetworkConnection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
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

      @doc("The name of the devcenter.")
      @path
      devCenterName: string;

      @doc("The name of the attached NetworkConnection.")
      @path
      attachedNetworkConnectionName: string;
    },
    void
  >;
}

interface DevBoxDefinitionsOperations {
  @doc("List Dev Box definitions configured for a project.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/projects/{projectName}/devboxdefinitions")
  @get
  listByProject is Azure.Core.Foundations.Operation<
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

      @doc("The name of the project.")
      @path
      projectName: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    ResourceListResult<DevBoxDefinition>
  >;

  @doc("Gets a Dev Box definition configured for a project")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/projects/{projectName}/devboxdefinitions/{devBoxDefinitionName}")
  @get
  getByProject is Azure.Core.Foundations.Operation<
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

      @doc("The name of the project.")
      @path
      projectName: string;

      @doc("The name of the Dev Box definition.")
      @path
      devBoxDefinitionName: string;
    },
    DevBoxDefinition
  >;
}

interface OperationStatusesOperations {
  @summary("Get Operation Status")
  @doc("Gets the current status of an async operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The Azure region")
      @path
      location: string;

      @doc("The ID of an ongoing async operation")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface UsagesOperations {
  @doc("Lists the current usages and limits in this location for the provided subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/locations/{location}/usages")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The Azure region")
      @path
      location: string;
    },
    ListUsagesResult
  >;
}

interface CheckNameAvailabilityOperations {
  @doc("Check the availability of name for resource")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/checkNameAvailability")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The required parameters for checking if resource name is available.")
      @body
      nameAvailabilityRequest: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface SkusOperations {
  @doc("Lists the Microsoft.DevCenter SKUs available in a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/skus")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    SkuListResult
  >;
}
