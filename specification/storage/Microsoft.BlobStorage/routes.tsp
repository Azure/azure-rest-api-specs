import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";

import "./models.tsp";

namespace Microsoft.BlobStorage;

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;

@route("/?restype=service&comp=properties")
interface BlobServiceProperties {
  @doc("""
  Get the properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
  """)
  @put
  @operationId("Service_SetProperties")
  put(
    @doc("The storage service properties that specifies the analytics and CORS rules to set on the Blob service.")
    @body body: StorageServiceProperties;
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`?: string;
  ): {
    @statusCode statusCode: 202;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`?: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;

  @doc("Retrieves properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.")
  @operationId("Service_GetProperties")
  @get
  get(
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`?: string;
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceProperties;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`?: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;
}

@route("/?restype=service&comp=stats")
interface BlobServiceStatistics {
  @doc("""
  Retrieves statistics related to replication for the Blob service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account.
  """)
  @operationId("Service_GetStatistics")
  @get
  get(
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`?: string;
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceStats;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`?: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("UTC date/time value generated by the service that indicates the time at which the response was initiated")
    @encode("date-time-rfc1123")
    @header Date: utcDateTime;
  } | StorageError;
}

@route("/?comp=list")
interface ListContainerSegments {
  @doc("The List Containers Segment operation returns a list of the containers under the specified account")
  @get
  @operationId("Service_ListContainersSegment")
  get(
    @doc("Filters the results to return only containers whose name begins with the specified prefix.")
    @query prefix?: string;
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("A string value that identifies the portion of the list of containers to be returned with the next listing operation. The operation returns a non-empty continuation token if the listing operation did not return all containers remaining to be listed with the current segment. The continuation token value is opaque to the client.")
    @query marker?: string;
    @doc("Specifies the maximum number of containers to return. If the request does not specify maxresults or specifies a value greater than 5000, the server will return up to 5000 items.")
    @query maxresults?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`?: string;
  ): {
    @statusCode statusCode: 200;
    @body body: ListContainersSegmentResponse;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`?: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;
}

@route("/?restype=service&comp=userdelegationkey")
interface BlobServiceUserDelegationKey {
  @doc("The Get User Delegation Key operation gets the user delegation key for the Blob service. This is only a valid operation when using User Delegation SAS. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas\">Create a user delegation SAS</a>.")
  @post
  @operationId("Service_GetUserDelegationKey") 
  post(
    @doc("The user delegation key info.")
    @body body: KeyInfo;
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`?: string;
  ): {
    @statusCode statusCode: 200;
    @doc("The user delegation key.")
    @body body: UserDelegationKey;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`?: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;
}

@route("/?restype=account&comp=properties")
interface BlobServiceAccountProperties {
  @doc("Returns the sku name and account kind.")
  @get
  @operationId("Service_GetAccountInfo")
  get(
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  ): {
    @statusCode statusCode: 200;
    @doc("If a client request id header is sent in the request, this header will be present in the response with the same value.")
    @header `x-ms-client-request-id`?: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("UTC date/time value generated by the service that indicates the time at which the response was initiated")
    @encode("date-time-rfc1123")
    @header Date: utcDateTime;
    @doc("Identifies the sku name of the account.")
    @clientName("SkuName")
    @header `x-ms-sku-name`: SkuName;
    @doc("Identifies the account kind.")
    @clientName("AccountKind")
    @header `x-ms-account-kind`: AccountKind;
    @doc("Version 2019-07-07 and newer. Indicates if the account has a hierarchical namespace enabled.")
    @clientName("IsHierarchicalNamespaceEnabled")
    @header `x-ms-is-hns-enabled`: boolean;
  } | StorageError;
}

@route("/?comp=batch")
interface BlobServiceBatch {
  @doc("The Batch operation allows multiple API calls to be embedded into a single HTTP request.")
  @post
  @operationId("Service_SubmitBatch")
  post(
    @doc("The batch request content")
    @body body: bytes; // TODO: Investigate this type
    @doc("The batch request content length")
    @header `Content-Length`: int64;
    @doc("Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID>")
    @clientName("multipartContentType")
    @header `Content-Type`: string;
    @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
    @query timeout?: int32;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
    @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
    @header `x-ms-client-request-id`?: string;
  ): {
    @statusCode statusCode: 200;
    @doc("The media type of the body of the response. For batch requests, this is multipart/mixed; boundary=batchresponse_GUID")
    @header `Content-Type`: string;
    @doc("This header uniquely identifies the request that was made and can be used for troubleshooting the request.")
    @header `x-ms-request-id`: string;
    @doc("Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above.")
    @header `x-ms-version`: string;
  } | StorageError;
}
