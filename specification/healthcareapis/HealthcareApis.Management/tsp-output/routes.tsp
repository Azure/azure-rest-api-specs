import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace HealthcareApisManagementClient;

interface ServicesOperations {
  @doc("Get the metadata of a service instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;
    },
    ServicesDescription
  >;

  @doc("Create or update the metadata of a service instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;

      @doc("The service instance metadata.")
      @body
      serviceDescription: ServicesDescription;
    },
    ServicesDescription
  >;

  @doc("Update the metadata of a service instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;

      @doc("The service instance metadata and security metadata.")
      @body
      servicePatchDescription: ServicesPatchDescription;
    },
    ServicesDescription
  >;

  @doc("Delete a service instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("Get all the service instances in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HealthcareApis/services")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    ServicesDescriptionListResult
  >;

  @doc("Get all the service instances in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;
    },
    ServicesDescriptionListResult
  >;

  @doc("Check if a service instance name is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HealthcareApis/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("""
Set the name parameter in the CheckNameAvailabilityParameters structure to the
name of the service instance to check.
""")
      @body
      checkNameAvailabilityInputs: CheckNameAvailabilityParameters;
    },
    ServicesNameAvailabilityInfo
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("Lists all private endpoint connections for a service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}/privateEndpointConnections")
  @get
  ListByService is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;
    },
    PrivateEndpointConnectionListResultDescription
  >;

  @doc("Gets the specified private endpoint connection associated with the service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnectionDescription
  >;

  @doc("""
Update the state of the specified private endpoint connection associated with
the service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection properties.")
      @body
      properties: PrivateEndpointConnection;
    },
    PrivateEndpointConnectionDescription
  >;

  @doc("Deletes a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Gets the private link resources that need to be created for a service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}/privateLinkResources")
  @get
  ListByService is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;
    },
    PrivateLinkResourceListResultDescription
  >;

  @doc("Gets a private link resource that need to be created for a service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/services/{resourceName}/privateLinkResources/{groupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of the service instance.")
      @path
      resourceName: string;

      @doc("The name of the private link resource group.")
      @path
      groupName: string;
    },
    PrivateLinkResourceDescription
  >;
}

interface WorkspacesOperations {
  @doc("Lists all the available workspaces under the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HealthcareApis/workspaces")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    WorkspaceList
  >;

  @doc("Lists all the available workspaces under the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;
    },
    WorkspaceList
  >;

  @doc("Gets the properties of the specified workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    Workspace
  >;

  @doc("Creates or updates a workspace resource with the specified parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The parameters for creating or updating a healthcare workspace.")
      @body
      workspace: Workspace;
    },
    Workspace
  >;

  @doc("Patch workspace details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The parameters for updating a specified workspace.")
      @body
      workspacePatchResource: WorkspacePatchResource;
    },
    Workspace
  >;

  @doc("Deletes a specified workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    void
  >;
}

interface DicomServicesOperations {
  @doc("Lists all DICOM Services for the given workspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    DicomServiceCollection
  >;

  @doc("Gets the properties of the specified DICOM Service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices/{dicomServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of DICOM Service resource.")
      @path
      dicomServiceName: string;
    },
    DicomService
  >;

  @doc("Creates or updates a DICOM Service resource with the specified parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices/{dicomServiceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of DICOM Service resource.")
      @path
      dicomServiceName: string;

      @doc("The parameters for creating or updating a Dicom Service resource.")
      @body
      dicomservice: DicomService;
    },
    DicomService
  >;

  @doc("Patch DICOM Service details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices/{dicomServiceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of DICOM Service resource.")
      @path
      dicomServiceName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The parameters for updating a Dicom Service.")
      @body
      dicomservicePatchResource: DicomServicePatchResource;
    },
    DicomService
  >;

  @doc("Deletes a DICOM Service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices/{dicomServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of DICOM Service resource.")
      @path
      dicomServiceName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    void
  >;
}

interface IotConnectorsOperations {
  @doc("Lists all IoT Connectors for the given workspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    IotConnectorCollection
  >;

  @doc("Gets the properties of the specified IoT Connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;
    },
    IotConnector
  >;

  @doc("Creates or updates an IoT Connector resource with the specified parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;

      @doc("The parameters for creating or updating an IoT Connectors resource.")
      @body
      iotConnector: IotConnector;
    },
    IotConnector
  >;

  @doc("Patch an IoT Connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The parameters for updating an IoT Connector.")
      @body
      iotConnectorPatchResource: IotConnectorPatchResource;
    },
    IotConnector
  >;

