import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface Data {
  /**
   * List data containers.
   */
  @doc("List data containers.")
  @route("/data")
  @get
  list(
    @doc("Continuation token for pagination.")
    @query("$skip")
    $skip?: string,

    @doc("View type for including/excluding (for example) archived entities.")
    @query("listViewType")
    listViewType?: ListViewType,
  ): PagedDataContainer;

  @doc("Delete container.")
  @route("/data/{name}")
  @delete
  delete(
    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,
  ): void;

  @doc("Get container.")
  @route("/data/{name}")
  @get
  get(
    @doc("Container name.")
    @path
    name: string,
  ): DataContainer;

  @doc("Create or update container.")
  @route("/data/{name}")
  @put
  createOrUpdate(
    @doc("Container name.")
    @path
    name: string,

    @doc("Container entity to create or update.")
    @body
    body: DataContainer,
  ): DataContainer;
}

interface DataVersionsBase {
  @doc("List data versions in the data container")
  @route("/data/{name}/versions")
  @get
  list(
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
  ): PagedDataVersionBase;

  @doc("Delete version.")
  @route("/data/{name}/versions/{version}")
  @delete
  delete(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,
  ): void;

  @doc("Get version.")
  @route("/data/{name}/versions/{version}")
  @get
  get(
    @doc("Container name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,
  ): DataVersionBase;

  @doc("Create or update version.")
  @route("/data/{name}/versions/{version}")
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
    body: DataVersionBase,
  ): DataVersionBase;

  @doc("Publish version asset into registry.")
  @route("/data/{name}/versions/{version}/publish")
  @post
  publish(
    @doc("Container name.")
    @path
    name: string,

    @doc("Version identifier.")
    @path
    version: string,

    @doc("Destination registry info")
    @body
    body: DestinationAsset,
  ): void;
}
