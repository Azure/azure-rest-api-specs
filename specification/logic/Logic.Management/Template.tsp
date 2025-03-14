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

// @added(Versions.v2025_06_01_preview)
@doc("The template type.")
model Template is TrackedResource<TemplateProperties> {
  ...ResourceNameParameter<
    Resource = Template,
    KeyName = "templateName",
    SegmentName = "templates",
    NamePattern = "[a-zA-Z0-9_.()-]{0,79}$"
  >;
}

// @added(Versions.v2025_06_01_preview)
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
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters,
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
}

@@doc(Template.name, "The template name.");
@@doc(Template.properties, "The template properties.");
@@doc(Templates.createOrUpdate::parameters.resource, "The template.");
