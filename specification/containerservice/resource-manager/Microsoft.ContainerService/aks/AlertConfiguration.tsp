import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;
using Autorest;

namespace Microsoft.ContainerService;

/**
 * The mode of the alert configuration.
 */
@added(Versions.v2026_01_02_preview)
union AlertConfigurationMode {
  string,

  /**
   * Alerts are disabled.
   */
  Disabled: "Disabled",

  /**
   * AKS manages the alerts lifecycle including creation, updates, and deletion.
   * Users receive alerts through the configured notification channel.
   */
  Managed: "Managed",
}

/**
 * The current provisioning state of the alert configuration.
 */
@added(Versions.v2026_01_02_preview)
union AlertConfigurationProvisioningState {
  string,

  /**
   * The alert configuration is being created.
   */
  Creating: "Creating",

  /**
   * The alert configuration is being updated.
   */
  Updating: "Updating",

  /**
   * The alert configuration is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The alert configuration has been successfully provisioned.
   */
  Succeeded: "Succeeded",

  /**
   * The alert configuration provisioning failed.
   */
  Failed: "Failed",

  /**
   * The alert configuration provisioning was canceled.
   */
  Canceled: "Canceled",
}

/**
 * Notification settings for the alert configuration.
 */
@added(Versions.v2026_01_02_preview)
model AlertNotification {
  /**
   * The resource ID of the Azure Monitor action group to send notifications to.
   */
  actionGroupId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Insights/actionGroups";
    }
  ]>;
}

/**
 * Properties of the alert configuration.
 */
@added(Versions.v2026_01_02_preview)
model AlertConfigurationProperties {
  /**
   * The mode of the alert configuration. Specifies how AKS manages the alerts.
   */
  mode: AlertConfigurationMode;

  /**
   * Notification settings for the alert configuration.
   */
  notification: AlertNotification;

  /**
   * The current provisioning state of the alert configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AlertConfigurationProvisioningState;
}

/**
 * Alert configuration for a managed cluster. Allows configuring AKS-managed alerts
 * that notify users of important cluster events and conditions.
 */
@added(Versions.v2026_01_02_preview)
@parentResource(ManagedCluster)
model AlertConfiguration
  is Azure.ResourceManager.ProxyResource<AlertConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = AlertConfiguration,
    KeyName = "configurationName",
    SegmentName = "alertConfigurations",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
@added(Versions.v2026_01_02_preview)
interface AlertConfigurations {
  /**
   * Gets the specified alert configuration of a managed cluster.
   */
  get is ArmResourceRead<AlertConfiguration>;

  /**
   * Creates or updates an alert configuration in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AlertConfiguration,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = AlertConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an alert configuration.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AlertConfiguration,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of alert configurations in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<AlertConfiguration>;
}

@@doc(AlertConfiguration.name, "The name of the alert configuration.");
@@doc(AlertConfiguration.properties,
  "The resource-specific properties for this resource."
);
@@doc(AlertConfigurations.createOrUpdate::parameters.resource,
  "The alert configuration to create or update."
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Needed to attach x-ms-examples to operations"
@@Autorest.example(AlertConfigurations.get,
  "./examples/2026-01-02-preview/AlertConfigurations_Get.json",
  "Get Alert Configuration"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Needed to attach x-ms-examples to operations"
@@Autorest.example(AlertConfigurations.createOrUpdate,
  "./examples/2026-01-02-preview/AlertConfigurations_CreateOrUpdate.json",
  "Create or Update Alert Configuration"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Needed to attach x-ms-examples to operations"
@@Autorest.example(AlertConfigurations.delete,
  "./examples/2026-01-02-preview/AlertConfigurations_Delete.json",
  "Delete Alert Configuration"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Needed to attach x-ms-examples to operations"
@@Autorest.example(AlertConfigurations.listByManagedCluster,
  "./examples/2026-01-02-preview/AlertConfigurations_ListByManagedCluster.json",
  "List Alert Configurations by Managed Cluster"
);
