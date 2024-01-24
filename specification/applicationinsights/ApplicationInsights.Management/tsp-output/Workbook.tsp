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
 * A workbook definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(WorkbookProperties)
@includeInapplicableMetadataInPayload(false)
model Workbook extends TrackedResourceBase {
  /**
   * The name of the resource.
   */
  @path
  @key("resourceName")
  @segment("workbooks")
  name: string;

  /**
   * Metadata describing a workbook for an Azure resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkbookProperties;
}

@armResourceOperations
interface Workbooks {
  /**
   * Get a single workbook by its resourceName.
   */
  get is ArmResourceRead<
    Workbook,
    {
      ...BaseParameters<Workbook>;

      /**
       * Flag indicating whether or not to return the full content for each applicable workbook. If false, only return summary content for workbooks.
       */
      @query("canFetchContent")
      canFetchContent?: boolean;
    }
  >;

  /**
   * Create a new workbook.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Workbook,
    {
      ...BaseParameters<Workbook>;

      /**
       * Azure Resource Id that will fetch all linked workbooks.
       */
      @query("sourceId")
      sourceId?: string;
    }
  >;

  /**
   * Updates a workbook that has already been added.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    Workbook,
    WorkbookUpdateParameters,
    {
      ...BaseParameters<Workbook>;

      /**
       * Azure Resource Id that will fetch all linked workbooks.
       */
      @query("sourceId")
      sourceId?: string;
    }
  >;

  /**
   * Delete a workbook.
   */
  delete is ArmResourceDeleteSync<Workbook>;

  /**
   * Get all Workbooks defined within a specified resource group and category.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workbooks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Workbook,
    {
      ...BaseParameters<Workbook>;

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
   * Get all Workbooks defined within a specified subscription and category.
   */
  listBySubscription is ArmListBySubscription<Workbook>;
}

@@projectedName(Workbooks.createOrUpdate::parameters.resource,
  "json",
  "workbookProperties"
);
@@extension(Workbooks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workbookProperties"
);
@@doc(Workbooks.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new workbook."
);
@@projectedName(Workbooks.update::parameters.properties,
  "json",
  "WorkbookUpdateParameters"
);
@@extension(Workbooks.update::parameters.properties,
  "x-ms-client-name",
  "WorkbookUpdateParameters"
);
@@doc(Workbooks.update::parameters.properties,
  "Properties that need to be specified to create a new workbook."
);
