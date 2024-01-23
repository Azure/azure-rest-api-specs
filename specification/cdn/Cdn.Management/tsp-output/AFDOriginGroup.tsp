import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * AFDOrigin group comprising of origins is used for load balancing to origins when the content cannot be served from CDN.
 */
@parentResource(Profile)
model AFDOriginGroup is ProxyResource<AFDOriginGroupProperties> {
  /**
   * Name of the origin group which is unique within the endpoint.
   */
  @path
  @key("originGroupName")
  @segment("originGroups")
  name: string;
}

@armResourceOperations
interface AFDOriginGroups {
  /**
   * Gets an existing origin group within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOriginGroups_Get")
  get is ArmResourceRead<AFDOriginGroup>;

  /**
   * Creates a new origin group within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOriginGroups_Create")
  create is ArmResourceCreateOrReplaceAsync<
    AFDOriginGroup,
    BaseParameters<AFDOriginGroup>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing origin group within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("FrontDoorOriginGroups_Update")
  update is ArmCustomPatchAsync<
    AFDOriginGroup,
    AFDOriginGroupUpdateParameters,
    BaseParameters<AFDOriginGroup>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing origin group within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOriginGroups_Delete")
  delete is ArmResourceDeleteAsync<
    AFDOriginGroup,
    BaseParameters<AFDOriginGroup>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the existing origin groups within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOriginGroups_ListByProfile")
  listByProfile is ArmResourceListByParent<AFDOriginGroup>;

  /**
   * Checks the quota and actual usage of the given AzureFrontDoor origin group under the given CDN profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorOriginGroups_ListResourceUsage")
  listResourceUsage is ArmResourceActionSync<
    AFDOriginGroup,
    void,
    UsagesListResult
  >;
}

@@projectedName(AFDOriginGroups.create::parameters.resource,
  "json",
  "originGroup"
);
@@extension(AFDOriginGroups.create::parameters.resource,
  "x-ms-client-name",
  "originGroup"
);
@@doc(AFDOriginGroups.create::parameters.resource, "Origin group properties");
@@projectedName(AFDOriginGroups.update::parameters.properties,
  "json",
  "originGroupUpdateProperties"
);
@@extension(AFDOriginGroups.update::parameters.properties,
  "x-ms-client-name",
  "originGroupUpdateProperties"
);
@@doc(AFDOriginGroups.update::parameters.properties, "Origin group properties");
