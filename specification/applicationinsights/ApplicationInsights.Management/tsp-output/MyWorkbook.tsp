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
 * An Application Insights private workbook definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(MyWorkbookProperties)
@includeInapplicableMetadataInPayload(false)
model MyWorkbook extends ProxyResourceBase {
  /**
   * The name of the Application Insights component resource.
   */
  @path
  @key("resourceName")
  @segment("myWorkbooks")
  name: string;

  /**
   * The kind of workbook. Choices are user and shared.
   */
  kind?: Kind;

  /**
   * Metadata describing a workbook for an Azure resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MyWorkbookProperties;
}

@armResourceOperations
interface MyWorkbooks {
  /**
   * Get a single private workbook by its resourceName.
   */
  get is ArmResourceRead<MyWorkbook>;

  /**
   * Create a new private workbook.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MyWorkbook,
    {
      ...BaseParameters<MyWorkbook>;

      /**
       * Azure Resource Id that will fetch all linked workbooks.
       */
      @query("sourceId")
      sourceId?: string;
    }
  >;

  /**
   * Updates a private workbook that has already been added.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    MyWorkbook,
    MyWorkbook,
    {
      ...BaseParameters<MyWorkbook>;

      /**
       * Azure Resource Id that will fetch all linked workbooks.
       */
      @query("sourceId")
      sourceId?: string;
    }
  >;

  /**
   * Delete a private workbook.
   */
  delete is ArmResourceDeleteSync<MyWorkbook>;

  /**
   * Get all private workbooks defined within a specified resource group and category.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MyWorkbooks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    MyWorkbook,
    {
      ...BaseParameters<MyWorkbook>;

      /**
       * Category of workbook to return.
       */
      @query("category")
      category: CategoryType;

      /**
       * Tags presents on each workbook returned.
       */
      @query({
        name: "tags",
        format: "csv",
      })
      tags?: string[];

      /**
       * Azure Resource Id that will fetch all linked workbooks.
       */
      @query("sourceId")
      sourceId?: string;

      /**
       * Flag indicating whether or not to return the full content for each applicable workbook. If false, only return summary content for workbooks.
       */
      @query("canFetchContent")
      canFetchContent?: boolean;
    }
  >;

  /**
   * Get all private workbooks defined within a specified subscription and category.
   */
  listBySubscription is ArmListBySubscription<MyWorkbook>;
}

@@projectedName(MyWorkbooks.createOrUpdate::parameters.resource,
  "json",
  "workbookProperties"
);
@@extension(MyWorkbooks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workbookProperties"
);
@@doc(MyWorkbooks.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new private workbook."
);
@@projectedName(MyWorkbooks.update::parameters.properties,
  "json",
  "workbookProperties"
);
@@extension(MyWorkbooks.update::parameters.properties,
  "x-ms-client-name",
  "workbookProperties"
);
@@doc(MyWorkbooks.update::parameters.properties,
  "Properties that need to be specified to create a new private workbook."
);
