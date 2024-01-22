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

namespace Microsoft.Insights;
/**
 * An Application Insights workbook template definition.
 */
model WorkbookTemplate is TrackedResource<WorkbookTemplateProperties> {
  /**
   * The name of the Application Insights component resource.
   */
  @path
  @key("resourceName")
  @segment("workbooktemplates")
  name: string;
}

@armResourceOperations
interface WorkbookTemplates {
  /**
   * Get a single workbook template by its resourceName.
   */
  get is ArmResourceRead<WorkbookTemplate>;

  /**
   * Create a new workbook template.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<WorkbookTemplate>;

  /**
   * Updates a workbook template that has already been added.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    WorkbookTemplate,
    WorkbookTemplateUpdateParameters
  >;

  /**
   * Delete a workbook template.
   */
  delete is ArmResourceDeleteSync<WorkbookTemplate>;

  /**
   * Get all Workbook templates defined within a specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkbookTemplates_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<WorkbookTemplate>;
}

@@projectedName(WorkbookTemplates.createOrUpdate::parameters.resource,
  "json",
  "workbookTemplateProperties"
);
@@extension(WorkbookTemplates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workbookTemplateProperties"
);
@@doc(WorkbookTemplates.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new workbook."
);
@@projectedName(WorkbookTemplates.update::parameters.properties,
  "json",
  "WorkbookTemplateUpdateParameters"
);
@@extension(WorkbookTemplates.update::parameters.properties,
  "x-ms-client-name",
  "WorkbookTemplateUpdateParameters"
);
@@doc(WorkbookTemplates.update::parameters.properties,
  "Properties that need to be specified to patch a workbook template."
);
