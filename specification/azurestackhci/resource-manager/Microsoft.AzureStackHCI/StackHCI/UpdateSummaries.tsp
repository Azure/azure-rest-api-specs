import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureStackHCI;
/**
 * Get the update summaries for the cluster
 */
@singleton("default")
@parentResource(Cluster)
@clientName("UpdateSummaries")
model UpdateSummariesResource
  is Azure.ResourceManager.ProxyResource<UpdateSummariesProperties> {
  ...ResourceNameParameter<
    Resource = UpdateSummariesResource,
    KeyName = "updateSummary",
    SegmentName = "updateSummaries",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
@clientName("UpdateSummaries")
interface UpdateSummaries {
  /**
   * Get all Update summaries under the HCI cluster
   */
  get is ArmResourceRead<UpdateSummariesResource>;

  /**
   * Put Update summaries under the HCI cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    UpdateSummariesResource,
    Response = ArmResourceUpdatedResponse<UpdateSummariesResource>
  >;

  /**
   * Delete Update Summaries
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    UpdateSummariesResource,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> &
      ArmLroLocationHeader) | ArmDeletedNoContentResponse
  >;

  /**
   * List all Update summaries under the HCI cluster
   */
  list is ArmResourceListByParent<
    UpdateSummariesResource,
    Response = ArmResponse<UpdateSummariesList>
  >;
}

@@doc(UpdateSummariesResource.name, "");
@@doc(UpdateSummariesResource.properties, "Update summaries properties");

@@doc(UpdateSummaries.put::parameters.resource,
  "Properties of the UpdateSummaries resource"
);

@@clientName(UpdateSummaries.put::parameters.resource,
  "updateLocationProperties"
);

// Models

/**
 * Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.
 */
model UpdateStateProperties {
  /**
   * Progress percentage of ongoing operation. Currently this property is only valid when the update is in the Downloading state, where it maps to how much of the update content has been downloaded.
   */
  progressPercentage?: float32;

  /**
   * Brief message with instructions for updates of AvailabilityType Notify.
   */
  notifyMessage?: string;
}

/**
 * List of Update Summaries
 */
model UpdateSummariesList is Azure.Core.Page<UpdateSummariesResource>;

/**
 * Properties of Update summaries
 */
model UpdateSummariesProperties {
  /**
   * Provisioning state of the UpdateSummaries proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * OEM family name.
   */
  oemFamily?: string;

  /**
   * Current OEM Version.
   */
  currentOemVersion?: string;

  /**
   * Name of the hardware model.
   */
  hardwareModel?: string;

  /**
   * Current version of each updatable component.
   */
  @identifiers(#["version"])
  packageVersions?: PackageVersionInfo[];

  /**
   * Current Solution Bundle version of the stamp.
   */
  currentVersion?: string;

  /**
   * Current Sbe version of the stamp.
   */
  currentSbeVersion?: string;

  /**
   * Last time an update installation completed successfully.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * Last time the update service successfully checked for updates
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChecked?: utcDateTime;

  /**
   * Overall health state for update-specific health checks.
   */
  healthState?: HealthState;

  /**
   * An array of pre-check result objects.
   */
  @identifiers(#["name"])
  healthCheckResult?: PrecheckResult[];

  /**
   * Last time the package-specific checks were run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  /**
   * Overall update state of the stamp.
   */
  state?: UpdateSummariesPropertiesState;
}

/**
 * Result of a precheck validation test.
 */
model PrecheckResult {
  /**
   * Name of the individual test/rule/alert that was executed. Unique, not exposed to the customer.
   */
  name?: string;

  /**
   * The health check DisplayName localized of the individual test executed.
   */
  displayName?: string;

  /**
   * Key-value pairs that allow grouping/filtering individual tests.
   */
  tags?: PrecheckResultTags;

  /**
   * Key-value pairs that allow grouping/filtering individual tests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Backward compatibility to maintain consistency with old swagger"
  healthCheckTags?: Record<string>;

  /**
   * User-facing name; one or more sentences indicating the direct issue.
   */
  title?: string;

  /**
   * Represents the current status of the check being performed. Indicates whether the check has completed successfully, failed, or is still in progress.
   */
  status?: Status;

  /**
   * Indicates the importance or impact level of the result. Determines whether the result is informational, a warning, or a critical issue that may block updates.
   */
  severity?: Severity;

  /**
   * Detailed overview of the issue and what impact the issue has on the stamp.
   */
  description?: string;

  /**
   * Set of steps that can be taken to resolve the issue found.
   */
  remediation?: string;

  /**
   * The unique identifier for the affected resource (such as a node or drive).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "backward compatibility to maintain consistency with old swagger"
  targetResourceID?: string;

  /**
   * The name of the affected resource.
   */
  targetResourceName?: string;

  /**
   * The type of resource being referred to (well-known set of nouns in infrastructure, aligning with Monitoring).
   */
  targetResourceType?: string;

  /**
   * The time in which the HealthCheck was called.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Property bag of key value pairs for additional information.
   */
  additionalData?: string;

  /**
   * The name of the services called for the HealthCheck (I.E. Test-AzureStack, Test-Cluster).
   */
  healthCheckSource?: string;
}

/**
 * Key-value pairs that allow grouping/filtering individual tests.
 */
model PrecheckResultTags {
  /**
   * Key that allow grouping/filtering individual tests.
   */
  key?: string;

  /**
   * Value of the key that allow grouping/filtering individual tests.
   */
  value?: string;
}

/**
 * Current version of each updatable component.
 */
model PackageVersionInfo {
  /**
   * Package type
   */
  packageType?: string;

  /**
   * Package version
   */
  version?: string;

  /**
   * Last time this component was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}
