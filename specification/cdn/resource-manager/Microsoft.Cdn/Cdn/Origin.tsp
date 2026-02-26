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
 * CDN origin is the source of the content being delivered via CDN. When the edge nodes represented by an endpoint do not have the requested content cached, they attempt to fetch it from one or more of the configured origins.
 */
@parentResource(Endpoint)
model Origin is Azure.ResourceManager.ProxyResource<OriginProperties> {
  ...ResourceNameParameter<
    Resource = Origin,
    KeyName = "originName",
    SegmentName = "origins",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Origins {
  /**
   * Gets an existing origin within an endpoint.
   */
  get is ArmResourceRead<Origin>;

  /**
   * Creates a new origin within the specified endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    Origin,
    Response = ArmResourceUpdatedResponse<Origin> | ArmResourceCreatedResponse<
      Origin,
      ArmLroLocationHeader<FinalResult = Origin> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Origin>> & {
      @bodyRoot
      _: Origin;
    })
  >;

  /**
   * Updates an existing origin within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Origin,
    PatchModel = OriginUpdateParameters,
    Response = ArmResponse<Origin> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Origin>> & {
      @bodyRoot
      _: Origin;
    })
  >;

  /**
   * Deletes an existing origin within an endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Origin,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing origins within an endpoint.
   */
  @list
  listByEndpoint is ArmResourceListByParent<Origin>;
}

@@doc(Origin.name, "Name of the origin which is unique within the endpoint.");
@@doc(Origin.properties,
  "The JSON object that contains the properties of the origin."
);
@@doc(Origins.create::parameters.resource, "Origin properties");
@@doc(Origins.update::parameters.properties, "Origin properties");
