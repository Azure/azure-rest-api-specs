import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Monitor.Settings.Management;

/**
 * The resource for Azure Monitor Settings, including system data and tags.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource must use a constant name 'default', pattern is not applicable."
model AzureMonitorSettingsPublicResource is ExtensionResource<AzureMonitorSettingsPublic> {
  /**
   * The name of the Azure Monitor Settings resource. Must always be 'default'.
   */
  @key("name")
  @segment("settings")
  @path
  name: "default";
}

/**
 * The properties for Azure Monitor Settings.
 */
@doc("The properties for Azure Monitor Settings.")
model AzureMonitorSettingsPublic {
  @doc("The ARM resource ID of the default Azure monitor workspace account.")
  defaultAzureMonitorWorkspace: string;
  @doc("The ARM resource ID of the default Managed identity.")
  defaultManagedIdentity?: string;
  @doc("The ARM resource ID of the default Action group.")
  defaultActionGroup?: string;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "@visibility(Lifecycle.Read) causes errors in this TypeSpec environment."
  ...DefaultProvisioningStateProperty;
}

@doc("ServiceGroup as parameter")
model ServiceGroupParameters {
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the service group.")
  serviceGroupName: string;
  ...ApiVersionParameter;
}

@doc("Defines operations for managing Settings resources.")
@armResourceOperations(AzureMonitorSettingsPublicResource)
@route("/providers/Microsoft.Management/serviceGroups")
interface SettingsByServiceGroup {
  @doc("Gets the Default Settings resource for the Service Group.")
  get is ArmResourceRead<AzureMonitorSettingsPublicResource, ServiceGroupParameters>;

  @doc("Creates or updates the Default Settings resource for the Service Group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AzureMonitorSettingsPublicResource, ServiceGroupParameters>;

  @doc("Deletes the Default Settings resource for the Service Group.")
  delete is ArmResourceDeleteSync<AzureMonitorSettingsPublicResource, ServiceGroupParameters>;
}


alias SubscriptionParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
@doc("Defines operations for managing Settings resources.")
@armResourceOperations(AzureMonitorSettingsPublicResource)
interface SettingsBySubscription {
  @doc("Gets the Default Settings resource for the Subscription.")
  get is ArmResourceRead<AzureMonitorSettingsPublicResource, SubscriptionParameters>;

  @doc("Creates or updates the Default Settings resource for the Subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AzureMonitorSettingsPublicResource, SubscriptionParameters>;

  @doc("Deletes the Default Settings resource for the Subscription.")
  delete is ArmResourceDeleteSync<AzureMonitorSettingsPublicResource, SubscriptionParameters>;

  @doc("Lists all settings resources for the Subscription.")
  listBySubscription is ArmListBySubscription<AzureMonitorSettingsPublicResource>;
}

@doc("Defines operations for managing Settings resources.")
@armResourceOperations(AzureMonitorSettingsPublicResource)
interface SettingsByResourceOperations {
  @doc("Gets the Default Settings resource for the Resource.")
  get is ArmResourceRead<AzureMonitorSettingsPublicResource>;
}
