import "@azure-tools/typespec-client-generator-core";
import "../main.tsp";
import "../client.tsp";

using Azure.ClientGenerator.Core;
using Storage.Blob;
using TypeSpec.Http;

namespace DatalakeGoCustomizations;

// Root client
@client(
  {
    name: "ServiceClient",
    service: Storage.Blob,
  },
  "go"
)
interface ServiceClient {
    listContainersSegment is Storage.Blob.Service.listContainers;

    //listContainersSegment is listContainers;
  }

//    /** Returns a list of the containers in the specified account. */
//   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
//   #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
//   @list
//   @route("?comp=list")
//   op listContainers is StorageOperationResponseBody<
//     {
//       ...PrefixParameter;
//       ...MarkerParameter;
//       ...MaxResultsParameter;
//       ...TimeoutParameter;

//       /** Specify to include additional, optional information. */
//       @query include?: Array<ListContainersIncludeType>;
//     },
//     ListContainersResponse
//   >;

//   /** Azure Storage Blob basic operation template */
// #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
// op StorageOperationResponseBody<
//   TParams extends TypeSpec.Reflection.Model | void,
//   TResponse extends TypeSpec.Reflection.Model | void,
//   ResponseMediaType extends string = "application/xml",
//   TError = Error
// > is StorageOperationNoBody<
//   TParams,
//   {
//     /** Content-Type header */
//     #suppress "@typespec/http/content-type-ignored" "Template for existing API"
//     @header("Content-Type")
//     contentType: ResponseMediaType;
//   } & TResponse,
//   TError
// >;

// /** The prefix parameter. */
// alias PrefixParameter = {
//   /** Filters the results to return only resources whose name begins with the specified prefix. */
//   @query prefix?: string;
// };

// /** The marker parameter. */
// alias MarkerParameter = {
//   /** An opaque string value that identifies the portion of the result set to return with this operation. */
//   @continuationToken
//   @query
//   marker?: string;
// };

// /** The max results parameter. */
// alias MaxResultsParameter = {
//   /** Specifies the maximum number of resources to return. If the request does not specify maxresults, or specifies a value greater than 5000, the server will return up to 5000 items. */
//   @query
//   @minValue(1)
//   maxresults?: int32;
// };

