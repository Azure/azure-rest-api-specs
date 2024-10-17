import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface Indexes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get a specific version of an Index.")
  @route("/indexes/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;
    },
    Index
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Creates or updates a IndexVersion.")
  @route("/indexes/{name}/versions/{version}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;

      @doc("Properties of an Index Version.")
      @bodyRoot
      body: Index;
    },
    ResourceCreatedOrOkResponse<Index>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to use same model in both list calls."
  @doc("List the versions of an Index given the name.")
  @route("/indexes/{name}/versions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query
      listViewType: string = "ActiveOnly";

      @doc("Ordering of list: Please choose orderby value from ['createdAt', 'lastModifiedAt'].")
      @query
      orderBy?: string;

      @doc("Ordering of list: Please choose orderby value from ['createdAt', 'lastModifiedAt'].")
      @query
      orderby?: string;

      @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2.")
      @query
      tags?: string;

      ...StandardListQueryParameters;
    },
    PagedIndex
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get latest version of the Index. Latest is defined by most recent created by date.")
  @route("/indexes/{name}")
  @get
  getLatest is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    Index
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get next Index version as defined by the server. The server keeps track of all versions that are string-representations of integers. If one exists, the nextVersion will be a string representation of the highest integer value + 1. Otherwise, the nextVersion will default to '1'.")
  @route("/indexes/{name}:getNextVersion")
  @post
  getNextVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    VersionInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("List the latest version of each index. Latest is defined by most recent created by date.")
  @route("/indexes")
  @get
  listLatest is Azure.Core.Foundations.Operation<
    {
      ...StandardListQueryParameters;
    },
    PagedIndex
  >;
}
