import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace IotCentralClient;

interface AppsOperations {
  @doc("Get the metadata of an IoT Central application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;
    },
    App
  >;

  @doc("""
Create or update the metadata of an IoT Central application. The usual pattern
to modify a property is to retrieve the IoT Central application metadata and
security metadata, and then combine them with the modified values in a new body
to update the IoT Central application.
""")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [App]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;

      @doc("The IoT Central application metadata and security metadata.")
      @body
      App: App;
    },
    App
  >;

  @doc("Update the metadata of an IoT Central application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;

      @doc("The IoT Central application metadata and security metadata.")
      @body
      AppPatch: AppPatch;
    },
    void
  >;

  @doc("Delete an IoT Central application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("Get all IoT Central Applications in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.IoTCentral/iotApps")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    AppListResult
  >;

  @doc("Get all the IoT Central Applications in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;
    },
    AppListResult
  >;

  @doc("Check if an IoT Central application name is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.IoTCentral/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("""
Set the name parameter in the OperationInputs structure to the name of the IoT
Central application to check.
""")
      @body
      operationInputs: OperationInputs;
    },
    AppAvailabilityInfo
  >;

  @doc("Check if an IoT Central application subdomain is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.IoTCentral/checkSubdomainAvailability")
  @post
  CheckSubdomainAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("""
Set the name parameter in the OperationInputs structure to the subdomain of the
IoT Central application to check.
""")
      @body
      operationInputs: OperationInputs;
    },
    AppAvailabilityInfo
  >;

  @doc("Get all available application templates.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.IoTCentral/appTemplates")
  @post
  ListTemplates is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    AppTemplatesResult
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("""
Get the metadata of a private endpoint connection for the IoT Central
Application.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;

      @doc("The private endpoint connection name.")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("Update a private endpoint connection.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [PrivateEndpointConnection]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;

      @doc("The private endpoint connection name.")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection metadata.")
      @body
      PrivateEndpointConnection: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("Deletes a private endpoint connection from the IoT Central Application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;

      @doc("The private endpoint connection name.")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("Get all private endpoint connections of a IoT Central Application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;
    },
    PrivateEndpointConnectionListResult
  >;
}

interface PrivateLinksOperations {
  @doc("Get a private link resource of a IoT Central Application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}/privateLinkResources/{groupId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;

      @doc("The private link resource name.")
      @path
      groupId: string;
    },
    PrivateLinkResource
  >;

  @doc("Get all private link resources of a IoT Central Application.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTCentral/iotApps/{resourceName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT Central application.")
      @path
      resourceGroupName: string;

      @doc("The ARM resource name of the IoT Central application.")
      @path
      resourceName: string;
    },
    PrivateLinkResourceListResult
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available IoT Central Resource Provider operations.")
  @route("/providers/Microsoft.IoTCentral/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
