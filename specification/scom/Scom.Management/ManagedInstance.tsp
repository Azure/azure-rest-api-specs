import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Scom;
/** A SCOM instance resource */
model ManagedInstance is TrackedResource<MonitoringInstanceProperties> {
  /** Name of the Azure Monitor Operations Manager Managed Instance (SCOM MI) */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @path
  @key("instanceName")
  @segment("managedInstances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

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
  update is ArmTagsPatchAsync<ManagedInstance>;
  /** Delete a SCOM managed instance */
  delete is ArmResourceDeleteAsync<ManagedInstance>;
  /** Lists all SCOM managed instances in a resource group */
  listByResourceGroup is ArmResourceListByParent<ManagedInstance>;
  /** Lists all SCOM managed instances in a subscription */
  listBySubscription is ArmListBySubscription<ManagedInstance>;

  /** Scaling SCOM managed instance. */
  @action("setServerCount")
  scale is ArmResourceActionAsync<
    ManagedInstance,
    ScalingProperties,
    SetServerCountResponseProperties
  >;

  /** Update SCOM servers with latest scom software. */
  patchServers is ArmResourceActionAsync<
    ManagedInstance,
    {},
    PatchServersResponseProperties
  >;

  /** Link Log Analytics workspace for SCOM monitoring instance */
  linkLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    LogAnalyticsConfiguration,
    LogAnalyticsConfiguration
  >;
  /** Unlink Log Analytics workspace for SCOM monitoring instance */
  unlinkLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    {},
    UnlinkLogAnalyticsResponseProperties
  >;
  /** Update configuration for log analytics linking for SCOM monitoring instance */
  updateLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    LogAnalyticsUpdateConfiguration,
    LogAnalyticsUpdateConfiguration
  >;
}
