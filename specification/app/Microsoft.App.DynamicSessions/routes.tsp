import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";
import "./models/code-execution.tsp";
import "./models/code-execution-file.tsp";
import "./models/common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.App.DynamicSessions;

interface CodeExecution {
  @doc("Execute code in a session.")
  @route("/executions")
  @pollingOperation(CodeExecution.getResult)
  executeCode is LongRunningRpcOperation<
    {
      ...SessionIdentifier;
      ...ExecutionIdHeader;

      @doc("The request to execute code.")
      @body
      codeExecutionRequest: SessionCodeExecutionRequest;
    },
    SessionCodeExecutionResponse,
    SessionCodeExecutionResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @doc("Get the code execution result.")
  @route("/executions/{executionId}")
  getResult is Foundations.Operation<
    {
      ...SessionIdentifier;
      ...CodeExecutionIdentifier;
    },
    SessionCodeExecutionResponse
  >;
}

alias SessionResourceFilesTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId &
  QueryParametersTrait<{
    ...SessionIdentifier;
    ...SessionResourceFilePathQueryParameter;
  }>;

alias SessionResourceFilesOperations = Azure.Core.ResourceOperations<SessionResourceFilesTraits>;

interface SessionResourceFiles {
  @doc("List the file resources.")
  listFilesMetadata is SessionResourceFilesOperations.ResourceList<SessionResourceFile>;

  @doc("Get the file resource.")
  getFileMetadata is SessionResourceFilesOperations.ResourceRead<SessionResourceFile>;

  @doc("Delete the file.")
  deleteFile is SessionResourceFilesOperations.ResourceDelete<SessionResourceFile>;

  #suppress "@azure-tools/typespec-azure-core/byos" ""
  @doc("Upload a file to a session.")
  @route("/files")
  uploadFile is RpcOperation<
    {
      @doc("The content type for the operation. Always multipart/form-data for this operation.")
      @header("content-type")
      contentType: "multipart/form-data";

      @doc("The file to upload.")
      file: bytes;
    },
    SessionResourceFile,
    SessionResourceFilesTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @doc("Get the content of the file.")
  @route("/files/{name}/content")
  getFileContent is Foundations.Operation<
    {
      ...SessionIdentifier;
      ...SessionResourceFileNamePathParameter;
      ...SessionResourceFilePathQueryParameter;
    },
    bytes
  >;
}
