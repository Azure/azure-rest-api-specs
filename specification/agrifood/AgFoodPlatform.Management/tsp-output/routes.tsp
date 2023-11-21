import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureAgFoodPlatformRPService;

interface ExtensionsOperations {
  @doc("Install extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/extensions/{extensionId}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Id of extension resource.")
      @path
      extensionId: string;
    },
    Extension
  >;

  @doc("Get installed extension details by extension id.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/extensions/{extensionId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Id of extension resource.")
      @path
      extensionId: string;
    },
    Extension
  >;

  @doc("Upgrade to latest extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/extensions/{extensionId}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Id of extension resource.")
      @path
      extensionId: string;
    },
    Extension
  >;

  @doc("Uninstall extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/extensions/{extensionId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Id of extension resource.")
      @path
      extensionId: string;
    },
    void
  >;

  @doc("Get installed extensions details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/extensions")
  @get
  ListByFarmBeats is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Installed extension ids.")
      @query
      extensionIds: string[];

      @doc("Installed extension categories.")
      @query
      extensionCategories: string[];

      @doc("""
Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000,
Default value = 50.
""")
      @query
      $maxPageSize: int32;

      @doc("Skip token for getting next set of results.")
      @query
      $skipToken: string;
    },
    ExtensionListResponse
  >;
}

interface FarmBeatsExtensionsOperations {
  @doc("Get list of farmBeats extension.")
  @route("/providers/Microsoft.AgFoodPlatform/farmBeatsExtensionDefinitions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("FarmBeatsExtension ids.")
      @query
      farmBeatsExtensionIds: string[];

      @doc("FarmBeats extension names.")
      @query
      farmBeatsExtensionNames: string[];

      @doc("Extension categories.")
      @query
      extensionCategories: string[];

      @doc("Publisher ids.")
      @query
      publisherIds: string[];

      @doc("""
Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000,
Default value = 50.
""")
      @query
      $maxPageSize: int32;
    },
    FarmBeatsExtensionListResponse
  >;

  @doc("Get farmBeats extension.")
  @route("/providers/Microsoft.AgFoodPlatform/farmBeatsExtensionDefinitions/{farmBeatsExtensionId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("farmBeatsExtensionId to be queried.")
      @path
      farmBeatsExtensionId: string;
    },
    FarmBeatsExtension
  >;
}

interface FarmBeatsModelsOperations {
  @doc("Get FarmBeats resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;
    },
    FarmBeats
  >;

  @doc("Create or update FarmBeats resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("FarmBeats resource create or update request object.")
      @body
      body: FarmBeats;
    },
    FarmBeats
  >;

  @doc("Update a FarmBeats resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Request object.")
      @body
      body: FarmBeatsUpdateRequestModel;
    },
    FarmBeats | void
  >;

  @doc("Delete a FarmBeats resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;
    },
    void
  >;

  @doc("Lists the FarmBeats instances for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AgFoodPlatform/farmBeats")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000,
Default value = 50.
""")
      @query
      $maxPageSize: int32;

      @doc("Skip token for getting next set of results.")
      @query
      $skipToken: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    FarmBeatsListResponse
  >;

  @doc("Lists the FarmBeats instances for a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Maximum number of items needed (inclusive).
Minimum = 10, Maximum = 1000,
Default value = 50.
""")
      @query
      $maxPageSize: int32;

      @doc("Continuation token for getting next set of results.")
      @query
      $skipToken: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    FarmBeatsListResponse
  >;

  @doc("Get operationResults for a FarmBeats resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/operationResults/{operationResultsId}")
  @get
  GetOperationResult is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("The operation results id.")
      @path
      operationResultsId: string;
    },
    ArmAsyncOperation
  >;
}

interface LocationsOperations {
  @doc("Checks the name availability of the resource with requested resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AgFoodPlatform/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("NameAvailabilityRequest object.")
      @body
      body: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface OperationsOperations {
  @doc("Lists the available operations of Microsoft.AgFoodPlatform resource provider.")
  @route("/providers/Microsoft.AgFoodPlatform/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface PrivateEndpointConnectionsOperations {
  @doc("Approves or Rejects a Private endpoint connection request.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Private endpoint connection name.")
      @path
      privateEndpointConnectionName: string;

      @doc("Request object.")
      @body
      body: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("Get Private endpoint connection object.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Private endpoint connection name.")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("Delete Private endpoint connection request.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Private endpoint connection name.")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("Get list of Private endpoint connections.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/privateEndpointConnections")
  @get
  ListByResource is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;
    },
    PrivateEndpointConnectionListResult
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Get list of Private link resources.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/privateLinkResources")
  @get
  ListByResource is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;
    },
    PrivateLinkResourceListResult
  >;

  @doc("Get Private link resource object.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AgFoodPlatform/farmBeats/{farmBeatsResourceName}/privateLinkResources/{subResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("FarmBeats resource name.")
      @path
      farmBeatsResourceName: string;

      @doc("Sub resource name.")
      @path
      subResourceName: string;
    },
    PrivateLinkResource
  >;
}
