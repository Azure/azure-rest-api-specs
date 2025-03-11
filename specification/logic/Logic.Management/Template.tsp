import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./TemplateModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Logic;

@added(Versions.v2025_06_01_preview)
@doc("The template type.")
model Template is Azure.ResourceManager.TrackedResource<TemplateProperties> {
  ...ResourceNameParameter<
    Resource = Template,
    KeyName = "templateName",
    SegmentName = "templates",
    NamePattern = ""
  >;
}

@added(Versions.v2025_06_01_preview)
@armResourceOperations
interface Templates {
  @doc("Gets a template.")
  get is ArmResourceRead<Template>;

  @doc("Creates or updates a template.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Template>;

  @doc("Updates a template.")
  update is ArmResourcePatchSync<Template, TemplateProperties>;

  @doc("Deletes a template.")
  delete is ArmResourceDeleteSync<Template>;

  @doc("Gets a list of templates by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Template,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: State, Trigger, and ReferencedResourceId.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Gets a list of templates by subscription.")
  listBySubscription is ArmListBySubscription<
    Template,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: State, Trigger, and ReferencedResourceId.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Disables a template.")
  disable is ArmResourceActionSync<Template, void, OkResponse>;

  @doc("Enables a template.")
  enable is ArmResourceActionSync<Template, void, OkResponse>;

  @doc("Generates the upgraded definition for a template.")
  generateUpgradedDefinition is ArmResourceActionSync<
    Template,
    GenerateUpgradedDefinitionParameters,
    ArmResponse<Record<unknown>>
  >;

  @doc("Get the template callback Url.")
  listCallbackUrl is ArmResourceActionSync<
  Template,
    GetCallbackUrlParameters,
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;

  @doc("Gets an OpenAPI definition for the template.")
  listSwagger is ArmResourceActionSync<
  Template,
    void,
    ArmResponse<Record<unknown>>
  >;

  @doc("Moves an existing template.")
  move is ArmResourceActionAsync<Template, WorkflowReference, OkResponse>;

  @doc("Regenerates the callback URL access key for request triggers.")
  regenerateAccessKey is ArmResourceActionSync<
  Template,
    RegenerateActionParameter,
    OkResponse
  >;

  @doc("Validates the template.")
  @action("validate")
  validateByResourceGroup is ArmResourceActionSync<
  Template,
    Workflow,
    OkResponse
  >;
}

@@doc(Template.name, "The template name.");
@@doc(Template.properties, "The template properties.");
@@doc(Templates.createOrUpdate::parameters.resource, "The template.");
@@doc(Templates.generateUpgradedDefinition::parameters.body,
  "Parameters for generating an upgraded definition."
);
@@doc(Templates.listCallbackUrl::parameters.body,
  "Which callback url to list."
);
@@doc(Templates.move::parameters.body, "The template to move.");
@@doc(Templates.regenerateAccessKey::parameters.body, "The access key type.");
@@doc(Templates.validateByResourceGroup::parameters.body, "The template.");
