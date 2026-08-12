import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace WorkBookOperations;

/**
 * Result of the request to list Azure Workbooks operations.
 * It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of Workbook operations supported by the Microsoft.Insights resource provider.
   */
  @pageItems
  @identifiers(#["name"])
  value?: Operation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Azure Workbooks REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.Insights
   */
  provider?: string;

  /**
   * Resource on which the operation is performed: Profile, endpoint, etc.
   */
  resource?: string;

  /**
   * Operation type: Read, write, delete, etc.
   */
  operation?: string;
}

/**
 * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model ErrorResponse {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;

  /**
   * The list of invalid fields send in request, in case of validation error.
   */
  @identifiers(#["message", "target"])
  details?: ErrorFieldContract[];
}

/**
 * Error Field contract.
 */
model ErrorFieldContract {
  /**
   * Property level error code.
   */
  code?: string;

  /**
   * Human-readable representation of property-level error.
   */
  message?: string;

  /**
   * Property name.
   */
  target?: string;
}
