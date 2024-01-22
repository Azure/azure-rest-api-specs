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
/**
 * A Monitor Resource by NewRelic
 */
model NewRelicMonitorResource is TrackedResource<MonitorProperties> {
  /**
   * Name of the Monitors resource
   */
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NewRelicMonitorResources {
  /**
   * Get a NewRelicMonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Get")
  get is ArmResourceRead<NewRelicMonitorResource>;

  /**
   * Create a NewRelicMonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NewRelicMonitorResource,
    BaseParameters<NewRelicMonitorResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a NewRelicMonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<
    NewRelicMonitorResource,
    NewRelicMonitorResourceUpdate
  >;

  /**
   * Delete a NewRelicMonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<
    NewRelicMonitorResource,
    {
      ...BaseParameters<NewRelicMonitorResource>;

      /**
       * User Email.
       */
      @query("userEmail")
      userEmail: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List NewRelicMonitorResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NewRelicMonitorResource>;

  /**
   * List NewRelicMonitorResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListBySubscription")
  listBySubscription is ArmListBySubscription<NewRelicMonitorResource>;

  /**
   * Get metric rules
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_GetMetricRules")
  getMetricRules is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsRequest,
    MetricRules
  >;

  /**
   * Get metric status
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_GetMetricStatus")
  getMetricStatus is ArmResourceActionSync<
    NewRelicMonitorResource,
    MetricsStatusRequest,
    MetricsStatusResponse
  >;

  /**
   * List the app service resources currently being monitored by the NewRelic resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListAppServices")
  listAppServices is ArmResourceActionSync<
    NewRelicMonitorResource,
    AppServicesGetRequest,
    AppServicesListResponse
  >;

  /**
   * Switches the billing for NewRelic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_SwitchBilling")
  switchBilling is ArmResourceActionSync<
    NewRelicMonitorResource,
    SwitchBillingRequest,
    NewRelicMonitorResource
  >;

  /**
   * List the compute vm resources currently being monitored by the NewRelic resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListHosts")
  listHosts is ArmResourceActionSync<
    NewRelicMonitorResource,
    HostsGetRequest,
    VMHostsListResponse
  >;

  /**
   * List the resources currently being monitored by the NewRelic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListMonitoredResources")
  listMonitoredResources is ArmResourceActionSync<
    NewRelicMonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  /**
   * Returns the payload that needs to be passed in the request body for installing NewRelic agent on a VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
