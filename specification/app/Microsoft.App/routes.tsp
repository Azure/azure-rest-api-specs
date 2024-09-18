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

alias SessionTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId &
  QueryParametersTrait<SessionIdentifier>;

alias SessionOperations = Azure.Core.ResourceOperations<SessionTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Execute code in a session.")
@route("/codeExecute")
op executeCode is Foundations.Operation<
  {
    ...SessionIdentifier;

    @doc("The request to execute code.")
    @body
    codeExecutionRequest: SessionCodeExecutionRequest;
  },
  Foundations.AcceptedResponse<SessionCodeExecutionAsyncResponse> | Foundations.ResourceOkResponse<SessionCodeExecutionResponse>,
  {},
  Foundations.ErrorResponse
>;

@doc("Get the code execution result.")
@route("/codeExecutionResult")
op getCodeExecutionResult is RpcOperation<
  {
    ...SessionIdentifier;
    ...CodeExecutionIdentifier;
  },
  SessionCodeExecutionResponse
>;

interface SessionResourceFiles {
  @doc("List the file resources.")
  listFilesMetadata is SessionOperations.ResourceList<SessionResourceFile>;

  @doc("Get the file resource.")
  getFileMetadata is SessionOperations.ResourceRead<SessionResourceFile>;

  @doc("Delete the file.")
  deleteFile is SessionOperations.ResourceDelete<SessionResourceFile>;

  @doc("Upload a file to a session.")
  downloadFile is SessionOperations.ResourceAction<
    SessionResourceFile,
    {},
    {
      content: bytes;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" ""
  @doc("Upload a file to a session.")
  uploadFile is SessionOperations.ResourceAction<
    SessionResourceFile,
    {
      @doc("The content type for the operation. Always multipart/form-data for this operation.")
      @header("content-type")
      contentType: "multipart/form-data";

      @doc("The file to upload.")
      file: bytes;
    },
    SessionResourceFile
  >;
}
