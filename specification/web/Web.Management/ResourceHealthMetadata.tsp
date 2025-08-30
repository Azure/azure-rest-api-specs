import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Used for getting ResourceHealthCheck settings.
 */
@singleton("default")
@parentResource(Site)
model ResourceHealthMetadata
  is Azure.ResourceManager.ProxyResource<ResourceHealthMetadataProperties> {
  ...ResourceNameParameter<
    Resource = ResourceHealthMetadata,
    KeyName = "resourceHealthMetadatum",
    SegmentName = "resourceHealthMetadata",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ResourceHealthMetadataOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("resourceHealthMetadata")
        @key
        default: string,
      }
    > {}

@armResourceOperations
interface ResourceHealthMetadataOperationGroup {
  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceHealthMetadata_GetBySite")
  getBySite is ResourceHealthMetadataOperationGroupOps.Read<ResourceHealthMetadata>;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceHealthMetadata_ListBySite")
  listBySite is ResourceHealthMetadataOperationGroupOps.List<
    ResourceHealthMetadata,
    Response = ArmResponse<ResourceHealthMetadataCollection>
  >;
}
@armResourceOperations
interface ResourceHealthMetadataOperationGroupOps_2
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of web app slot. If not specified then will default to production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("resourceHealthMetadata")
        @key
        default: string,
      }
    > {}

@armResourceOperations
interface ResourceHealthMetadataOperationGroup_2 {
  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceHealthMetadata_GetBySiteSlot")
  getBySiteSlot is ResourceHealthMetadataOperationGroupOps_2.Read<ResourceHealthMetadata>;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceHealthMetadata_ListBySiteSlot")
  @segment("resourceHealthMetadata")
  listBySiteSlot is ResourceHealthMetadataOperationGroupOps_2.List<
    ResourceHealthMetadata,
    Response = ArmResponse<ResourceHealthMetadataCollection>
  >;
}

@@doc(ResourceHealthMetadata.name, "");
@@doc(ResourceHealthMetadata.properties,
  "ResourceHealthMetadata resource specific properties"
);
