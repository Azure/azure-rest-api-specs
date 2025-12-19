import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Update details
 */
@parentResource(Cluster)
model Update is Azure.ResourceManager.ProxyResource<UpdateProperties> {
  ...ResourceNameParameter<
    Resource = Update,
    KeyName = "updateName",
    SegmentName = "updates",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface Updates {
  /**
   * Get specified Update
   */
  get is ArmResourceRead<Update>;

  /**
   * Put specified Update
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  put is ArmResourceCreateOrReplaceSync<
    Update,
    Response = ArmResourceUpdatedResponse<Update>
  >;

  /**
   * Delete specified Update
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Update,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Updates
   */
  list is ArmResourceListByParent<Update, Response = ArmResponse<UpdateList>>;

  /**
   * Apply Update
   */
  @action("apply")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  post is ArmResourceActionAsync<
    Update,
    void,
    OkResponse,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Update.name, "The name of the Update");
@@doc(Update.properties, "Update properties");
@@doc(Updates.put::parameters.resource, "Properties of the Updates object");
