import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Dynatrace;
@doc("Dynatrace Monitor Resource")
model MonitorResource is TrackedResource<MonitorProperties> {
  @doc("Monitor resource name")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Monitors {
  @doc("Get a MonitorResource")
  get is ArmResourceRead<MonitorResource>;
  @doc("Create a MonitorResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MonitorResource>;
  @doc("Update a MonitorResource")
  update is ArmTagsPatchSync<MonitorResource>;
  @doc("Delete a MonitorResource")
  delete is ArmResourceDeleteAsync<MonitorResource>;
  @doc("List MonitorResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<MonitorResource>;
  @doc("List all MonitorResource by subscriptionId")
  listBySubscriptionId is ArmListBySubscription<MonitorResource>;
  @doc("Gets the user account credentials for a Monitor")
  getAccountCredentials is ArmResourceActionSync<
    MonitorResource,
    void,
    AccountInfoSecure
  >;
  @doc("List the resources currently being monitored by the Dynatrace monitor resource.")
  listMonitoredResources is ArmResourceActionSync<
    MonitorResource,
    void,
    MonitoredResourceListResponse
  >;
  @doc("Returns the payload that needs to be passed in the request body for installing Dynatrace agent on a VM.")
  getVMHostPayload is ArmResourceActionSync<
    MonitorResource,
    void,
    VMExtensionPayload
  >;
  @doc("List the compute resources currently being monitored by the Dynatrace resource.")
  listHosts is ArmResourceActionSync<
    MonitorResource,
    void,
    VMHostsListResponse
  >;
  @doc("Gets list of App Services with Dynatrace PaaS OneAgent enabled")
  listAppServices is ArmResourceActionSync<
    MonitorResource,
    void,
    AppServiceListResponse
  >;
  @doc("Gets the SSO configuration details from the partner.")
  getSSODetails is ArmResourceActionSync<
    MonitorResource,
    SSODetailsRequest,
    SSODetailsResponse
  >;
  @doc("Gets all the Dynatrace environments that a user can link a azure resource to")
  listLinkableEnvironments is ArmResourceActionSync<
    MonitorResource,
    LinkableEnvironmentRequest,
    LinkableEnvironmentListResponse
  >;
}
