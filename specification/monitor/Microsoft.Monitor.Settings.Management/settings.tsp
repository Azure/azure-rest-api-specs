import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Monitor;

/**
 * The resource for Azure Monitor Settings, including system data and tags.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource must use a constant name 'default', pattern is not applicable."
model AzureMonitorSettingsResource is ExtensionResource<AzureMonitorSettings> {
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
model AzureMonitorSettings {
  @doc("The ARM resource ID of the default Azure monitor workspace account.")
  defaultAzureMonitorWorkspace: armResourceIdentifier;

  @doc("The ARM resource ID of the default Managed identity.")
  defaultManagedIdentity?: armResourceIdentifier;

  @doc("The ARM resource ID of the default Action group.")
  defaultActionGroup?: armResourceIdentifier;

  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "@visibility(Lifecycle.Read) causes errors in this TypeSpec environment."
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
@armResourceOperations(AzureMonitorSettingsResource)
@route("/providers/Microsoft.Management/serviceGroups")
interface SettingsByServiceGroup {
  @doc("Gets the Default Settings resource for the Service Group.")
  get is ArmResourceRead<AzureMonitorSettingsResource, ServiceGroupParameters>;

  @doc("Creates or updates the Default Settings resource for the Service Group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AzureMonitorSettingsResource,
    ServiceGroupParameters
  >;

  @doc("Deletes the Default Settings resource for the Service Group.")
  delete is ArmResourceDeleteSync<
    AzureMonitorSettingsResource,
    ServiceGroupParameters
  >;
}

alias SubscriptionParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
@doc("Defines operations for managing Settings resources.")
@armResourceOperations(AzureMonitorSettingsResource)
interface SettingsBySubscription {
  @doc("Gets the Default Settings resource for the Subscription.")
  get is ArmResourceRead<AzureMonitorSettingsResource, SubscriptionParameters>;

  @doc("Creates or updates the Default Settings resource for the Subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AzureMonitorSettingsResource,
    SubscriptionParameters
  >;

  @doc("Deletes the Default Settings resource for the Subscription.")
  delete is ArmResourceDeleteSync<
    AzureMonitorSettingsResource,
    SubscriptionParameters
  >;

  @doc("Lists all settings resources for the Subscription.")
  listBySubscription is ArmListBySubscription<AzureMonitorSettingsResource>;
}

@doc("Defines operations for managing Settings resources.")
@armResourceOperations(AzureMonitorSettingsResource)
interface SettingsByResourceOperations {
  @doc("Gets the Default Settings resource for the Resource.")
  get is ArmResourceRead<AzureMonitorSettingsResource>;
}
