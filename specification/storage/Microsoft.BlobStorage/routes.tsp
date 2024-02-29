import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";

import "./models.tsp";

namespace Microsoft.BlobStorage;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@route("?restype=service&comp=properties")
interface BlobServiceProperties {
  @doc("""
  Get the properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
  """)
  @put
  Service_SetProperties(
    @body body: StorageServiceProperties;
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`: string;
  ): {
    @statusCode statusCode: 202;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;

  @get
  Service_GetProperties(
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`: string;
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceProperties;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;
}
