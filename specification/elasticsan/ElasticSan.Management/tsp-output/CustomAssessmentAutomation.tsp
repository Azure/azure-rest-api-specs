import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Custom Assessment Automation")
model CustomAssessmentAutomation
  is ProxyResource<CustomAssessmentAutomationProperties> {
  @doc("Name of the Custom Assessment Automation.")
  @path
  @key("customAssessmentAutomationName")
  @segment("customAssessmentAutomations")
  name: string;
}

@armResourceOperations
interface CustomAssessmentAutomations {
  @doc("Gets a single custom assessment automation by name for the provided subscription and resource group.")
  get is ArmResourceRead<CustomAssessmentAutomation>;

  @doc("Creates or updates a custom assessment automation for the provided subscription. Please note that providing an existing custom assessment automation will replace the existing record.")
  create is ArmResourceCreateOrReplaceSync<CustomAssessmentAutomation>;

  @doc("Deletes a custom assessment automation by name for a provided subscription")
  delete is ArmResourceDeleteSync<CustomAssessmentAutomation>;

  @doc("List custom assessment automations by provided subscription and resource group")
  listByResourceGroup is ArmResourceListByParent<CustomAssessmentAutomation>;

  @doc("List custom assessment automations by provided subscription")
  listBySubscription is ArmListBySubscription<CustomAssessmentAutomation>;
}

@@projectedName(CustomAssessmentAutomations.create::parameters.resource,
  "json",
  "customAssessmentAutomationBody"
);
@@extension(CustomAssessmentAutomations.create::parameters.resource,
  "x-ms-client-name",
  "customAssessmentAutomationBody"
);
@@doc(CustomAssessmentAutomations.create::parameters.resource,
  "Custom Assessment Automation body"
);
