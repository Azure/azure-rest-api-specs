import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

using ApplicationInsightsCommonTypes;

namespace DeletedWorkbookApi;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * A workbook definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedWorkbook extends DeletedWorkbookResource {
  /**
   * Metadata describing a workbook for an Azure resource.
   */
  properties?: DeletedWorkbookProperties;
}

/**
 * Properties that contain a workbook.
 */
model DeletedWorkbookProperties {
  /**
   * The user-defined name (display name) of the workbook.
   */
  displayName: string;

  /**
   * Configuration of this particular workbook. Configuration data is a string containing valid JSON
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serializedData: string | null;

  /**
   * Workbook schema version format, like 'Notebook/1.0', which should match the workbook in serializedData
   */
  version?: string;

  /**
   * Date and time in UTC of the last modification that was made to this workbook definition.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * Workbook category, as defined by the user at creation time.
   */
  category: string;

  /**
   * Being deprecated, please use the other tags field
   */
  tags?: string[];

  /**
   * Unique user id of the specific user that owns this workbook.
   */
  @visibility(Lifecycle.Read)
  userId?: string;

  /**
   * ResourceId for a source resource.
   */
  sourceId?: string;

  /**
   * The resourceId to the storage account when bring your own storage is used
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  storageUri?: string | null;

  /**
   * The description of the workbook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * The unique revision id for this workbook definition
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  revision?: string | null;
}

/**
 * An azure resource object
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedWorkbookResource
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * The kind of workbook. Only valid value is shared.
   */
  kind?: WorkbookSharedTypeKind;

  /**
   * Resource etag
   */
  etag?: string;
}

/**
 * Error response.
 */
@error
model DeletedWorkbookError {
  /**
   * The error details.
   */
  error?: DeletedWorkbookErrorDefinition;
}

/**
 * Error definition.
 */
model DeletedWorkbookErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Internal error details.
   */
  @visibility(Lifecycle.Read)
  innererror?: DeletedWorkbookInnerErrorTrace;
}

/**
 * Error details
 */
model DeletedWorkbookInnerErrorTrace {
  /**
   * detailed error trace
   */
  @visibility(Lifecycle.Read)
  trace?: string[];
}

/**
 * Workbook list result.
 */
model DeletedWorkbooksListResult {
  /**
   * An array of workbooks.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: DeletedWorkbook[];

  /**
   * The link to the next page of results.
   */
  @nextLink
  nextLink?: url;
}
