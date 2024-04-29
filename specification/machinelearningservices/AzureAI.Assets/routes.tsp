import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface Indexes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Fetch a IndexVersion by name.")
  @route("/indexes/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{0,254}$")
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;
    },
    Index | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Creates or updates a IndexVersion.")
  @route("/indexes/{name}/versions/{version}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{0,254}$")
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;

      @doc("Properties of an Index Version.")
      @body
      body: Index;
    },
    ResourceCreatedOrOkResponse<Index> | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to use same model in both list calls."
  @route("/indexes/{name}/versions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{0,254}$")
      @path
      name: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query
      listViewType: string = "ActiveOnly";

      @doc("Ordering of list: Please choose OrderBy value from ['createdtime', 'modifiedtime'].")
      @query
      orderBy?: string;

      @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2.")
      @query
      tags?: string;

      ...StandardListQueryParameters;
    },
    PagedIndex | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get latest Index.")
  @route("/indexes/{name}")
  @get
  getLatest is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{0,254}$")
      @path
      name: string;
    },
    Index | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get next Index version.")
  @route("/indexes/{name}:getNextVersion")
  @post
  getNextVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{0,254}$")
      @path
      name: string;
    },
    VersionInfo | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("List the latest version of each index.")
  @route("/indexes/")
  @get
  listLatest is Azure.Core.Foundations.Operation<
    {
      ...StandardListQueryParameters;
    },
    PagedIndex | Foundations.ErrorResponse
  >;
}
