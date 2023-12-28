import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ApplicationInsights;
@doc("An Application Insights private workbook definition.")
model MyWorkbook is ProxyResource<MyWorkbookProperties> {
  @doc("The name of the Application Insights component resource.")
  @key("resourceName")
  @segment("myWorkbooks")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface MyWorkbooks {
  @doc("Get a single private workbook by its resourceName.")
  get is ArmResourceRead<MyWorkbook>;
  @doc("Create a new private workbook.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MyWorkbook,
    {
      ...BaseParameters<MyWorkbook>;

      @doc("Azure Resource Id that will fetch all linked workbooks.")
      @query("sourceId")
      sourceId?: string;
    }
  >;
  @doc("Updates a private workbook that has already been added.")
  update is ArmCustomPatchSync<
    MyWorkbook,
    MyWorkbook,
    {
      ...BaseParameters<MyWorkbook>;

      @doc("Azure Resource Id that will fetch all linked workbooks.")
      @query("sourceId")
      sourceId?: string;
    }
  >;
  @doc("Delete a private workbook.")
  delete is ArmResourceDeleteSync<MyWorkbook>;
  @doc("Get all private workbooks defined within a specified resource group and category.")
  listByResourceGroup is ArmResourceListByParent<
    MyWorkbook,
    {
      ...BaseParameters<MyWorkbook>;

      @doc("Category of workbook to return.")
      @query("category")
      category: CategoryType;

      @doc("Tags presents on each workbook returned.")
      @query({
        name: "tags",
        format: "csv",
      })
      tags?: string[];

      @doc("Azure Resource Id that will fetch all linked workbooks.")
      @query("sourceId")
      sourceId?: string;

      @doc("Flag indicating whether or not to return the full content for each applicable workbook. If false, only return summary content for workbooks.")
      @query("canFetchContent")
      canFetchContent?: boolean;
    }
  >;
  @doc("Get all private workbooks defined within a specified subscription and category.")
  listBySubscription is ArmListBySubscription<MyWorkbook>;
}
