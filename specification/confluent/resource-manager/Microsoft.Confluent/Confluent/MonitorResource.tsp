import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./ObservabilityModels.tsp";
import "./OrganizationResource.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Confluent;

/**
 * A monitor that defines the Confluent environment, cluster, and topic to which
 * selected Azure logs are sent.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
@parentResource(OrganizationResource)
model MonitorResource is Azure.ResourceManager.TrackedResource<
  MonitorProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = MonitorResource,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = "^[a-zA-Z0-9_][a-zA-Z0-9_-]+$"
  >;
}

/**
 * Operations for Confluent monitor resources.
 */
@added(Microsoft.Confluent.Versions.v2026_10_21_preview)
@armResourceOperations
interface MonitorResources {
  /**
   * Gets a monitor and its configured Confluent log destination.
   */
  get is ArmResourceRead<
    MonitorResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Creates or replaces a monitor with the Confluent environment, cluster, and
   * topic to which selected Azure logs are sent.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MonitorResource>;

  /**
   * Updates the Azure resource tags assigned to a monitor.
   */
  update is ArmCustomPatchAsync<
    MonitorResource,
    MonitorResourceUpdateParameters
  >;

  /**
   * Deletes a monitor and stops sending Azure logs to its configured Confluent
   * topic.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitorResource,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the monitors configured under a Confluent organization.
   */
  listByOrganization is ArmResourceListByParent<
    MonitorResource,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@maxLength(MonitorResource.name, 32);
@@minLength(MonitorResource.name, 2);
@@doc(MonitorResource.name, "Monitor resource name.");
@@doc(
  MonitorResource.properties,
  "The configured Confluent log destination and current status of the monitor."
);
