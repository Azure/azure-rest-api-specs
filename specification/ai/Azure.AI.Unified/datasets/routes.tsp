import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";

import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Unified;

@Http.route("datasets")
interface Datasets extends ServicePatterns.VersionedCrudlOperations<DatasetVersion, ListParameters = {
    @doc("Please choose OrderBy value from ['createdtime', 'modifiedtime']")
    @query("$orderBy")
    $orderBy?: "createdTime" | "modifiedTime",

    @doc("Top count of results, top count cannot be greater than the page size. If topCount > page size, results with be default page size count will be returned")
    @query("$top")
    $top?: int32,

    @doc("Continuation token for pagination.")
    @query("$skip")
    $skip?: string,

    @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2")
    @query("$tags")
    $tags?: string,

    @doc("[ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All] View type for including/excluding (for example) archived entities.")
    @query("listViewType")
    listViewType?: ListViewType,
}> {

  op startPendingUpload is ServicePatterns.VersionedModelAction<"upload", PendingUploadRequest, PendingUploadResponse>;

};

