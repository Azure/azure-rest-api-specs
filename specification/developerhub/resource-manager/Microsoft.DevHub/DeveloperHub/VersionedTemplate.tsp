import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Template.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevHub;
/**
 * Resource representation of a VersionedTemplate
 */
@subscriptionResource
@parentResource(Template)
model VersionedTemplate
  is Azure.ResourceManager.ProxyResource<VersionedTemplateProperties> {
  ...ResourceNameParameter<
    Resource = VersionedTemplate,
    KeyName = "templateVersion",
    SegmentName = "versions",
    NamePattern = "^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)$"
  >;
}

@armResourceOperations
interface VersionedTemplates {
  /**
   * Gets a VersionedTemplate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VersionedTemplate_Get")
  get is ArmResourceRead<
    VersionedTemplate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets a list of VersionedTemplate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VersionedTemplate_List")
  list is ArmResourceListByParent<
    VersionedTemplate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Generates a VersionedTemplate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VersionedTemplate_Generate")
  generate is ArmResourceActionSync<
    VersionedTemplate,
    Record<string>,
    ArmResponse<GenerateVersionedTemplateResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@maxLength(VersionedTemplate.name, 63);
@@minLength(VersionedTemplate.name, 1);
@@doc(VersionedTemplate.name, "The template version.");
@@doc(VersionedTemplate.properties, "Properties of a VersionedTemplate.");
@@doc(VersionedTemplates.generate::parameters.body, "");
