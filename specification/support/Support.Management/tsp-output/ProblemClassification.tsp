import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * ProblemClassification resource object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Service)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ProblemClassificationProperties
)
model ProblemClassification extends ProxyResourceBase {
  /**
   * Name of problem classification.
   */
  @path
  @key("problemClassificationName")
  @segment("problemClassifications")
  @visibility("read")
  name: string;

  /**
   * Properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProblemClassificationProperties;
}

@armResourceOperations
interface ProblemClassifications {
  /**
   * Get problem classification details for a specific Azure service.
   */
  get is ArmResourceRead<ProblemClassification>;

  /**
   * Lists all the problem classifications (categories) available for a specific Azure service. Always use the service and problem classifications obtained programmatically. This practice ensures that you always have the most recent set of service and problem classification Ids.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProblemClassifications_List")
  list is ArmResourceListByParent<ProblemClassification>;
}
