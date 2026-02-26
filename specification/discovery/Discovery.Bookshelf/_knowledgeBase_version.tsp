import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_knowledgeBase.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Discovery.Bookshelf.Versions)
namespace Microsoft.Discovery.Bookshelf;

@doc("A version.")
@resource("versions")
@parentResource(KnowledgeBase)
model KnowledgeBaseVersion {
  @doc("The version name.")
  @visibility(Lifecycle.Read)
  @key("versionName")
  @maxLength(24)
  @pattern(resourceNamePattern)
  name: string;

  ...BaseKnowledgeBase;
}

@doc("Resources for indexing operation")
model WithNodePool {
  @doc("Node pool ID")
  nodePoolId: string;

  @doc("Project ID")
  projectId?: string;

  @removed(Versions.`2026-02-01-preview`)
  @doc("Storage ID")
  storageId?: string;
}

@doc("Supercomputer run ID")
model WithRunId {
  @doc("Run ID")
  runId: string;
}

@doc("Status of a KnowledgeBase operation")
model KnowledgeBaseOperationStatus {
  @doc("The unique ID of the operation.")
  id: string;

  @doc("The status of the operation")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error object that describes the error when status is 'Failed'.")
  error?: Azure.Core.Foundations.Error;

  @doc("The KnowledgeBaseVersion result of the operation.")
  result?: KnowledgeBaseVersion;
}

/**
 * Operation signature to retrieve a resource operation status.
 * @template Resource The type of the resource.
 * @template StatusResult Object describing the result of the status operation.
 * @template StatusError Object describing the error of the status operation. If not provided, the default error type is used.
 * @template Traits Traits to apply to the operation.
 */
@readsResource(ResourceOperationStatus<Resource>)
@Foundations.Private.ensureResourceType(Resource)
op GetResourceOperationStatus<
  Resource extends TypeSpec.Reflection.Model,
  StatusResult = Resource,
  StatusError = Foundations.Error,
  Traits extends TypeSpec.Reflection.Model = {}
> is Foundations.ResourceOperation<
  ResourceOperationStatus<Resource, StatusResult, StatusError>,
  {},
  ResourceOperationStatusResponse<Resource, StatusResult, StatusError>,
  Traits
>;

interface KnowledgeBaseVersions {
  @doc("Creates or updates a KnowledgeBaseVersion.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseVersion>;

  @doc("Fetch a KnowledgeBaseVersion by name.")
  get is ResourceRead<KnowledgeBaseVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the most recent version of KnowledgeBase.")
  @get
  @route("/knowledgeBases/{knowledgeBaseName}/versions/@latest")
  getLatestVersion is Foundations.Operation<
    {
      /** Name of the KnowledgeBase */
      @path
      @maxLength(24)
      knowledgeBaseName: string;
    },
    KnowledgeBaseVersion
  >;

  @doc("List KnowledgeBaseVersion resources")
  list is ResourceList<
    KnowledgeBaseVersion,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  //   @route("/indexingOperations/{operationId}")
  //   getIndexingOperationStatus is Operations.GetResourceOperationStatus<KnowledgeBaseVersion,
  //     WithRunId
  //   >;

  //   #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  //   @route("/knowledgeBases/{knowledgeBaseName}/versions/{versionName}/indexingOperations/{operationId}")
  //   getIndexingOperationStatus is Foundations.GetOperationStatus<
  //       {
  //           /** Name of the knowledgeBase resource. */
  //           @path knowledgeBaseName: string;
  //           /** Version of the knowledgeBase resource. */
  //           @path versionName: string;
  //       },
  //       KnowledgeBaseVersion
  //   >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation to include searchResults field"
  @doc("Get the status of a long-running operation.")
  @route("/knowledgeBases/{knowledgeBaseName}/versions/{versionName}/operations/{operationId}")
  @get
  getOperationStatus(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("The knowledgeBase name.")
    @path
    @maxLength(24)
    @pattern(resourceNamePattern)
    knowledgeBaseName: string,

    @doc("The version name.")
    @path
    @maxLength(24)
    @pattern(resourceNamePattern)
    versionName: string,

    @doc("The unique ID of the operation.")
    @path
    @maxLength(38)
    operationId: string,
  ): KnowledgeBaseOperationStatus | Azure.Core.Foundations.ErrorResponse;

  @doc("Start indexing.")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  startIndexing is Operations.LongRunningResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  @doc("Cancel indexing.")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  cancelIndexing is Operations.LongRunningResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  @doc("Delete a KnowledgeBaseVersion.")
  delete is ResourceDelete<KnowledgeBaseVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Delete the most recent version of KnowledgeBase.")
  @delete
  @route("/knowledgeBases/{knowledgeBaseName}/versions/@latest")
  deleteLatestVersion is Foundations.Operation<
    {
      /** Name of the KnowledgeBase */
      @path
      @maxLength(24)
      knowledgeBaseName: string;
    },
    {
      @statusCode _: 204;
    }
  >;

  //  @doc("Restore the KnowledgeBase to the state of this version.")
  //  restore is Operations.ResourceAction<KnowledgeBaseVersion, {}, KnowledgeBase>;
}
