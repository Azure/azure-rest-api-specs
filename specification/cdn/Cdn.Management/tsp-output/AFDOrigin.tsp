import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AFDOriginGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * CDN origin is the source of the content being delivered via CDN. When the edge nodes represented by an endpoint do not have the requested content cached, they attempt to fetch it from one or more of the configured origins.
 */
@parentResource(AFDOriginGroup)
model AFDOrigin is ProxyResource<AFDOriginProperties> {
  /**
   * Name of the origin which is unique within the profile.
   */
  @path
  @key("originName")
  @segment("origins")
  name: string;
}

@armResourceOperations
interface AFDOrigins {
  /**
   * Gets an existing origin within an origin group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOrigins_Get")
  get is ArmResourceRead<AFDOrigin>;

  /**
   * Creates a new origin within the specified origin group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOrigins_Create")
  create is ArmResourceCreateOrReplaceAsync<
    AFDOrigin,
    BaseParameters<AFDOrigin>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing origin within an origin group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("FrontDoorOrigins_Update")
  update is ArmCustomPatchAsync<
    AFDOrigin,
    AFDOriginUpdateParameters,
    BaseParameters<AFDOrigin>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing origin within an origin group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOrigins_Delete")
  delete is ArmResourceDeleteAsync<
    AFDOrigin,
    BaseParameters<AFDOrigin>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the existing origins within an origin group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOrigins_ListByOriginGroup")
  listByOriginGroup is ArmResourceListByParent<AFDOrigin>;
}

@@projectedName(AFDOrigins.create::parameters.resource, "json", "origin");
@@extension(AFDOrigins.create::parameters.resource,
  "x-ms-client-name",
  "origin"
);
@@doc(AFDOrigins.create::parameters.resource, "Origin properties");
@@projectedName(AFDOrigins.update::parameters.properties,
  "json",
  "originUpdateProperties"
);
@@extension(AFDOrigins.update::parameters.properties,
  "x-ms-client-name",
  "originUpdateProperties"
);
@@doc(AFDOrigins.update::parameters.properties, "Origin properties");
