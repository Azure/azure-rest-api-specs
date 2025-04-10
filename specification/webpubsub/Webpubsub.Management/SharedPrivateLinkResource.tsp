import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Replica.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * Describes a Shared Private Link Resource
 */
@parentResource(Replica)
model SharedPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<SharedPrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = SharedPrivateLinkResource,
    KeyName = "sharedPrivateLinkResourceName",
    SegmentName = "sharedPrivateLinkResources",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface SharedPrivateLinkResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = WebPubSubResource,
          KeyName = "resourceName",
          SegmentName = "webPubSub",
          NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Replica,
          KeyName = "replicaName",
          SegmentName = "replicas",
          NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SharedPrivateLinkResource,
        KeyName = "sharedPrivateLinkResourceName",
        SegmentName = "sharedPrivateLinkResources",
        NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
      >>
    > {}

@armResourceOperations
interface SharedPrivateLinkResources {
  /**
   * Get the specified shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicaSharedPrivateLinkResources_Get")
  get is SharedPrivateLinkResourceOps.Read<SharedPrivateLinkResource>;

  /**
   * Create or update a shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicaSharedPrivateLinkResources_CreateOrUpdate")
  createOrUpdate is SharedPrivateLinkResourceOps.CreateOrUpdateAsync<SharedPrivateLinkResource>;

  /**
   * List shared private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicaSharedPrivateLinkResources_List")
  list is SharedPrivateLinkResourceOps.List<
    SharedPrivateLinkResource,
    Response = ArmResponse<SharedPrivateLinkResourceList>
  >;
}
@armResourceOperations
interface WebPubSubSharedPrivateLinkResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = WebPubSubResource,
          KeyName = "resourceName",
          SegmentName = "webPubSub",
          NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SharedPrivateLinkResource,
        KeyName = "sharedPrivateLinkResourceName",
        SegmentName = "sharedPrivateLinkResources",
        NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
      >>
    > {}

@armResourceOperations
interface WebPubSubSharedPrivateLinkResources {
  /**
   * Get the specified shared private link resource
   */
  get is WebPubSubSharedPrivateLinkResourceOps.Read<SharedPrivateLinkResource>;

  /**
   * Create or update a shared private link resource
   */
  createOrUpdate is WebPubSubSharedPrivateLinkResourceOps.CreateOrUpdateAsync<SharedPrivateLinkResource>;

  /**
   * Delete the specified shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is WebPubSubSharedPrivateLinkResourceOps.DeleteWithoutOkAsync<
    SharedPrivateLinkResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List shared private link resources
   */
  list is WebPubSubSharedPrivateLinkResourceOps.List<
    SharedPrivateLinkResource,
    Response = ArmResponse<SharedPrivateLinkResourceList>
  >;
}

@@maxLength(SharedPrivateLinkResource.name, 63);
@@minLength(SharedPrivateLinkResource.name, 3);
@@doc(SharedPrivateLinkResource.name,
  "The name of the shared private link resource."
);
@@doc(SharedPrivateLinkResource.properties,
  "Describes the properties of an existing Shared Private Link Resource"
);
@@doc(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The shared private link resource"
);
@@doc(WebPubSubSharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The shared private link resource"
);
