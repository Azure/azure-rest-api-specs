import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

using ApplicationInsightsCommonTypes;

namespace WorkbooksApi;
/**
 * A workbook definition.
 */
model Workbook is Azure.ResourceManager.TrackedResource<WorkbookProperties> {
  ...ResourceNameParameter<
    Resource = Workbook,
    KeyName = "resourceName",
    SegmentName = "workbooks",
    NamePattern = ""
  >;

  /**
   * Identity used for BYOS
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: WorkbookResourceIdentity;

  /**
   * The kind of workbook. Only valid value is shared.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: WorkbookSharedTypeKind;

  /**
   * Resource etag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

alias WorkbookOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the workbook resource. The value must be an UUID. */
    @path
    @segment("workbooks")
    @key
    resourceName: string;
  },
  ErrorType = WorkbookError
>;

@armResourceOperations(#{ omitTags: true })
interface Workbooks {
  /**
   * Get a single workbook by its resourceName.
   */
  get is WorkbookOps.Read<
    Workbook,
    Parameters = {
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
  createOrUpdate is WorkbookOps.CreateOrUpdateSync<
    Workbook,
    Parameters = {
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
  @patch(#{ implicitOptionality: false })
  update is WorkbookOps.CustomPatchSync<
    Workbook,
    PatchModel = WorkbookUpdateParameters,
    Parameters = {
      /**
       * Azure Resource Id that will fetch all linked workbooks.
       */
      @query("sourceId")
      sourceId?: string;
    },
    Response = ArmResponse<Workbook> | ArmResourceCreatedSyncResponse<Workbook>,
    OptionalRequestBody = true
  >;

  /**
   * Delete a workbook.
   */
  delete is WorkbookOps.DeleteSync<Workbook>;

  /**
   * Get all Workbooks defined within a specified subscription and category.
   */
  listBySubscription is ArmListBySubscription<
    Workbook,
    Parameters = {
      /**
       * Category of workbook to return.
       */
      @query("category")
      category: CategoryType;

      /**
       * Tags presents on each workbook returned.
       */
      @query("tags")
      tags?: string[];

      /**
       * Flag indicating whether or not to return the full content for each applicable workbook. If false, only return summary content for workbooks.
       */
      @query("canFetchContent")
      canFetchContent?: boolean;
    },
    Response = ArmResponse<WorkbooksListResult>,
    Error = WorkbookError
  >;

  /**
   * Get the revisions for the workbook defined by its resourceName.
   */
  revisionsList is WorkbookOperationGroupOps.List<
    Workbook,
    Response = ArmResponse<WorkbooksListResult>
  >;
}
alias WorkbookOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the workbook resource. The value must be an UUID. */
    @path
    @segment("workbooks")
    @key
    resourceName: string;
  },
  {
    /** The id of the workbook's revision. */
    @path
    @segment("revisions")
    @key
    revisionId: string;
  },
  ErrorType = WorkbookError
>;

@armResourceOperations(#{ omitTags: true })
interface WorkbookOperationGroup {
  /**
   * Get a single workbook revision defined by its revisionId.
   */
  revisionGet is WorkbookOperationGroupOps.Read<Workbook>;

  /**
   * Get all Workbooks defined within a specified resource group and category.
   */
  listByResourceGroup is WorkbookOps.List<
    Workbook,
    Parameters = {
      /**
       * Category of workbook to return.
       */
      @query("category")
      category: CategoryType;

      /**
       * Tags presents on each workbook returned.
       */
      @query("tags")
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
    },
    Response = ArmResponse<WorkbooksListResult>
  >;
}

@@doc(Workbook.name,
  "The name of the workbook resource. The value must be an UUID."
);
@@doc(Workbook.properties,
  "Metadata describing a workbook for an Azure resource."
);
@@doc(Workbooks.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new workbook."
);
@@doc(Workbooks.update::parameters.properties,
  "Properties that need to be specified to create a new workbook."
);
