import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ApplicationInsights;
@doc("An Application Insights workbook template definition.")
model WorkbookTemplate is TrackedResource<WorkbookTemplateProperties> {
  @doc("The name of the Application Insights component resource.")
  @path
  @key("resourceName")
  @segment("workbooktemplates")
  name: string;
}

@armResourceOperations
interface WorkbookTemplates {
  @doc("Get a single workbook template by its resourceName.")
  get is ArmResourceRead<WorkbookTemplate>;
  @doc("Create a new workbook template.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WorkbookTemplate>;
  @doc("Updates a workbook template that has already been added.")
  update is ArmResourcePatchSync<WorkbookTemplate, WorkbookTemplateProperties>;
  @doc("Delete a workbook template.")
  delete is ArmResourceDeleteSync<WorkbookTemplate>;
  @doc("Get all Workbook templates defined within a specified resource group.")
  listByResourceGroup is ArmResourceListByParent<WorkbookTemplate>;
}
