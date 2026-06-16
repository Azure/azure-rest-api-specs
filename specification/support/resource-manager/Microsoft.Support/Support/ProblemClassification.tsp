import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("ProblemClassifications")
@added(Versions.v2025_06_01_preview)
interface ClassifyProblems {
  /**
   * Classify the right problem classifications (categories) available for a specific Azure service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProblemClassifications_classifyProblems")
  @autoRoute
  classifyProblems is ArmProviderActionSync<
    Request = ProblemClassificationsClassificationInput,
    Response = ProblemClassificationsClassificationOutput,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Name of the Azure service for which the problem classifications need to be retrieved.
       */
      @pattern("^[0-9a-zA-Z_\\-. ]+$")
      @path
      @segment("services")
      @OpenAPI.extension("x-ms-parameter-location", "method")
      problemServiceName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("ProblemClassifications")
@added(Versions.v2025_06_01_preview)
interface ClassifyProblemsNoSubscription {
  /**
   * Classify the right problem classifications (categories) available for a specific Azure service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProblemClassificationsNoSubscription_classifyProblems")
  @autoRoute
  classifyProblems is ArmProviderActionSync<
    Request = ProblemClassificationsClassificationInput,
    Response = ProblemClassificationsClassificationOutput,
    Parameters = {
      /**
       * Name of the Azure service for which the problem classifications need to be retrieved.
       */
      @pattern("^[0-9a-zA-Z_\\-. ]+$")
      @path
      @segment("services")
      @OpenAPI.extension("x-ms-parameter-location", "method")
      problemServiceName: string;
    }
  >;
}

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

@@doc(ClassifyProblems.classifyProblems::parameters.body, "Input to check.");
@@doc(ClassifyProblemsNoSubscription.classifyProblems::parameters.body,
  "Input to check."
);
@@doc(ProblemClassification.name, "Name of problem classification.");
@@doc(ProblemClassification.properties, "Properties of the resource.");
