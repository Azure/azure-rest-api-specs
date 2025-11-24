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
 * Update details
 */
@parentResource(Cluster)
model Update is Azure.ResourceManager.ProxyResource<UpdateProperties> {
  ...ResourceNameParameter<
    Resource = Update,
    KeyName = "updateName",
    SegmentName = "updates",
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
interface Updates {
  /**
   * Get specified Update
   */
  get is ArmResourceRead<Update>;

  /**
   * Put specified Update
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    Update,
    Response = ArmResourceUpdatedResponse<Update>
  >;

  /**
   * Delete specified Update
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Update,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Updates
   */
  list is ArmResourceListByParent<Update, Response = ArmResponse<UpdateList>>;

  /**
   * Apply Update
   */
  @action("apply")
  post is ArmResourceActionAsync<
    Update,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;
}

@@doc(Update.name, "The name of the Update");
@@doc(Update.properties, "Update properties");
@@doc(Updates.put::parameters.resource, "Properties of the Updates object");

// Models

/**
 * List of Updates
 */
model UpdateList is Azure.Core.Page<Update>;

/**
 * Details of a singular Update in HCI Cluster
 */
model UpdateProperties {
  /**
   * Provisioning state of the Updates proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Date that the update was installed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installedDate?: utcDateTime;

  /**
   * Description of the update.
   */
  description?: string;

  /**
   * Minimum Sbe Version of the update.
   */
  minSbeVersionRequired?: string;

  /**
   * State of the update as it relates to this stamp.
   */
  state?: State;

  /**
   * If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.
   */
  @identifiers(#["packageName"])
  prerequisites?: UpdatePrerequisite[];

  /**
   * An array of component versions for a Solution Bundle update, and an empty array otherwise.
   */
  @identifiers(#["version"])
  componentVersions?: PackageVersionInfo[];

  /**
   * Whether a reboot is required after applying the update.
   */
  rebootRequired?: RebootRequirement;

  /**
   * Overall health state for update-specific health checks.
   */
  healthState?: HealthState;

  /**
   * An array of PrecheckResult objects.
   */
  healthCheckResult?: PrecheckResult[];

  /**
   * Last time the package-specific checks were run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  /**
   * Path where the update package is available.
   */
  packagePath?: string;

  /**
   * Size of the package. This value is a combination of the size from update metadata and size of the payload that results from the live scan operation for OS update content.
   */
  packageSizeInMb?: float32;

  /**
   * Display name of the Update
   */
  displayName?: string;

  /**
   * Version of the update.
   */
  version?: string;

  /**
   * Publisher of the update package.
   */
  publisher?: string;

  /**
   * Link to release notes for the update.
   */
  releaseLink?: string;

  /**
   * Indicates the way the update content can be downloaded.
   */
  availabilityType?: AvailabilityType;

  /**
   * Customer-visible type of the update.
   */
  packageType?: string;

  /**
   * Extensible KV pairs serialized as a string. This is currently used to report the stamp OEM family and hardware model information when an update is flagged as Invalid for the stamp based on OEM type.
   */
  additionalProperties?: string;

  /**
   * Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.
   */
  updateStateProperties?: UpdateStateProperties;
}

/**
 * If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.
 */
model UpdatePrerequisite {
  /**
   * Updatable component type.
   */
  updateType?: string;

  /**
   * Version of the prerequisite.
   */
  version?: string;

  /**
   * Friendly name of the prerequisite.
   */
  packageName?: string;
}
