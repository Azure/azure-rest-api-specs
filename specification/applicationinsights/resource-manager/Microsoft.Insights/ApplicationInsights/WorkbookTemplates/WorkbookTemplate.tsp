import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace WorkbookTemplatesApi;
/**
 * An Application Insights workbook template definition.
 */
model WorkbookTemplate
  is Azure.ResourceManager.TrackedResource<WorkbookTemplateProperties> {
  ...ResourceNameParameter<
    Resource = WorkbookTemplate,
    KeyName = "resourceName",
    SegmentName = "workbooktemplates",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface WorkbookTemplates {
  /**
   * Get a single workbook template by its resourceName.
   */
  get is ArmResourceRead<WorkbookTemplate, Error = WorkbookTemplateError>;

  /**
   * Create a new workbook template.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    WorkbookTemplate,
    Error = WorkbookTemplateError
  >;

  /**
   * Updates a workbook template that has already been added.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    WorkbookTemplate,
    PatchModel = WorkbookTemplateUpdateParameters,
    OptionalRequestBody = true,
    Error = WorkbookTemplateError
  >;

  /**
   * Delete a workbook template.
   */
  delete is ArmResourceDeleteSync<
    WorkbookTemplate,
    Error = WorkbookTemplateError
  >;

  /**
   * Get all Workbook templates defined within a specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    WorkbookTemplate,
    Response = ArmResponse<WorkbookTemplatesListResult>,
    Error = WorkbookTemplateError
  >;
}

@@doc(WorkbookTemplate.name,
  "The name of the Application Insights component resource."
);
@@doc(WorkbookTemplate.properties,
  "Metadata describing a workbook template for an Azure resource."
);
@@doc(WorkbookTemplates.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new workbook."
);
@@doc(WorkbookTemplates.update::parameters.properties,
  "Properties that need to be specified to patch a workbook template."
);
