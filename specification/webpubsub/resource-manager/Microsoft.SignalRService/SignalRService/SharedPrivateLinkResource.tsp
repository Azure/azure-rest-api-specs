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

        /**
         * The name of the resource.
         */
        @path
        @segment("webPubSub")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(63)
        resourceName: string,

        /**
         * The name of the replica.
         */
        @path
        @segment("replicas")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(63)
        replicaName: string,
      },
      {
        /**
         * The name of the shared private link resource.
         */
        @path
        @segment("sharedPrivateLinkResources")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(63)
        sharedPrivateLinkResourceName: string,
      }
    > {}

@armResourceOperations
interface SharedPrivateLinkResources {
  /**
   * Get the specified shared private link resource
   */
  get is SharedPrivateLinkResourceOps.Read<SharedPrivateLinkResource>;

  /**
   * Create or update a shared private link resource
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is SharedPrivateLinkResourceOps.CreateOrUpdateAsync<SharedPrivateLinkResource>;

  /**
   * List shared private link resources
   */
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

        /**
         * The name of the resource.
         */
        @path
        @segment("webPubSub")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(63)
        resourceName: string,
      },
      {
        /**
         * The name of the shared private link resource.
         */
        @path
        @segment("sharedPrivateLinkResources")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$")
        @minLength(3)
        @maxLength(63)
        sharedPrivateLinkResourceName: string,
      }
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is WebPubSubSharedPrivateLinkResourceOps.DeleteSync<
    SharedPrivateLinkResource,
    Response =
      | OkResponse
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
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
