import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SignalRManagementClient;

interface OperationsOperations {
  @doc("""
Lists all of the available REST API operations of the Microsoft.SignalRService
provider.
""")
  @route("/providers/Microsoft.SignalRService/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}

interface SignalROperations {
  @doc("Checks that the resource name is valid and is not already in use.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("the region")
      @path
      location: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the operation.")
      @body
      parameters: NameAvailabilityParameters;
    },
    NameAvailability
  >;

  @doc("Handles requests to list all resources in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/signalR")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SignalRResourceList
  >;

  @doc("Handles requests to list all resources in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;
    },
    SignalRResourceList
  >;

  @doc("Get the resource and its properties.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SignalRResource
  >;

  @doc("Create or update a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Parameters for the create or update operation")
      @body
      parameters: SignalRResource;
    },
    SignalRResource | void
  >;

  @doc("Operation to delete a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("Operation to update an exiting resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Parameters for the update operation")
      @body
      parameters: SignalRResource;
    },
    SignalRResource | void
  >;

  @doc("Get the access keys of the resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SignalRKeys
  >;

  @doc("""
Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot
be regenerated at the same time.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/regenerateKey")
  @post
  RegenerateKey is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Parameter that describes the Regenerate Key Operation.")
      @body
      parameters: RegenerateKeyParameters;
    },
    SignalRKeys
  >;

  @doc("Operation to restart a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/restart")
  @post
  Restart is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("List all available skus of the resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/skus")
  @get
  ListSkus is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SkuList
  >;
}

interface UsagesOperations {
  @doc("List resource usage quotas by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("the location like \"eastus\"")
      @path
      location: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SignalRUsageList
  >;
}

interface SignalRCustomCertificatesOperations {
  @doc("List all custom certificates.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    CustomCertificateList
  >;

  @doc("Get a custom certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates/{certificateName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Custom certificate name")
      @path
      certificateName: string;
    },
    CustomCertificate
  >;

  @doc("Create or update a custom certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates/{certificateName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Custom certificate name")
      @path
      certificateName: string;

      @body parameters: CustomCertificate;
    },
    CustomCertificate
  >;

  @doc("Delete a custom certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates/{certificateName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Custom certificate name")
      @path
      certificateName: string;
    },
    void
  >;
}

interface SignalRCustomDomainsOperations {
  @doc("List all custom domains.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    CustomDomainList
  >;

  @doc("Get a custom domain.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Custom domain name.")
      @path
      name: string;
    },
    CustomDomain
  >;

  @doc("Create or update a custom domain.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Custom domain name.")
      @path
      name: string;

      @body parameters: CustomDomain;
    },
    CustomDomain
  >;

  @doc("Delete a custom domain.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Custom domain name.")
      @path
      name: string;
    },
    void
  >;
}

interface SignalRPrivateEndpointConnectionsOperations {
  @doc("List private endpoint connections")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    PrivateEndpointConnectionList
  >;

  @doc("Get the specified private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("Update the state of specified private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("The resource of private endpoint and its properties")
      @body
      parameters: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("Delete the specified private endpoint connection")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    void
  >;
}

interface SignalRPrivateLinkResourcesOperations {
  @doc("Get the private link resources that need to be created for a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    PrivateLinkResourceList
  >;
}

interface SignalRSharedPrivateLinkResourcesOperations {
  @doc("List shared private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SharedPrivateLinkResourceList
  >;

  @doc("Get the specified shared private link resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the shared private link resource")
      @path
      sharedPrivateLinkResourceName: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SharedPrivateLinkResource
  >;

  @doc("Create or update a shared private link resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the shared private link resource")
      @path
      sharedPrivateLinkResourceName: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("The shared private link resource")
      @body
      parameters: SharedPrivateLinkResource;
    },
    SharedPrivateLinkResource
  >;

  @doc("Delete the specified shared private link resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the shared private link resource")
      @path
      sharedPrivateLinkResourceName: string;

      @doc("""
Gets subscription Id which uniquely identify the Microsoft Azure subscription.
The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group that contains the resource. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    void
  >;
}
