import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace ApplicationInsightsCommonTypes;

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a WebTest instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CategoryType {
  string,

  /**
   * workbook
   */
  workbook: "workbook",

  /**
   * TSG
   */
  TSG: "TSG",

  /**
   * performance
   */
  performance: "performance",

  /**
   * retention
   */
  retention: "retention",
}

/**
 * The kind of workbook. Only valid value is shared.
 */
union WorkbookSharedTypeKind {
  string,

  /**
   * shared
   */
  shared: "shared",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ErrorResponseLinkedStorage {
  /**
   * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
   */
  error?: ErrorResponseLinkedStorageError;
}

/**
 * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorResponseLinkedStorageError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}
