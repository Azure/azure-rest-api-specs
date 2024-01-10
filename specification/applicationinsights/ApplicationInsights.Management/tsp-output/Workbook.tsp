import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("A workbook definition.")
model Workbook is TrackedResource<WorkbookProperties> {
  @doc("The name of the resource.")
  @key("resourceName")
  @segment("workbooks")
  name: string;
}

@armResourceOperations
interface Workbooks {
  @doc("Get a single workbook by its resourceName.")
  get is ArmResourceRead<
    Workbook,
    {
      ...BaseParameters<Workbook>;

      @doc("Flag indicating whether or not to return the full content for each applicable workbook. If false, only return summary content for workbooks.")
      @query("canFetchContent")
      canFetchContent?: boolean;
    }
  >;

  @doc("Create a new workbook.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Workbook,
    {
      ...BaseParameters<Workbook>;

      @doc("Azure Resource Id that will fetch all linked workbooks.")
      @query("sourceId")
      sourceId?: string;
    }
  >;

  @doc("Updates a workbook that has already been added.")
  update is ArmCustomPatchSync<
    Workbook,
    WorkbookUpdateParameters,
    {
      ...BaseParameters<Workbook>;

      @doc("Azure Resource Id that will fetch all linked workbooks.")
      @query("sourceId")
      sourceId?: string;
    }
  >;

  @doc("Delete a workbook.")
  delete is ArmResourceDeleteSync<Workbook>;

  @doc("Get all Workbooks defined within a specified resource group and category.")
  listByResourceGroup is ArmResourceListByParent<
    Workbook,
    {
      ...BaseParameters<Workbook>;

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

  @doc("Get all Workbooks defined within a specified subscription and category.")
  listBySubscription is ArmListBySubscription<Workbook>;
}