  @doc("Deletes an IoT Connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    void
  >;
}

interface FhirDestinationsOperations {
  @doc("Lists all FHIR destinations for the given IoT Connector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}/fhirdestinations")
  @get
  ListByIotConnector is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;
    },
    IotFhirDestinationCollection
  >;
}

interface IotConnectorFhirDestinationOperations {
  @doc("Gets the properties of the specified Iot Connector FHIR destination.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}/fhirdestinations/{fhirDestinationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;

      @doc("The name of IoT Connector FHIR destination resource.")
      @path
      fhirDestinationName: string;
    },
    IotFhirDestination
  >;

  @doc("""
Creates or updates an IoT Connector FHIR destination resource with the
specified parameters.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}/fhirdestinations/{fhirDestinationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;

      @doc("The name of IoT Connector FHIR destination resource.")
      @path
      fhirDestinationName: string;

      @doc("""
The parameters for creating or updating an IoT Connector FHIR destination
resource.
""")
      @body
      iotFhirDestination: IotFhirDestination;
    },
    IotFhirDestination
  >;

  @doc("Deletes an IoT Connector FHIR destination.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}/fhirdestinations/{fhirDestinationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of IoT Connector resource.")
      @path
      iotConnectorName: string;

      @doc("The name of IoT Connector FHIR destination resource.")
      @path
      fhirDestinationName: string;
    },
    void
  >;
}

interface FhirServicesOperations {
  @doc("Lists all FHIR Services for the given workspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    FhirServiceCollection
  >;

  @doc("Gets the properties of the specified FHIR Service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices/{fhirServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of FHIR Service resource.")
      @path
      fhirServiceName: string;
    },
    FhirService
  >;

  @doc("Creates or updates a FHIR Service resource with the specified parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices/{fhirServiceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of FHIR Service resource.")
      @path
      fhirServiceName: string;

      @doc("The parameters for creating or updating a Fhir Service resource.")
      @body
      fhirservice: FhirService;
    },
    FhirService
  >;

  @doc("Patch FHIR Service details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices/{fhirServiceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of FHIR Service resource.")
      @path
      fhirServiceName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The parameters for updating a Fhir Service.")
      @body
      fhirservicePatchResource: FhirServicePatchResource;
    },
    FhirService
  >;

  @doc("Deletes a FHIR Service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices/{fhirServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of FHIR Service resource.")
      @path
      fhirServiceName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    void
  >;
}

interface WorkspacePrivateEndpointConnectionsOperations {
  @doc("Lists all private endpoint connections for a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    PrivateEndpointConnectionListResultDescription
  >;

  @doc("Gets the specified private endpoint connection associated with the workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnectionDescription
  >;

  @doc("""
Update the state of the specified private endpoint connection associated with
the workspace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection properties.")
      @body
      properties: PrivateEndpointConnectionDescription;
    },
    PrivateEndpointConnectionDescription
  >;

  @doc("Deletes a private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}

interface WorkspacePrivateLinkResourcesOperations {
  @doc("Gets the private link resources that need to be created for a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateLinkResources")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;
    },
    PrivateLinkResourceListResultDescription
  >;

  @doc("Gets a private link resource that need to be created for a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/privateLinkResources/{groupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the service instance.")
      @path
      resourceGroupName: string;

      @doc("The name of workspace resource.")
      @path
      workspaceName: string;

      @doc("The name of the private link resource group.")
      @path
      groupName: string;
    },
    PrivateLinkResourceDescription
  >;
}

interface OperationsOperations {
  @doc("""
Lists all of the available operations supported by Microsoft Healthcare
resource provider.
""")
  @route("/providers/Microsoft.HealthcareApis/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, ListOperations>;
}

interface OperationResultsOperations {
  @doc("Get the operation result for a long running operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HealthcareApis/locations/{locationName}/operationresults/{operationResultId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The location of the operation.")
      @path
      locationName: string;

      @doc("The ID of the operation result to get.")
      @path
      operationResultId: string;
    },
    OperationResultsDescription
  >;
}
