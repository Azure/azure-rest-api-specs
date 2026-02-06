import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Http;

@doc("Supported HTTP request methods")
union HttpMethod {
  @doc("HTTP GET method")
  GET: "GET",

  @doc("HTTP POST method")
  POST: "POST",

  string,
}

@doc("Supported HTTP pagination methods")
union PaginationMethod {
  @doc("Pagination using page-based pagination")
  Page: "Page",

  @doc("Pagination using cursor-based pagination")
  Cursor: "Cursor",

  string,
}

@doc("HTTP key-value pair")
model HttpKeyValuePair {
  @doc("HTTP header, request parameter, or path variable name")
  key: string;

  @doc("Value associated with the key")
  value: string;
}

@doc("HTTP pagination information")
@discriminator("type")
model Pagination {
  @doc("Type of pagination")
  type: PaginationMethod;
}

@doc("HTTP Page pagination information")
model PagePagination extends Pagination {
  @doc("Type of pagination")
  type: PaginationMethod.Page;

  @doc("Initial value for pagination. For cursor-based pagination, this is the initial cursor value. For page-based pagination, this is the initial page number.")
  paginationInitialValue?: string;

  @doc("Number of items to increment per page when using page-based pagination.")
  pageIncrement?: int32;
}

@doc("HTTP Cursor pagination information")
model CursorPagination extends Pagination {
  @doc("Type of pagination")
  type: PaginationMethod.Cursor;

  @doc("Initial value for pagination. For cursor-based pagination, this is the initial cursor value. For page-based pagination, this is the initial page number.")
  paginationInitialValue?: string;

  @doc("JSON Pointer expression to extract the cursor value from HTTP response body when using cursor-based pagination.")
  cursorJsonPointer?: string;
}

@doc("Configuration for HttpSourceConnector")
model HttpSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of HttpSourceConnector")
  connectorType: Models.Connector.ConnectorType.HttpSource;

  @doc("HTTP URL to fetch from.")
  url: url;

  @doc("HTTP request method. GET or POST.")
  method: HttpMethod;

  @Azure.ResourceManager.identifiers(#[])
  @doc("HTTP parameters to be added to request.")
  requestParameters?: HttpKeyValuePair[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("Path variables to be substituted.")
  pathVariables?: HttpKeyValuePair[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("HTTP headers to include in the request.")
  headers?: HttpKeyValuePair[];

  @doc("HTTP request body sent with POST request.")
  body?: string;

  @doc("Polling interval in milliseconds.")
  pollIntervalMs?: int32;

  @doc("Maximum number of retry attempts on error before failing the task.")
  @minValue(0)
  @maxValue(100)
  maxRetries?: int32;

  @doc("Time to wait in ms before retrying after an error.")
  retryBackoffMs?: int32;

  @doc("HTTP status code or ranges to retry on. eg: 400, or 400- means code large than 400")
  retriableHttpStatusCodes?: string;

  @doc("Authentication for HTTP")
  authentication: Models.Auth.Authentication;

  @doc("JSON Pointer expression to extract data from HTTP response body.")
  responseDataJsonPointer?: string;

  @doc("HTTP pagination to use.")
  pagination?: Pagination;
}
