import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AttestationManagementClient;

interface OperationsOperations {
  @doc("Lists all of the available Azure attestation operations.")
  @route("/providers/Microsoft.Attestation/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}

interface AttestationProvidersOperations {
  @doc("Get the status of Attestation Provider.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the attestation provider.")
      @path
      providerName: string;
    },
    AttestationProvider
  >;

  @doc("Creates a new Attestation Provider.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the attestation provider.")
      @path
      providerName: string;

      @doc("Client supplied parameters.")
      @body
      creationParams: AttestationServiceCreationParams;
    },
    AttestationProvider
  >;

  @doc("Updates the Attestation Provider.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the attestation provider.")
      @path
      providerName: string;

      @doc("Client supplied parameters.")
      @body
      updateParams: AttestationServicePatchParams;
    },
    AttestationProvider
  >;

  @doc("Delete Attestation Service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the attestation service")
      @path
      providerName: string;
    },
    void
  >;

  @doc("Returns a list of attestation providers in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Attestation/attestationProviders")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AttestationProviderListResult
  >;

  @doc("Returns attestation providers list in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AttestationProviderListResult
  >;

  @doc("Get the default provider")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Attestation/defaultProviders")
  @get
  ListDefault is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AttestationProviderListResult
  >;

  @doc("Get the default provider by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Attestation/locations/{location}/defaultProvider")
  @get
  GetDefaultByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The location of the default provider.")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AttestationProvider
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("""
List all the private endpoint connections associated with the attestation
provider.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the attestation provider.")
      @path
      providerName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("""
Gets the specified private endpoint connection associated with the attestation
provider.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the attestation provider.")
      @path
      providerName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Update the state of specified private endpoint connection associated with the
attestation provider.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the attestation provider.")
      @path
      providerName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection properties.")
      @body
      properties: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Deletes the specified private endpoint connection associated with the
attestation provider.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Attestation/attestationProviders/{providerName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the attestation provider.")
      @path
      providerName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}
