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

namespace Microsoft.CertificateRegistration;
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ResourceHealthMetadata,
        KeyName = "default",
        SegmentName = "resourceHealthMetadata",
        NamePattern = ""
      >>
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
interface ResourceHealthMetadataOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ResourceHealthMetadata,
        KeyName = "default",
        SegmentName = "resourceHealthMetadata",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ResourceHealthMetadataOperationGroup {
  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceHealthMetadata_GetBySiteSlot")
  getBySiteSlot is ResourceHealthMetadataOperationGroupOps.Read<ResourceHealthMetadata>;

  /**
   * Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceHealthMetadata_ListBySiteSlot")
  listBySiteSlot is ResourceHealthMetadataOperationGroupOps.List<
    ResourceHealthMetadata,
    Response = ArmResponse<ResourceHealthMetadataCollection>
  >;
}

@@doc(ResourceHealthMetadata.name, "");
@@doc(ResourceHealthMetadata.properties,
  "ResourceHealthMetadata resource specific properties"
);
