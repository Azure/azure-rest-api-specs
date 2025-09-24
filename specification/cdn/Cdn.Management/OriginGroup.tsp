import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Endpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Origin group comprising of origins is used for load balancing to origins when the content cannot be served from CDN.
 */
@parentResource(Endpoint)
model OriginGroup
  is Azure.ResourceManager.ProxyResource<OriginGroupProperties> {
  ...ResourceNameParameter<
    Resource = OriginGroup,
    KeyName = "originGroupName",
    SegmentName = "originGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OriginGroups {
  /**
   * Gets an existing origin group within an endpoint.
   */
  get is ArmResourceRead<OriginGroup>;

  /**
   * Creates a new origin group within the specified endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    OriginGroup,
    Response = ArmResourceUpdatedResponse<OriginGroup> | ArmResourceCreatedResponse<
      OriginGroup,
      ArmLroLocationHeader<FinalResult = OriginGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OriginGroup>> & {
      @bodyRoot
      _: OriginGroup;
    })
  >;

  /**
   * Updates an existing origin group within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OriginGroup,
    PatchModel = OriginGroupUpdateParameters,
    Response = ArmResponse<OriginGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OriginGroup>> & {
      @bodyRoot
      _: OriginGroup;
    })
  >;

  /**
   * Deletes an existing origin group within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    OriginGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing origin groups within an endpoint.
   */
  @list
  listByEndpoint is ArmResourceListByParent<OriginGroup>;
}

@@doc(OriginGroup.name,
  "Name of the origin group which is unique within the endpoint."
);
@@doc(OriginGroup.properties,
  "The JSON object that contains the properties of the origin group."
);
@@doc(OriginGroups.create::parameters.resource, "Origin group properties");
@@doc(OriginGroups.update::parameters.properties, "Origin group properties");
