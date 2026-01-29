import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("ServiceClassifications")
@added(Versions.v2025_06_01_preview)
interface ClassifyServices {
  /**
   * Classify the list of right Azure services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceClassifications_classifyServices")
  @autoRoute
  classifyServices is ArmProviderActionSync<
    Request = ServiceClassificationRequest,
    Response = ServiceClassificationOutput,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("ServiceClassifications")
@added(Versions.v2025_06_01_preview)
interface ClassifyServicesNoSubscription {
  /**
   * Classify the list of right Azure services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceClassificationsNoSubscription_classifyServices")
  @autoRoute
  classifyServices is ArmProviderActionSync<
    Request = ServiceClassificationRequest,
    Response = ServiceClassificationOutput
  >;
}

@@doc(ClassifyServices.classifyServices::parameters.body, "Input to check.");
@@doc(ClassifyServicesNoSubscription.classifyServices::parameters.body,
  "Input to check."
);
