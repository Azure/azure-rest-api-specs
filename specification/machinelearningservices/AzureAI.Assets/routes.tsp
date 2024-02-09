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
  @doc("Fetch a IndexVersion by name.")
  get is ResourceRead<Index>;

  @doc("Creates or updates a IndexVersion.")
  createOrUpdate is ResourceCreateOrUpdate<Index>;

  @route("/workspaces/{workspaceName}/indexes/{indexName}/versions")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to use same model in both list calls."
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
      @query listViewType: string = "ActiveOnly";

      @doc("Ordering of list.")
      @query orderBy: string;

      ...StandardListQueryParameters
    },
    IndexList | Foundations.ErrorResponse
    >;
}

interface IndexesLatest {
   @doc("Get latest Index.")
   @route("/workspaces/{workspaceName}/indexes/{indexName}")
   @get
   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
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

   @doc("List the latest version of each index.")
   @route("/workspaces/{workspaceName}/indexes/")
   @get
   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
   listLatest is Azure.Core.Foundations.Operation<
     {
       @doc("Name of the workspace.")
       @path
       @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
       workspaceName: string;
 
       ...StandardListQueryParameters
     },
     IndexList | Foundations.ErrorResponse
    >;
}

