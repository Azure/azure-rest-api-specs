import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DevCenter;

interface AttachedNetworksOperations {
  /**
   * Lists the attached NetworkConnections for a DevCenter.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks")
  @get
  listByDevCenter is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the devcenter.
       */
      @path
      devCenterName: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    ResourceListResult<AttachedNetworkConnection>
  >;

  /**
   * Gets an attached NetworkConnection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}")
  @get
  getByDevCenter is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the devcenter.
       */
      @path
      devCenterName: string;

      /**
       * The name of the attached NetworkConnection.
       */
      @path
      attachedNetworkConnectionName: string;
    },
    AttachedNetworkConnection
  >;

  /**
   * Creates or updates an attached NetworkConnection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}")
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
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the devcenter.
       */
      @path
      devCenterName: string;

      /**
       * The name of the attached NetworkConnection.
       */
      @path
      attachedNetworkConnectionName: string;

      /**
       * Represents an attached NetworkConnection.
       */
      @body
      body: AttachedNetworkConnection;
    },
    AttachedNetworkConnection
  >;

  /**
   * Un-attach a NetworkConnection.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}")
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
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the devcenter.
       */
      @path
      devCenterName: string;

      /**
       * The name of the attached NetworkConnection.
       */
      @path
      attachedNetworkConnectionName: string;
    },
    void
  >;
}

interface DevBoxDefinitionsOperations {
  /**
   * List Dev Box definitions configured for a project.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/projects/{projectName}/devboxdefinitions")
  @get
  listByProject is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the project.
       */
      @path
      projectName: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    ResourceListResult<DevBoxDefinition>
  >;

  /**
   * Gets a Dev Box definition configured for a project
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/projects/{projectName}/devboxdefinitions/{devBoxDefinitionName}")
  @get
  getByProject is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the project.
       */
      @path
      projectName: string;

      /**
       * The name of the Dev Box definition.
       */
      @path
      devBoxDefinitionName: string;
    },
    DevBoxDefinition
  >;
}

interface OperationStatusesOperations {
  /**
   * Gets the current status of an async operation.
   */
  @summary("Get Operation Status")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}")
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
       * The Azure region
       */
      @path
      location: string;

      /**
       * The ID of an ongoing async operation
       */
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

interface UsagesOperations {
  /**
   * Lists the current usages and limits in this location for the provided subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/locations/{location}/usages")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The Azure region
       */
      @path
      location: string;
    },
    ListUsagesResult
  >;
}

interface CheckNameAvailabilityOperations {
  /**
   * Check the availability of name for resource
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/checkNameAvailability")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The required parameters for checking if resource name is available.
       */
      @body
      nameAvailabilityRequest: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface SkusOperations {
  /**
   * Lists the Microsoft.DevCenter SKUs available in a subscription
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/skus")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    SkuListResult
  >;
}
