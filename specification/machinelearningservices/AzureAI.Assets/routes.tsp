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


interface IndexVersionsRegistries {
  
  @doc("Creates or updates a IndexVersion.")
  @route("/registries/{registryName}/indexes/{name}/versions/{version}")
  @put
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  createOrUpdateIndexVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the registry.")      
      @path
      registryName: Registry.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;

      /** The deployment properties. */
      @body
      index: IndexVersion;

    },
    ResourceCreatedOrOkResponse<IndexVersion>
  >;

  @route("/registries/{registryName}/indexes/{name}/versions/{version}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  getIndexVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the registry.")      
      @path
      registryName: Registry.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;
    },
    IndexVersion
   >;

   @route("/registries/{registryName}/indexes/{name}/versions")
   @get
   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
   listIndexVersion is Azure.Core.Foundations.Operation<
     {
       @doc("Name of the registry.")      
       @path
       registryName: Registry.name;
 
       @doc("Name of the index.")
       @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
       @path
       name: string;
 
       @doc("View type for including/excluding (for example) archived entities.")
       @query listViewType: string = "ActiveOnly";
       
       @doc("Ordering of list.")
       @query orderBy: string;

       ...StandardListQueryParameters
     },
     IndexVersionList
    >;
}

interface IndexVersionsWorkspace {
  
  @doc("Creates or updates a IndexVersion.")
  @route("/workspaces/{workspaceName}/indexes/{name}/versions/{version}")
  @put
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  createOrUpdateIndexVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      workspaceName: Workspace.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;

      /** The deployment properties. */
      @body
      index: IndexVersion;

    },
    ResourceCreatedOrOkResponse<IndexVersion>
  >;

  @route("/workspaces/{workspaceName}/indexes/{name}/versions/{version}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  getIndexVersion is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the workspace.")
      @path
      workspaceName: Workspace.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      name: string;

      @doc("Version of the index.")
      @path
      version: string;
    },
    IndexVersion
   >;

   @route("/workspaces/{workspaceName}/indexes/{name}/versions")
   @get
   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
   listIndexVersion is Azure.Core.Foundations.Operation<
     {
       @doc("Name of the workspace.")
       @path
       workspaceName: Workspace.name;
 
       @doc("Name of the index.")
       @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
       @path
       name: string;
 
       @doc("View type for including/excluding (for example) archived entities.")
       @query listViewType: string = "ActiveOnly";
       
       @doc("Ordering of list.")
       @query orderBy: string;

       ...StandardListQueryParameters
     },
     IndexVersionList
    >;
}

interface Indexes {
  @doc("List the latest version of each index.")
  @route("/registries/{registryName}/indexes/")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  listIndexRegistry is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the registry.")
      @path
      registryName: Registry.name;

      ...StandardListQueryParameters
    },
    IndexList
   >;

   @doc("List the latest version of each index.")
   @route("/workspaces/{workspaceName}/indexes/")
   @get
   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
   listIndexWorkspace is Azure.Core.Foundations.Operation<
     {
       @doc("Name of the workspace.")
       @path
       workspaceName: Workspace.name;
 
       ...StandardListQueryParameters
     },
     IndexList
    >;
}

