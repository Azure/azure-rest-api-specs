import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevHub;
/**
 * Resource representation of a Template
 */
@subscriptionResource
model Template is Azure.ResourceManager.ProxyResource<TemplateProperties> {
  ...ResourceNameParameter<
    Resource = Template,
    KeyName = "templateName",
    SegmentName = "templates",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface Templates {
  /**
   * Gets a list of supported templates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Template_Get")
  get is ArmResourceRead<
    Template,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets a list of supported templates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Template_List")
  list is ArmResourceListByParent<
    Template,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@maxLength(Template.name, 63);
@@minLength(Template.name, 1);
@@doc(Template.name, "The name of the Template.");
@@doc(Template.properties, "Properties of a Template.");
