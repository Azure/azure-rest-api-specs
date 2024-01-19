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
@doc("CDN origin is the source of the content being delivered via CDN. When the edge nodes represented by an endpoint do not have the requested content cached, they attempt to fetch it from one or more of the configured origins.")
@parentResource(AFDOriginGroup)
model AFDOrigin is ProxyResource<AFDOriginProperties> {
  @doc("Name of the origin which is unique within the profile.")
  @path
  @key("originName")
  @segment("origins")
  name: string;
}

@armResourceOperations
interface AFDOrigins {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an existing origin within an origin group.")
  @operationId("FrontDoorOrigins_Get")
  get is ArmResourceRead<AFDOrigin>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new origin within the specified origin group.")
  @operationId("FrontDoorOrigins_Create")
  create is ArmResourceCreateOrUpdateAsync<
    AFDOrigin,
    BaseParameters<AFDOrigin>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing origin within an origin group.")
  @operationId("FrontDoorOrigins_Update")
  update is ArmCustomPatchAsync<
    AFDOrigin,
    AFDOriginUpdateParameters,
    BaseParameters<AFDOrigin>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing origin within an origin group.")
  @operationId("FrontDoorOrigins_Delete")
  delete is ArmResourceDeleteAsync<
    AFDOrigin,
    BaseParameters<AFDOrigin>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the existing origins within an origin group.")
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
