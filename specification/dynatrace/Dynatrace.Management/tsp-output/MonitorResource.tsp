import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
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
interface MonitorResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a MonitorResource")
  @operationId("Monitors_Get")
  get is ArmResourceRead<MonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a MonitorResource")
  @operationId("Monitors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    MonitorResource,
    BaseParameters<MonitorResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a MonitorResource")
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<MonitorResource, MonitorResourceUpdate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a MonitorResource")
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<
    MonitorResource,
    BaseParameters<MonitorResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List MonitorResource resources by resource group")
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all MonitorResource by subscriptionId")
  @operationId("Monitors_ListBySubscriptionId")
  listBySubscriptionId is ArmListBySubscription<MonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the user account credentials for a Monitor")
  @operationId("Monitors_GetAccountCredentials")
  getAccountCredentials is ArmResourceActionSync<
    MonitorResource,
    void,
    AccountInfoSecure
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the resources currently being monitored by the Dynatrace monitor resource.")
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    MonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the payload that needs to be passed in the request body for installing Dynatrace agent on a VM.")
  @operationId("Monitors_GetVMHostPayload")
  getVMHostPayload is ArmResourceActionSync<
    MonitorResource,
    void,
    VMExtensionPayload
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the compute resources currently being monitored by the Dynatrace resource.")
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    MonitorResource,
    void,
    VMHostsListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets list of App Services with Dynatrace PaaS OneAgent enabled")
  @operationId("Monitors_ListAppServices")
  listAppServices is ArmResourceActionSync<
    MonitorResource,
    void,
    AppServiceListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the SSO configuration details from the partner.")
  @operationId("Monitors_GetSSODetails")
  getSSODetails is ArmResourceActionSync<
    MonitorResource,
    SSODetailsRequest,
    SSODetailsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the Dynatrace environments that a user can link a azure resource to")
  @operationId("Monitors_ListLinkableEnvironments")
  listLinkableEnvironments is ArmResourceActionSync<
    MonitorResource,
    LinkableEnvironmentRequest,
    LinkableEnvironmentListResponse
  >;
}

@@projectedName(MonitorResources.update::parameters.properties,
  "json",
  "resource"
);
@@extension(MonitorResources.update::parameters.properties,
  "x-ms-client-name",
  "resource"
);
@@projectedName(MonitorResources.getSSODetails::parameters.body,
  "json",
  "request"
);
@@extension(MonitorResources.getSSODetails::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(MonitorResources.getSSODetails::parameters.body,
  "The details of the get sso details request."
);
@@projectedName(MonitorResources.listLinkableEnvironments::parameters.body,
  "json",
  "request"
);
@@extension(MonitorResources.listLinkableEnvironments::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(MonitorResources.listLinkableEnvironments::parameters.body,
  "The details of the linkable environment request."
);
