import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./../models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.NetApp")
namespace Microsoft.NetApp;
/**
 * Information regarding regionInfo Item.
 */
@singleton("default")
@added(Versions.v2025_09_01_preview)
@parentResource(SubscriptionLocationResource)
model ElasticRegionInfoResource
  is Azure.ResourceManager.ProxyResource<ElasticRegionInfo> {
  ...ResourceNameParameter<
    Resource = ElasticRegionInfoResource,
    KeyName = "regionInfo",
    SegmentName = "regionInfos",
    NamePattern = ""
  >;
}

/**
 * Contains information about the logical availability zones available within a specific Azure region for a given subscription, used to determine where elastic resources can be provisioned.
 */
@added(Versions.v2025_09_01_preview)
model ElasticRegionInfo {
  /** Lists the logical availability zones in the specified region and indicates their current availability status for the subscription. This helps determine which zones can be used to deploy or elastic resources. */
  @OpenAPI.extension("x-ms-identifiers", #["availabilityZone"])
  availabilityZoneMappings?: AvailabilityZoneMapping[];
}

/**
 * Lists the logical availability zones in the specified region and indicates their current availability status for the subscription. This helps determine which zones can be used to deploy or elastic resources.
 */
model AvailabilityZoneMapping {
  /** The identifier of the logical availability zone within the region (e.g., '1', '2', '3') */
  availabilityZone?: string;

  /** Indicates whether the specified availability zone is currently available for provisioning elastic resources */
  availabilityStatus?: ZoneAvailabilityStatus;
}

union ZoneAvailabilityStatus {
  string,

  /** The availabilityZone is available */
  Available: "Available",

  /** The availabilityZone is unavailable */
  Unavailable: "Unavailable",
}

/**
 * List of regionInfo resources
 */
@added(Versions.v2025_09_01_preview)
model ElasticRegionInfosList is Azure.Core.Page<ElasticRegionInfoResource>;

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface ElasticRegionInfoResources {
  /**
   * Provides storage to network proximity and logical zone mapping information.
   */
  get is ArmResourceRead<
    ElasticRegionInfoResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Provides region specific information.
   */
  list is ArmResourceListByParent<
    ElasticRegionInfoResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<ElasticRegionInfosList>
  >;
}

@@doc(ElasticRegionInfoResource.name, "");
@@doc(ElasticRegionInfoResource.properties, "regionInfo properties");
