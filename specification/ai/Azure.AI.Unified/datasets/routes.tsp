import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Unified;

interface Datasets {
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List latest version of each dataset in a project.")
  @route("/datasets")
  @get
  listLatestDatasets(
    @doc("Continuation token for pagination. This is the nextLink from the previous response.")
    @query("$continuationToken")
    $continuationToken?: string,

    @doc("View type for including/excluding (for example) archived entities.")
    @query("listViewType")
    listViewType?: ListViewType,
  ): PagedDatasetVersion;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List dataset versions of a specific dataset")
  @route("/datasets/{name}/versions")
  @get
  listDatasetVersions(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Please choose OrderBy value from ['createdtime', 'modifiedtime']")
    @query("$orderBy")
    $orderBy?: string,

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
  ): PagedDatasetVersion;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Delete version.")
  @route("/datasets/{name}/versions/{version}")
  @delete
  deleteVersion(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,
  ): void;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get dataset version.")
  @route("/datasets/{name}/versions/{version}")
  @get
  getVersion(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,
  ): DatasetVersion;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update version.")
  @route("/datasets/{name}/versions/{version}")
  @put
  createOrUpdate(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,

    @doc("Version entity to create or update.")
    @body
    datasetVersion: DatasetVersion,
  ): DatasetVersion;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start pending upload.")
  @post
  @route("/datasets/{name}/versions/{version}/startPendingUpload")
  createOrGetStartPendingUpload(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,

    @doc("Pensing upload request.")
    @body
    pendingUploadRequest: PendingUploadRequest,
  ): PendingUploadResponse;
}
