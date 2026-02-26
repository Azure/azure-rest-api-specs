import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AFDOriginGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Azure Front Door origin is the source of the content being delivered via Azure Front Door. When the edge nodes represented by an endpoint do not have the requested content cached, they attempt to fetch it from one or more of the configured origins.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(AFDOriginGroup)
model AFDOrigin is Azure.ResourceManager.ProxyResource<AFDOriginProperties> {
  ...ResourceNameParameter<
    Resource = AFDOrigin,
    KeyName = "originName",
    SegmentName = "origins",
    NamePattern = ""
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AFDOrigins {
  /**
   * Gets an existing origin within an origin group.
   */
  get is ArmResourceRead<AFDOrigin>;

  /**
   * Creates a new origin within the specified origin group.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    AFDOrigin,
    Response = ArmResourceUpdatedResponse<AFDOrigin> | ArmResourceCreatedResponse<AFDOrigin> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AFDOrigin>> & {
      @bodyRoot
      _: AFDOrigin;
    })
  >;

  /**
   * Updates an existing origin within an origin group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AFDOrigin,
    PatchModel = AFDOriginUpdateParameters,
    Response = ArmResponse<AFDOrigin> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDOrigin> &
      ArmLroLocationHeader<FinalResult = AFDOrigin>> & {
      @bodyRoot
      _: AFDOrigin;
    })
  >;

  /**
   * Deletes an existing origin within an origin group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    AFDOrigin,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing origins within an origin group.
   */
  @list
  listByOriginGroup is ArmResourceListByParent<AFDOrigin>;
}

@@doc(AFDOrigin.name, "Name of the origin which is unique within the profile.");
@@doc(AFDOrigin.properties,
  "The JSON object that contains the properties of the origin."
);
@@doc(AFDOrigins.create::parameters.resource, "Origin properties");
@@doc(AFDOrigins.update::parameters.properties, "Origin properties");
