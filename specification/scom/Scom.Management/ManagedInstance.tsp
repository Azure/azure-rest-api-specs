import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using Microsoft.Scom.Builders;

namespace Microsoft.Scom;
/** A SCOM instance resource */
model ManagedInstance is TrackedResource<MonitoringInstanceProperties> {
  /** Name of the Azure Monitor Operations Manager Managed Instance (SCOM MI) */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @path
  @key("instanceName")
  @segment("managedInstances")
  name: string;

  /** The managed service identities assigned to this resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Have to do custom identity to prevent breaking change"
  identity?: ManagedIdentity;
}

/** A paged list of SCOM managed instances */
@pagedResult
model MonitoringInstanceList {
  /** The items on the page */
  @items
  @visibility("read")
  value?: ManagedInstance[];

  /** URL to get the next page if any */
  @nextLink
  @visibility("read")
  nextLink?: ResourceLocation<ManagedInstance>;
}

// Workaround
@@projectedName(Instances.createOrUpdate::parameters.resource,
  "json",
  "ManagedInstance"
);
@@OpenAPI.extension(Instances.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "ManagedInstance"
);
@@projectedName(Instances.update::parameters.properties,
  "json",
  "ManagedInstance"
);
@@OpenAPI.extension(Instances.update::parameters.properties,
  "x-ms-client-name",
  "ManagedInstance"
);
@armResourceOperations
interface Instances {
  /** Get SCOM managed instance details */
  get is ArmResourceRead<ManagedInstance>;
  /** Create or update SCOM managed instance */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedInstance,
    {
      ...BaseParameters<ManagedInstance>;

      /** Validation mode for the SCOM managed instance */
      @query("validationMode")
      validationMode?: boolean;
    }
  >;
  /** Patch SCOM managed instance */
  update is ArmCustomPatchAsync<ManagedInstance, MonitoringInstancePatch>;
  /** Delete a SCOM managed instance */
  delete is ArmResourceDeleteAsync<ManagedInstance>;
  /** Lists all SCOM managed instances in a resource group */
  listByResourceGroup is ScomArmResourceListByParent<
    ManagedInstance,
    MonitoringInstanceList
  >;
  /** Lists all SCOM managed instances in a subscription */
  listBySubscription is ScomArmListBySubscription<
    ManagedInstance,
    MonitoringInstanceList
  >;

  /** Scaling SCOM managed instance. */
  @action("setServerCount")
  scale is ArmResourceActionAsync<
    ManagedInstance,
    ScalingProperties,
    setServerCountResponseProperties
  >;

  /** Update SCOM servers with latest scom software. */
  patchServers is ArmResourceActionAsync<
    ManagedInstance,
    void,
    patchServersResponseProperties
  >;

  /** Link Log Analytics workspace for SCOM monitoring instance */
  linkLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    logAnalyticsConfiguration,
    logAnalyticsConfiguration
  >;
  /** Unlink Log Analytics workspace for SCOM monitoring instance */
  unlinkLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    void,
    unlinkLogAnalyticsResponseProperties
  >;
  /** Update configuration for log analytics linking for SCOM monitoring instance */
  updateLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    logAnalyticsUpdateConfiguration,
    logAnalyticsUpdateConfiguration
  >;
}
