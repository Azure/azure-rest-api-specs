import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DeviceUpdate;

@doc("Checks ADU resource name availability.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceUpdate/checknameavailability")
@post
op CheckNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string;

    @doc("Check Name Availability Request.")
    @body
    request: CheckNameAvailabilityRequest;
  },
  CheckNameAvailabilityResponse
>;

interface AccountsOperations {
  @doc("Returns list of Accounts.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceUpdate/accounts")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    AccountList
  >;

  @doc("Returns list of Accounts.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    AccountList
  >;

  @doc("Returns account details for the given account name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    Account
  >;

  @doc("Checks whether account exists.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}")
  @head
  Head is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    void
  >;

  @doc("Creates or updates Account.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [Account]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Account details.")
      @body
      Account: Account;
    },
    Account
  >;

  @doc("Deletes account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    void
  >;

  @doc("Updates account's patchable properties")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Updated Account.")
      @body
      accountUpdatePayload: AccountUpdate;
    },
    Account
  >;
}

interface InstancesOperations {
  @doc("Returns instances for the given account name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/instances")
  @get
  ListByAccount is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    InstanceList
  >;

  @doc("Returns instance details for the given instance and account name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/instances/{instanceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Instance name.")
      @path
      instanceName: string;
    },
    Instance
  >;

  @doc("Checks whether instance exists.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/instances/{instanceName}")
  @head
  Head is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Instance name.")
      @path
      instanceName: string;
    },
    void
  >;

  @doc("Creates or updates instance.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [Instance]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/instances/{instanceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Instance name.")
      @path
      instanceName: string;

      @doc("Instance details.")
      @body
      Instance: Instance;
    },
    Instance
  >;

  @doc("Deletes instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/instances/{instanceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Instance name.")
      @path
      instanceName: string;
    },
    void
  >;

  @doc("Updates instance's tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/instances/{instanceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("Instance name.")
      @path
      instanceName: string;

      @doc("Updated tags.")
      @body
      tagUpdatePayload: TagUpdate;
    },
    Instance
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("List all private endpoint connections in a device update account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnections")
  @get
  ListByAccount is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("""
Get the specified private endpoint connection associated with the device update
account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Update the state of specified private endpoint connection associated with the
device update account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The parameters for creating a private endpoint connection.")
      @body
      privateEndpointConnection: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Deletes the specified private endpoint connection associated with the device
update account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("List all private link resources in a device update account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateLinkResources")
  @get
  ListByAccount is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    PrivateLinkResourceListResult
  >;

  @doc("""
Get the specified private link resource associated with the device update
account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateLinkResources/{groupId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The group ID of the private link resource.")
      @path
      groupId: string;
    },
    GroupInformation
  >;
}

interface PrivateEndpointConnectionProxiesOperations {
  @doc("""
(INTERNAL - DO NOT USE) List all private endpoint connection proxies in a
device update account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnectionProxies")
  @get
  ListByAccount is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;
    },
    PrivateEndpointConnectionProxyListResult
  >;

  @doc("(INTERNAL - DO NOT USE) Validates a private endpoint connection proxy object.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnectionProxies/{privateEndpointConnectionProxyId}/validate")
  @post
  Validate is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The ID of the private endpoint connection proxy object.")
      @path
      privateEndpointConnectionProxyId: string;

      @doc("The parameters for creating a private endpoint connection proxy.")
      @body
      privateEndpointConnectionProxy: PrivateEndpointConnectionProxy;
    },
    void
  >;

  @doc("""
(INTERNAL - DO NOT USE) Updates a private endpoint inside the private endpoint
connection proxy object.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnectionProxies/{privateEndpointConnectionProxyId}/updatePrivateEndpointProperties")
  @post
  UpdatePrivateEndpointProperties is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The ID of the private endpoint connection proxy object.")
      @path
      privateEndpointConnectionProxyId: string;

      @doc("The parameters for updating a private endpoint connection proxy.")
      @body
      privateEndpointUpdate: PrivateEndpointUpdate;
    },
    void
  >;

  @doc("""
(INTERNAL - DO NOT USE) Get the specified private endpoint connection proxy
associated with the device update account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnectionProxies/{privateEndpointConnectionProxyId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The ID of the private endpoint connection proxy object.")
      @path
      privateEndpointConnectionProxyId: string;
    },
    PrivateEndpointConnectionProxy
  >;

  @doc("""
(INTERNAL - DO NOT USE) Creates or updates the specified private endpoint
connection proxy resource associated with the device update account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnectionProxies/{privateEndpointConnectionProxyId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The ID of the private endpoint connection proxy object.")
      @path
      privateEndpointConnectionProxyId: string;

      @doc("The parameters for creating a private endpoint connection proxy.")
      @body
      privateEndpointConnectionProxy: PrivateEndpointConnectionProxy;
    },
    PrivateEndpointConnectionProxy
  >;

  @doc("""
(INTERNAL - DO NOT USE) Deletes the specified private endpoint connection proxy
associated with the device update account.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/accounts/{accountName}/privateEndpointConnectionProxies/{privateEndpointConnectionProxyId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("Account name.")
      @path
      accountName: string;

      @doc("The ID of the private endpoint connection proxy object.")
      @path
      privateEndpointConnectionProxyId: string;
    },
    void
  >;
}

interface OperationsOperations {
  @doc("Returns list of operations for Microsoft.DeviceUpdate resource provider.")
  @route("/providers/Microsoft.DeviceUpdate/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
