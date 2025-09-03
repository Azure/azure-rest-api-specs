import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * ProblemClassification resource object.
 */
@parentResource(Service)
model ProblemClassification
  is Azure.ResourceManager.ProxyResource<ProblemClassificationProperties> {
  ...ResourceNameParameter<
    Resource = ProblemClassification,
    KeyName = "problemClassificationName",
    SegmentName = "problemClassifications",
    NamePattern = ""
  >;
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
  list is ArmResourceListByParent<
    ProblemClassification,
    Response = ArmResponse<ProblemClassificationsListResult>
  >;
}

@@doc(ProblemClassification.name, "Name of problem classification.");
@@doc(ProblemClassification.properties, "Properties of the resource.");
