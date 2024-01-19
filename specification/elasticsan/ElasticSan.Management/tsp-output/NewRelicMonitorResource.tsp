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

namespace NewRelic.Observability;
@doc("A Monitor Resource by NewRelic")
model NewRelicMonitorResource is TrackedResource<MonitorProperties> {
  @doc("Name of the Monitors resource")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NewRelicMonitorResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a NewRelicMonitorResource")
  @operationId("Monitors_Get")
  get is ArmResourceRead<NewRelicMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a NewRelicMonitorResource")
  @operationId("Monitors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NewRelicMonitorResource,
    BaseParameters<NewRelicMonitorResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a NewRelicMonitorResource")
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<
    NewRelicMonitorResource,
    NewRelicMonitorResourceUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a NewRelicMonitorResource")
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<
    NewRelicMonitorResource,
    {
      ...BaseParameters<NewRelicMonitorResource>;

      @doc("User Email.")
      @query("userEmail")
      userEmail: string;
    },
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List NewRelicMonitorResource resources by resource group")
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NewRelicMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List NewRelicMonitorResource resources by subscription ID")
  @operationId("Monitors_ListBySubscription")
  listBySubscription is ArmListBySubscription<NewRelicMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get metric rules")
  @operationId("Monitors_GetMetricRules")
  getMetricRules is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsRequest,
    MetricRules
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get metric status")
  @operationId("Monitors_GetMetricStatus")
  getMetricStatus is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsStatusRequest,
    MetricsStatusResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the app service resources currently being monitored by the NewRelic resource.")
  @operationId("Monitors_ListAppServices")
  listAppServices is ArmResourceActionSync<
    NewRelicMonitorResource,
    AppServicesGetRequest,
    AppServicesListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Switches the billing for NewRelic monitor resource.")
  @operationId("Monitors_SwitchBilling")
  switchBilling is ArmResourceActionSync<
    NewRelicMonitorResource,
    SwitchBillingRequest,
    NewRelicMonitorResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the compute vm resources currently being monitored by the NewRelic resource.")
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    NewRelicMonitorResource,
    HostsGetRequest,
    VMHostsListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the resources currently being monitored by the NewRelic monitor resource.")
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the payload that needs to be passed in the request body for installing NewRelic agent on a VM.")
  @operationId("Monitors_VmHostPayload")
  vmHostPayload is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    VMExtensionPayload
  >;
}

@@projectedName(NewRelicMonitorResources.getMetricRules::parameters.body,
  "json",
  "request"
);
@@extension(NewRelicMonitorResources.getMetricRules::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(NewRelicMonitorResources.getMetricRules::parameters.body,
  "The details of the get metrics status request."
);
@@projectedName(NewRelicMonitorResources.getMetricStatus::parameters.body,
  "json",
  "request"
);
@@extension(NewRelicMonitorResources.getMetricStatus::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(NewRelicMonitorResources.getMetricStatus::parameters.body,
  "The details of the get metrics status request."
);
@@projectedName(NewRelicMonitorResources.listAppServices::parameters.body,
  "json",
  "request"
);
@@extension(NewRelicMonitorResources.listAppServices::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(NewRelicMonitorResources.listAppServices::parameters.body,
  "The details of the app services get request."
);
@@projectedName(NewRelicMonitorResources.switchBilling::parameters.body,
  "json",
  "request"
);
@@extension(NewRelicMonitorResources.switchBilling::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(NewRelicMonitorResources.switchBilling::parameters.body,
  "The details of the switch billing request."
);
@@projectedName(NewRelicMonitorResources.listHosts::parameters.body,
  "json",
  "request"
);
@@extension(NewRelicMonitorResources.listHosts::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(NewRelicMonitorResources.listHosts::parameters.body,
  "The details of the Hosts get request."
);
