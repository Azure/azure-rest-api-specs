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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
        default: "default",
      }
    > {}

@armResourceOperations
interface ResourceHealthMetadataOperationGroup {
  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  @summary("Gets the category of ResourceHealthMetadata to use for the given site")
  getBySite is ResourceHealthMetadataOperationGroupOps.Read<
    ResourceHealthMetadata,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  @summary("Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  listBySite is ResourceHealthMetadataOperationGroupOps.List<
    ResourceHealthMetadata,
    Response = ArmResponse<ResourceHealthMetadataCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface BySiteSlotOperationGroupOps
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
        default: "default",
      }
    > {}

@armResourceOperations
interface BySiteSlotOperationGroup {
  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  @summary("Gets the category of ResourceHealthMetadata to use for the given site")
  getBySiteSlot is BySiteSlotOperationGroupOps.Read<
    ResourceHealthMetadata,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  @summary("Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  @segment("resourceHealthMetadata")
  listBySiteSlot is BySiteSlotOperationGroupOps.List<
    ResourceHealthMetadata,
    Response = ArmResponse<ResourceHealthMetadataCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ResourceHealthMetadata.name, "");
@@doc(ResourceHealthMetadata.properties,
  "ResourceHealthMetadata resource specific properties"
);
