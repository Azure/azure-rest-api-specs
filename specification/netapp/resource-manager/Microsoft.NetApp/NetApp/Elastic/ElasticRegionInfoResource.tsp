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
