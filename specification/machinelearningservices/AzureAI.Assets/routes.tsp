import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface IndexVersions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Fetch a IndexVersion by name.")
  @route("/workspaces/{workspaceName}/indexes/{indexName}/versions/{indexVersion}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      workspaceName: Workspace.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      indexName: string;

      @doc("Version of the index.")
      @path
      indexVersion: string;
    },
    Index | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Creates or updates a IndexVersion.")
  @route("/workspaces/{workspaceName}/indexes/{indexName}/versions/{indexVersion}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      workspaceName: Workspace.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      indexName: string;

      @doc("Version of the index.")
      @path
      indexVersion: string;

      @doc("Properties of an Index Version.")
      @body
      body: Index;
    },
    ResourceCreatedOrOkResponse<Index> | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to use same model in both list calls."
  @route("/workspaces/{workspaceName}/indexes/{indexName}/versions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      workspaceName: string;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      indexName: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query
      listViewType: string = "ActiveOnly";

      @doc("Ordering of list.")
      @query
      orderBy: string;

      ...StandardListQueryParameters;
    },
    PagedIndex | Foundations.ErrorResponse
  >;
}

interface IndexesLatest {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get latest Index.")
  @route("/workspaces/{workspaceName}/indexes/{indexName}")
  @get
  getLatest is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      workspaceName: string;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      indexName: string;
    },
    Index | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get next Index version.")
  @route("/workspaces/{workspaceName}/indexes/{indexName}:getNextVersion")
  @post
  getNextVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      workspaceName: string;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      indexName: string;
    },
    VersionInfo | Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("List the latest version of each index.")
  @route("/workspaces/{workspaceName}/indexes/")
  @get
  listLatest is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      workspaceName: string;

      ...StandardListQueryParameters;
    },
    PagedIndex | Foundations.ErrorResponse
  >;
}
