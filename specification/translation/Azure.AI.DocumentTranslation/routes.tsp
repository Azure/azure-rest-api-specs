import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace DocumentTranslation;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

interface SingleDocumentTranslationOperations {
  #suppress "@azure-tools/typespec-azure-core/byos"
  @summary("Translate a single document")
  @doc("API to translate single document")
  @post
  @route("document:translate")
  singleDocumentTranslate is RpcOperation<
    SingleDocumentTranslateContent,
    SingleDocumentTranslateResult,
    ServiceTraits
  >;
}

interface DocumentTranslationOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Submit a document translation request to the Document Translation service")
  @doc("""
Use this API to submit a bulk (batch) translation request to the Document
Translation service.
Each request can contain multiple documents and must
contain a source and destination container for each document.
            
The
prefix and suffix filter (if supplied) are used to filter folders. The prefix
is applied to the subpath after the container name.
            
Glossaries /
Translation memory can be included in the request and are applied by the
service when the document is translated.
            
If the glossary is
invalid or unreachable during translation, an error is indicated in the
document status.
If a file with the same name already exists at the
destination, it will be overwritten. The targetUrl for each target language
must be unique.
""")
  @route("/text/batch/v1.0/batches")
  @post
  startTranslation is Azure.Core.Foundations.Operation<
    StartTranslationDetails,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns a list of batch requests submitted and the status for each request")
  @doc("""
Returns a list of batch requests submitted and the status for each
request.
This list only contains batch requests submitted by the user (based on
the resource).
            
If the number of requests exceeds our paging limit,
server-side paging is used. Paginated responses indicate a partial result and
include a continuation token in the response.
The absence of a continuation
token means that no additional pages are available.
            
$top, $skip
and $maxpagesize query parameters can be used to specify a number of results to
return and an offset for the collection.
            
$top indicates the total
number of records the user wants to be returned across all pages.
$skip
indicates the number of records to skip from the list of batches based on the
sorting method specified.  By default, we sort by descending start
time.
$maxpagesize is the maximum items returned in a page.  If more items are
requested via $top (or $top is not specified and there are more items to be
returned), @nextLink will contain the link to the next page.
           

$orderBy query parameter can be used to sort the returned list (ex
\"$orderBy=createdDateTimeUtc asc\" or \"$orderBy=createdDateTimeUtc
desc\").
The default sorting is descending by createdDateTimeUtc.
Some query
parameters can be used to filter the returned list (ex:
\"status=Succeeded,Cancelled\") will only return succeeded and cancelled
operations.
createdDateTimeUtcStart and createdDateTimeUtcEnd can be used
combined or separately to specify a range of datetime to filter the returned
list by.
The supported filtering query parameters are (status, ids,
createdDateTimeUtcStart, createdDateTimeUtcEnd).
            
The server honors
the values specified by the client. However, clients must be prepared to handle
responses that contain a different page size or contain a continuation token.
 
          
When both $top and $skip are included, the server should first apply
$skip and then $top on the collection.
Note: If the server can't honor $top
and/or $skip, the server must return an error to the client informing about it
instead of just ignoring the query options.
This reduces the risk of the client
making assumptions about the data returned.
""")
  @route("/text/batch/v1.0/batches")
  @get
  getTranslationsStatus is Azure.Core.Foundations.Operation<
    {
      @doc("""
$top indicates the total number of records the user wants to be returned across
all pages.
            
Clients MAY use $top and $skip query parameters to
specify a number of results to return and an offset into the collection.
When
both $top and $skip are given by a client, the server SHOULD first apply $skip
and then $top on the collection.
            
Note: If the server can't honor
$top and/or $skip, the server MUST return an error to the client informing
about it instead of just ignoring the query options.
""")
      @maxValue(2147483647)
      @query("$top")
      top?: int32;

      @doc("""
$skip indicates the number of records to skip from the list of records held by
the server based on the sorting method specified.  By default, we sort by
descending start time.
            
Clients MAY use $top and $skip query
parameters to specify a number of results to return and an offset into the
collection.
When both $top and $skip are given by a client, the server SHOULD
first apply $skip and then $top on the collection.
            
Note: If the
server can't honor $top and/or $skip, the server MUST return an error to the
client informing about it instead of just ignoring the query options.
""")
      @maxValue(2147483647)
      @query("$skip")
      skip?: int32;

      @doc("""
$maxpagesize is the maximum items returned in a page.  If more items are
requested via $top (or $top is not specified and there are more items to be
returned), @nextLink will contain the link to the next page.
           

Clients MAY request server-driven paging with a specific page size by
specifying a $maxpagesize preference. The server SHOULD honor this preference
if the specified page size is smaller than the server's default page size.
""")
      @maxValue(100)
      @minValue(1)
      @query("$maxpagesize")
      maxpagesize?: int32 = 50;

      @doc("Ids to use in filtering")
      @query({
        name: "ids",
        format: "csv",
      })
      ids?: uuid[];

      @doc("Statuses to use in filtering")
      @query({
        name: "statuses",
        format: "csv",
      })
      statuses?: string[];

      @doc("the start datetime to get items after")
      @query("createdDateTimeUtcStart")
      createdDateTimeUtcStart?: utcDateTime;

      @doc("the end datetime to get items before")
      @query("createdDateTimeUtcEnd")
      createdDateTimeUtcEnd?: utcDateTime;

      @doc("the sorting query for the collection (ex: 'CreatedDateTimeUtc asc','CreatedDateTimeUtc desc')")
      @query({
        name: "$orderBy",
        format: "csv",
      })
      orderBy?: string[];
    },
    TranslationsStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns the status for a specific document")
  @doc("""
Returns the translation status for a specific document based on the request Id
and document Id.
""")
  @route("/text/batch/v1.0/batches/{id}/documents/{documentId}")
  @get
  getDocumentStatus is Azure.Core.Foundations.Operation<
    {
      @doc("Format - uuid.  The batch id")
      @path
      id: uuid;

      @doc("Format - uuid.  The document id")
      @path
      documentId: uuid;
    },
    DocumentStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns the status for a document translation request")
  @doc("""
Returns the status for a document translation request.
The status includes the
overall request status, as well as the status for documents that are being
translated as part of that request.
""")
  @route("/text/batch/v1.0/batches/{id}")
  @get
  getTranslationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("Format - uuid.  The operation id")
      @path
      id: uuid;
    },
    TranslationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Cancel a currently processing or queued translation")
  @doc("""
Cancel a currently processing or queued translation.
A translation will not be
cancelled if it is already completed or failed or cancelling. A bad request
will be returned.
All documents that have completed translation will not be
cancelled and will be charged.
All pending documents will be cancelled if
possible.
""")
  @route("/text/batch/v1.0/batches/{id}")
  @delete
  cancelTranslation is Azure.Core.Foundations.Operation<
    {
      @doc("Format - uuid.  The operation-id")
      @path
      id: uuid;
    },
    TranslationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns the status for all documents in a batch document translation request")
  @doc("""
Returns the status for all documents in a batch document translation request.
 
          
If the number of documents in the response exceeds our paging limit,
server-side paging is used.
Paginated responses indicate a partial result and
include a continuation token in the response. The absence of a continuation
token means that no additional pages are available.
            
$top, $skip
and $maxpagesize query parameters can be used to specify a number of results to
return and an offset for the collection.
            
$top indicates the total
number of records the user wants to be returned across all pages.
$skip
indicates the number of records to skip from the list of document status held
by the server based on the sorting method specified.  By default, we sort by
descending start time.
$maxpagesize is the maximum items returned in a page. 
If more items are requested via $top (or $top is not specified and there are
more items to be returned), @nextLink will contain the link to the next page.
 
          
$orderBy query parameter can be used to sort the returned list (ex
\"$orderBy=createdDateTimeUtc asc\" or \"$orderBy=createdDateTimeUtc
desc\").
The default sorting is descending by createdDateTimeUtc.
Some query
parameters can be used to filter the returned list (ex:
\"status=Succeeded,Cancelled\") will only return succeeded and cancelled
documents.
createdDateTimeUtcStart and createdDateTimeUtcEnd can be used
combined or separately to specify a range of datetime to filter the returned
list by.
The supported filtering query parameters are (status, ids,
createdDateTimeUtcStart, createdDateTimeUtcEnd).
            
When both $top
and $skip are included, the server should first apply $skip and then $top on
the collection.
Note: If the server can't honor $top and/or $skip, the server
must return an error to the client informing about it instead of just ignoring
the query options.
This reduces the risk of the client making assumptions about
the data returned.
""")
  @route("/text/batch/v1.0/batches/{id}/documents")
  @get
  getDocumentsStatus is Azure.Core.Foundations.Operation<
    {
      @doc("Format - uuid.  The operation id")
      @path
      id: uuid;

      @doc("""
$top indicates the total number of records the user wants to be returned across
all pages.
            
Clients MAY use $top and $skip query parameters to
specify a number of results to return and an offset into the collection.
When
both $top and $skip are given by a client, the server SHOULD first apply $skip
and then $top on the collection.
            
Note: If the server can't honor
$top and/or $skip, the server MUST return an error to the client informing
about it instead of just ignoring the query options.
""")
      @maxValue(2147483647)
      @query("$top")
      top?: int32;

      @doc("""
$skip indicates the number of records to skip from the list of records held by
the server based on the sorting method specified.  By default, we sort by
descending start time.
            
Clients MAY use $top and $skip query
parameters to specify a number of results to return and an offset into the
collection.
When both $top and $skip are given by a client, the server SHOULD
first apply $skip and then $top on the collection.
            
Note: If the
server can't honor $top and/or $skip, the server MUST return an error to the
client informing about it instead of just ignoring the query options.
""")
      @maxValue(2147483647)
      @query("$skip")
      skip?: int32;

      @doc("""
$maxpagesize is the maximum items returned in a page.  If more items are
requested via $top (or $top is not specified and there are more items to be
returned), @nextLink will contain the link to the next page.
           

Clients MAY request server-driven paging with a specific page size by
specifying a $maxpagesize preference. The server SHOULD honor this preference
if the specified page size is smaller than the server's default page size.
""")
      @maxValue(100)
      @minValue(1)
      @query("$maxpagesize")
      maxpagesize?: int32 = 50;

      @doc("Ids to use in filtering")
      @query({
        name: "ids",
        format: "csv",
      })
      ids?: uuid[];

      @doc("Statuses to use in filtering")
      @query({
        name: "statuses",
        format: "csv",
      })
      statuses?: string[];

      @doc("the start datetime to get items after")
      @query("createdDateTimeUtcStart")
      createdDateTimeUtcStart?: utcDateTime;

      @doc("the end datetime to get items before")
      @query("createdDateTimeUtcEnd")
      createdDateTimeUtcEnd?: utcDateTime;

      @doc("the sorting query for the collection (ex: 'CreatedDateTimeUtc asc','CreatedDateTimeUtc desc')")
      @query({
        name: "$orderBy",
        format: "csv",
      })
      orderBy?: string[];
    },
    DocumentsStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns a list of supported document formats")
  @doc("""
The list of supported document formats supported by the Document Translation
service.
The list includes the common file extension, as well as the
content-type if using the upload API.
""")
  @route("/text/batch/v1.0/documents/formats")
  @get
  getSupportedDocumentFormats is Azure.Core.Foundations.Operation<
    {},
    SupportedFileFormats
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns the list of supported glossary formats")
  @doc("""
The list of supported glossary formats supported by the Document Translation
service.
The list includes the common file extension used.
""")
  @route("/text/batch/v1.0/glossaries/formats")
  @get
  getSupportedGlossaryFormats is Azure.Core.Foundations.Operation<
    {},
    SupportedFileFormats
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @added(DocumentTranslation.Versions.v1_0)
  @summary("Returns a list of supported storage sources")
  @doc("""
Returns a list of storage sources/options supported by the Document Translation
service.
""")
  @route("/text/batch/v1.0/storagesources")
  @get
  getSupportedStorageSources is Azure.Core.Foundations.Operation<
    {},
    SupportedStorageSources
  >;
}
