import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

using ApplicationInsightsCommonTypes;

namespace WorkbooksApi;

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
 * The kind of workbook. Only valid value is shared.
 */
union WorkbookUpdateSharedTypeKind {
  string,

  /**
   * shared
   */
  shared: "shared",
}

/**
 * Properties that contain a workbook.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkbookProperties {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
model WorkbookResource
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * Identity used for BYOS
   */
  identity?: WorkbookResourceIdentity;

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
 * Identity used for BYOS
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkbookResourceIdentity
  extends Azure.ResourceManager.CommonTypes.ManagedServiceIdentity {}

/**
 * Error response.
 */
@error
model WorkbookError {
  /**
   * The error details.
   */
  error?: WorkbookErrorDefinition;
}

/**
 * Error definition.
 */
model WorkbookErrorDefinition {
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
  innererror?: WorkbookInnerErrorTrace;
}

/**
 * Error details
 */
model WorkbookInnerErrorTrace {
  /**
   * detailed error trace
   */
  @visibility(Lifecycle.Read)
  trace?: string[];
}

/**
 * The parameters that can be provided when updating workbook properties properties.
 */
model WorkbookUpdateParameters {
  /**
   * The kind of workbook. Only valid value is shared.
   */
  kind?: WorkbookUpdateSharedTypeKind;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * Metadata describing a workbook for an Azure resource.
   */
  properties?: WorkbookPropertiesUpdateParameters;
}

/**
 * Properties that contain a workbook for PATCH operation.
 */
model WorkbookPropertiesUpdateParameters {
  /**
   * The user-defined name (display name) of the workbook.
   */
  displayName?: string;

  /**
   * Configuration of this particular workbook. Configuration data is a string containing valid JSON
   */
  serializedData?: string;

  /**
   * Workbook category, as defined by the user at creation time.
   */
  category?: string;

  /**
   * A list of 0 or more tags that are associated with this workbook definition
   */
  tags?: string[];

  /**
   * The description of the workbook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * The unique revision id for this workbook definition
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  revision?: string | null;
}

/**
 * Workbook list result.
 */
model WorkbooksListResult {
  /**
   * An array of workbooks.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Workbook[];

  /**
   * The link to the next page of results.
   */
  @nextLink
  nextLink?: url;
}
