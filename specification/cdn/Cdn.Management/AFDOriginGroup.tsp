import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * AFDOrigin group comprising of origins is used for load balancing to origins when the content cannot be served from Azure Front Door.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@parentResource(Profile)
model AFDOriginGroup
  is Azure.ResourceManager.ProxyResource<AFDOriginGroupProperties> {
  ...ResourceNameParameter<
    Resource = AFDOriginGroup,
    KeyName = "originGroupName",
    SegmentName = "originGroups",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface AFDOriginGroups {
  /**
   * Gets an existing origin group within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AFDOriginGroups_Get")
  get is ArmResourceRead<AFDOriginGroup>;

  /**
   * Creates a new origin group within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("AFDOriginGroups_Create")
  create is ArmResourceCreateOrReplaceAsync<
    AFDOriginGroup,
    Response = ArmResourceUpdatedResponse<AFDOriginGroup> | ArmResourceCreatedResponse<AFDOriginGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDOriginGroup> &
      ArmLroLocationHeader<FinalResult = AFDOriginGroup>> & {
      @bodyRoot
      _: AFDOriginGroup;
    })
  >;

  /**
   * Updates an existing origin group within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("AFDOriginGroups_Update")
  update is ArmCustomPatchAsync<
    AFDOriginGroup,
    PatchModel = AFDOriginGroupUpdateParameters,
    Response = ArmResponse<AFDOriginGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDOriginGroup> &
      ArmLroLocationHeader<FinalResult = AFDOriginGroup> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AFDOriginGroup;
    })
  >;

  /**
   * Deletes an existing origin group within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("AFDOriginGroups_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AFDOriginGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing origin groups within a profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AFDOriginGroups_ListByProfile")
  listByProfile is ArmResourceListByParent<AFDOriginGroup>;

  /**
   * Checks the quota and actual usage of endpoints under the given Azure Front Door profile..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("usages")
  @operationId("AFDOriginGroups_ListResourceUsage")
  listResourceUsage is ArmResourceActionSync<
    AFDOriginGroup,
    void,
    ArmResponse<UsagesListResult>
  >;
}

@@doc(AFDOriginGroup.name,
  "Name of the origin group which is unique within the endpoint."
);
@@doc(AFDOriginGroup.properties,
  "The JSON object that contains the properties of the origin group."
);
@@doc(AFDOriginGroups.create::parameters.resource, "Origin group properties");
@@doc(AFDOriginGroups.update::parameters.properties, "Origin group properties");
