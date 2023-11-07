import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Scom;
@doc("A SCOM instance resource")
model ManagedInstance is TrackedResource<MonitoringInstanceProperties> {
  @doc("Name of the Azure Monitor Operations Manager Managed Instance (SCOM MI)")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @path
  @key("instanceName")
  @segment("managedInstances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ManagedInstances {
  @doc("Get SCOM managed instance details")
  get is ArmResourceRead<ManagedInstance>;
  @doc("Create or update SCOM managed instance")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedInstance,
    {
      ...BaseParameters<ManagedInstance>;

      @doc("Validation mode for the SCOM managed instance")
      @query("validationMode")
      validationMode?: boolean;
    }
  >;
  @doc("Patch SCOM managed instance")
  update is ArmTagsPatchAsync<ManagedInstance>;
  @doc("Delete a SCOM managed instance")
  delete is ArmResourceDeleteAsync<ManagedInstance>;
  @doc("Lists all SCOM managed instances in a resource group")
  listByResourceGroup is ArmResourceListByParent<ManagedInstance>;
  @doc("Lists all SCOM managed instances in a subscription ")
  listBySubscription is ArmListBySubscription<ManagedInstance>;
  @doc("Scaling SCOM managed instance.")
  scale is ArmResourceActionAsync<
    ManagedInstance,
    ScalingProperties,
    SetServerCountResponseProperties
  >;
  @doc("Update SCOM servers with latest scom software.")
  patchServers is ArmResourceActionAsync<
    ManagedInstance,
    {},
    PatchServersResponseProperties
  >;
  @doc("Link Log Analytics workspace for SCOM monitoring instance")
  linkLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    LogAnalyticsConfiguration,
    LogAnalyticsConfiguration
  >;
  @doc("Unlink Log Analytics workspace for SCOM monitoring instance")
  unlinkLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    {},
    UnlinkLogAnalyticsResponseProperties
  >;
  @doc("Update configuration for log analytics linking for SCOM monitoring instance")
  updateLogAnalytics is ArmResourceActionAsync<
    ManagedInstance,
    LogAnalyticsUpdateConfiguration,
    LogAnalyticsUpdateConfiguration
  >;
}
