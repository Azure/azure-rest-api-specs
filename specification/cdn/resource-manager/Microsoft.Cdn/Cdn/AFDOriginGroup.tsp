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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AFDOriginGroups {
  /**
   * Gets an existing origin group within a profile.
   */
  get is ArmResourceRead<AFDOriginGroup>;

  /**
   * Creates a new origin group within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    AFDOriginGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing origin groups within a profile.
   */
  @list
  listByProfile is ArmResourceListByParent<AFDOriginGroup>;

  /**
   * Checks the quota and actual usage of endpoints under the given Azure Front Door profile.
   */
  @action("usages")
  @list
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
