import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CdnEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Origin group comprising of origins is used for load balancing to origins when the content cannot be served from CDN.
 */
@parentResource(CdnEndpoint)
model CdnOriginGroup is ProxyResource<OriginGroupProperties> {
  /**
   * Name of the origin group which is unique within the endpoint.
   */
  @path
  @key("originGroupName")
  @segment("originGroups")
  name: string;
}

@armResourceOperations
interface CdnOriginGroups {
  /**
   * Gets an existing origin group within an endpoint.
   */
  get is ArmResourceRead<CdnOriginGroup>;

  /**
   * Creates a new origin group within the specified endpoint.
   */
  create is ArmResourceCreateOrReplaceAsync<CdnOriginGroup>;

  /**
   * Updates an existing origin group within an endpoint.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<CdnOriginGroup, OriginGroupUpdateParameters>;

  /**
   * Deletes an existing origin group within an endpoint.
   */
  delete is ArmResourceDeleteAsync<CdnOriginGroup>;

  /**
   * Lists all of the existing origin groups within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CdnOriginGroups_ListByEndpoint")
  listByEndpoint is ArmResourceListByParent<CdnOriginGroup>;
}

@@projectedName(CdnOriginGroups.create::parameters.resource,
  "json",
  "originGroup"
);
@@extension(CdnOriginGroups.create::parameters.resource,
  "x-ms-client-name",
  "originGroup"
);
@@doc(CdnOriginGroups.create::parameters.resource, "Origin group properties");
@@projectedName(CdnOriginGroups.update::parameters.properties,
  "json",
  "originGroupUpdateProperties"
);
@@extension(CdnOriginGroups.update::parameters.properties,
  "x-ms-client-name",
  "originGroupUpdateProperties"
);
@@doc(CdnOriginGroups.update::parameters.properties, "Origin group properties");
