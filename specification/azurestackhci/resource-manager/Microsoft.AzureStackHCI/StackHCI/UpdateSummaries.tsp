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

namespace Microsoft.AzureStackHCI;
/**
 * Get the update summaries for the cluster
 */
@singleton("default")
@parentResource(Cluster)
model UpdateSummary
  is Azure.ResourceManager.ProxyResource<UpdateSummariesProperties> {
  ...ResourceNameParameter<
    Resource = UpdateSummary,
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
interface UpdateSummaries {
  /**
   * Get all Update summaries under the HCI cluster
   */
  get is ArmResourceRead<UpdateSummary>;

  /**
   * Put Update summaries under the HCI cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    UpdateSummary,
    Response = ArmResourceCreatedResponse<UpdateSummary> | ArmResourceUpdatedResponse<UpdateSummary>
  >;

  /**
   * Delete Update Summaries
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    UpdateSummary,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> &
      ArmLroLocationHeader) | ArmDeletedNoContentResponse
  >;

  /**
   * List all Update summaries under the HCI cluster
   */
  list is ArmResourceListByParent<
    UpdateSummary,
    Response = ArmResponse<UpdateSummariesList>
  >;
}

@@doc(UpdateSummary.name, "");
@@doc(UpdateSummary.properties, "Update summaries properties");
@@doc(UpdateSummaries.put::parameters.resource,
  "Properties of the UpdateSummaries resource"
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
model UpdateSummariesList is Azure.Core.Page<UpdateSummary>;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  healthState?: HealthState;

  /**
   * An array of pre-check result objects.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
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
