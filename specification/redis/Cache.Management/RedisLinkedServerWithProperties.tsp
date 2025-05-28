import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RedisResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * Response to put/get linked server (with properties) for Redis cache.
 */
@parentResource(RedisResource)
model RedisLinkedServerWithProperties
  is Azure.ResourceManager.ProxyResource<RedisLinkedServerProperties> {
  ...ResourceNameParameter<
    Resource = RedisLinkedServerWithProperties,
    KeyName = "linkedServerName",
    SegmentName = "linkedServers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LinkedServer {
  /**
   * Gets the detailed information about a linked server of a redis cache (requires Premium SKU).
   */
  get is ArmResourceRead<RedisLinkedServerWithProperties>;

  /**
   * Adds a linked server to the Redis cache (requires Premium SKU).
   */
  create is ArmResourceCreateOrReplaceAsync<
    RedisLinkedServerWithProperties,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the linked server from a redis cache (requires Premium SKU).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    RedisLinkedServerWithProperties,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Gets the list of linked servers associated with this redis cache (requires Premium SKU).
   */
  list is ArmResourceListByParent<
    RedisLinkedServerWithProperties,
    Response = ArmResponse<RedisLinkedServerWithPropertiesList>
  >;
}

@@doc(RedisLinkedServerWithProperties.name, "The name of the linked server.");
@@doc(RedisLinkedServerWithProperties.properties,
  "Properties of the linked server."
);
@@doc(LinkedServer.create::parameters.resource,
  "Parameters supplied to the Create Linked server operation."
);
