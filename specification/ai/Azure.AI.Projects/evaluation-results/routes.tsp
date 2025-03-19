import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

interface EvaluationResults {
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List latest version of each Evaluation Result in a project.")
  @route("/evaluation-results")
  @get
  listLatestEvaluationResults(
    @doc("Continuation token for pagination. This is the nextLink from the previous response.")
    @query("$continuationToken")
    $continuationToken?: string,

    @doc("View type for including/excluding (for example) archived entities.")
    @query("listViewType")
    listViewType?: ListViewType,
  ): PagedDatasetVersion;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get a specific version of an EvaluationResult.")
  @route("/evaluation-results/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the EvaluationResult.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Version of the EvaluationResult.")
      @path
      version: string;
    },
    EvaluationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Creates or updates a EvaluationResultVersion.")
  @route("/evaluation-results/{name}:create")
  @post
  createEvaluationResult is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the EvaluationResult.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Properties of an EvaluationResult Version.")
      @bodyRoot
      body: EvaluationResult;
    },
    ResourceCreatedOrOkResponse<EvaluationResult>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to use same model in both list calls."
  @doc("List the versions of an EvaluationResult given the name.")
  @route("/evaluation-results/{name}/versions")
  @get
  listEvaluationResultVersions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the EvaluationResult.")
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
    PagedEvaluationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Delete version.")
  @route("/evaluation-results/{name}/versions/{version}")
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

  // TODO - support from generic asset team?
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start pending upload.")
  @post
  @route("/evaluation-result/{name}/versions/{version}/startPendingUpload")
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
