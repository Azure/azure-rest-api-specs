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
  
  @route("/registries/{registryName}/indexes/{indexName}/versions/{indexVersion}")
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
      indexName: string;

      @doc("Version of the index.")
      @path
      indexVersion: string;

      @doc("Properties of an Index Version.")
      @body
      indexDefinition: Index;

    },
    ResourceCreatedOrOkResponse<Index>
  >;

  @route("/registries/{registryName}/indexes/{indexName}/versions/{indexVersion}")
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
      indexName: string;

      @doc("Version of the index.")
      @path
      indexVersion: string;
    },
    Index
   >;

   @route("/registries/{registryName}/indexes/{indexName}/versions")
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
       indexName: string;
 
       @doc("View type for including/excluding (for example) archived entities.")
       @query listViewType: string = "ActiveOnly";
       
       @doc("Ordering of list.")
       @query orderBy: string;

       ...StandardListQueryParameters
     },
     IndexList
    >;
}

interface IndexVersionsWorkspace {
  
  @route("/workspaces/{workspaceName}/indexes/{indexName}/versions/{indexVersion}")
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
      indexName: string;

      @doc("Version of the index.")
      @path
      indexVersion: string;

      @doc("Properties of an Index Version.")
      @body
      indexDefinition: Index;

    },
    ResourceCreatedOrOkResponse<Index>
  >;

  @route("/workspaces/{workspaceName}/indexes/{indexName}/versions/{indexVersion}")
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
      indexName: string;

      @doc("Version of the index.")
      @path
      indexVersion: string;
    },
    Index
   >;

   @route("/workspaces/{workspaceName}/indexes/{indexName}/versions")
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
       indexName: string;
 
       @doc("View type for including/excluding (for example) archived entities.")
       @query listViewType: string = "ActiveOnly";
       
       @doc("Ordering of list.")
       @query orderBy: string;

       ...StandardListQueryParameters
     },
     IndexList
    >;
}

interface Indexes {

  @doc("Get latest Index.")
  @route("/registries/{registryName}/indexes/{indexName}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  getIndexRegistry is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the registry.")
      @path
      registryName: Registry.name;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
      @path
      indexName: string;
    },
    Index
   >;

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

   @doc("Get latest Index.")
   @route("/workspaces/{workspaceName}/indexes/{indexName}")
   @get
   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
   getIndexWorkspace is Azure.Core.Foundations.Operation<
     {
       @doc("Name of the workspace.")
       @path
       workspaceName: Workspace.name;
 
       @doc("Name of the index.")
       @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
       @path
       indexName: string;
     },
     Index
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

