import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface DeploymentTemplates {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get a specific version of a deployment template.")
  @route("/registries/{registryName}/deploymenttemplates/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML registry.")
      registryName: string;

      @doc("Name of the deployment template.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the deployment template.")
      @path
      version: string;

      @doc("Asset resource tenant ID.")
      @query
      assetResourceTenantId?: string;
    },
    DeploymentTemplate
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @doc("Creates a deployment template version.")
  @route("/registries/{registryName}/{name}/versions/{version}")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML registry.")
      registryName: string;

      @doc("Name of the deployment template.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the deployment template.")
      @path
      version: string;

      @doc("Properties of a Deployment Template Version.")
      @bodyRoot
      body: DeploymentTemplate;
    },
    LongRunningNullResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Delete a specific version of a deployment template.")
  @route("/registries/{registryName}/deploymenttemplates/{name}/versions/{version}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML registry.")
      registryName: string;

      @doc("Name of the deployment template.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the deployment template.")
      @path
      version: string;
    },
    TypeSpec.Http.Response<200> | TypeSpec.Http.Response<204>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to use same model in both list calls."
  @doc("List deployment templates.")
  @route("/registries/{registryName}/deploymenttemplates")
  @get
  @list
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML registry.")
      @path
      registryName: string;

      @doc("Filter by deployment template name.")
      @query
      name?: string;

      @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2.")
      @query
      tags?: string;

      @doc("Continuation token for pagination.")
      @query
      continuationToken?: string;

      @doc("Continuation token for pagination (from header).")
      @header
      continuationTokenFromHeader?: string;

      @doc("Maximum number of items to return.")
      @query
      count?: int32;

      @doc("Filter by deployment template stage.")
      @query
      stage?: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query
      listViewType?: string = "ActiveOnly";
    },
    PagedDeploymentTemplate
  >;
}

interface Indexes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get a specific version of an Index.")
  @route("/workspaces/{workspaceName}/indexes/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @doc("Creates or updates a IndexVersion.")
  @route("/workspaces/{workspaceName}/indexes/{name}/versions/{version}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

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
  @route("/workspaces/{workspaceName}/indexes/{name}/versions")
  @get
  @list
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      @doc("Name of the index.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query
      listViewType: string = "ActiveOnly";

      @added(Versions.`2024-04-01-preview`)
      @removed(Versions.`2024-05-01-preview`)
      @doc("Ordering of list: Please choose orderby value from ['createdAt', 'lastModifiedAt'].")
      @query
      orderBy?: string;

      @added(Versions.`2024-05-01-preview`)
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
  @route("/workspaces/{workspaceName}/indexes/{name}")
  @get
  getLatest is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

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
  @route("/workspaces/{workspaceName}/indexes/{name}:getNextVersion")
  @post
  getNextVersion is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

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
  @route("/workspaces/{workspaceName}/indexes")
  @list
  @get
  listLatest is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      ...StandardListQueryParameters;
    },
    PagedIndex
  >;
}

@added(Versions.`2024-05-01-preview`)
interface Prompts {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get a specific version of a Prompt.")
  @route("/workspaces/{workspaceName}/prompts/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      @doc("Name of the prompt")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the prompt")
      @path
      version: string;
    },
    Prompt
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @doc("Creates or updates a Prompt")
  @route("/workspaces/{workspaceName}/prompts/{name}/versions/{version}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      @doc("Name of the prompt")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the prompt")
      @path
      version: string;

      @doc("Properties of a Prompt Version.")
      @body
      body: Prompt;
    },
    ResourceCreatedOrOkResponse<Prompt>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("List the versions of a Prompt given the name.")
  @route("/workspaces/{workspaceName}/prompts/{name}/versions")
  @list
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      @doc("Name of the prompt")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query
      listViewType: string = "ActiveOnly";

      @doc("Ordering of list: Please choose orderby value from ['createdAt', 'lastModifiedAt'].")
      @query
      orderby?: string;

      @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2.")
      @query
      tags?: string;

      ...StandardListQueryParameters;
    },
    PagedPrompt
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get latest version of the Prompt. Latest is defined by most recent created by date.")
  @route("workspaces/{workspaceName}/prompts/{name}")
  @get
  getLatest is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      @doc("Name of the prompt")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    Prompt
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("Get next Prompt version as defined by the server. The server keeps track of all versions that are string-representations of integers. If one exists, the nextVersion will be a string representation of the highest integer value + 1. Otherwise, the nextVersion will default to '1'.")
  @route("/workspaces/{workspaceName}/prompts/{name}:getNextVersion")
  @post
  getNextVersion is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      @doc("Name of the prompt")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    VersionInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @list
  @doc("List the latest version of each prompt. Latest is defined by most recent created by date.")
  @route("/workspaces/{workspaceName}/prompts")
  @get
  listLatest is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the AzureML workspace or AI project.")
      @path
      workspaceName: string;

      ...StandardListQueryParameters;
    },
    PagedPrompt
  >;
}
