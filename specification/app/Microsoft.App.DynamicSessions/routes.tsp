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

alias BaseOperationTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias CodeExecutionTraits = BaseOperationTraits &
  QueryParametersTrait<SessionIdentifier>;
alias CodeExecutionOperations = Azure.Core.ResourceOperations<CodeExecutionTraits>;

interface CodeExecution {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @doc("Execute code in a session.")
  @route("/executions")
  @pollingOperation(CodeExecution.get)
  execute is Foundations.Operation<
    {
      ...SessionIdentifier;
      ...ExecutionOperationIdHeader;

      @doc("The request to execute code.")
      @body
      codeExecutionRequest: SessionCodeExecutionRequest;
    },
    AcceptedResponse &
      SessionCodeExecutionResource &
      ExecutionOperationIdHeader &
      Foundations.LongRunningStatusLocation
  >;

  @doc("Get the code execution result.")
  get is CodeExecutionOperations.ResourceRead<SessionCodeExecutionResource>;
}

alias SessionResourceFilesTraits = BaseOperationTraits &
  QueryParametersTrait<{
    ...SessionIdentifier;
    ...SessionResourceFilePathQueryParameter;
  }>;
alias SessionResourceFilesOperations = Azure.Core.ResourceOperations<SessionResourceFilesTraits>;

interface SessionResourceFiles {
  @doc("List the file resources.")
  list is SessionResourceFilesOperations.ResourceList<SessionResourceFile>;

  @doc("Get the file resource.")
  get is SessionResourceFilesOperations.ResourceRead<SessionResourceFile>;

  @doc("Delete the file.")
  delete is SessionResourceFilesOperations.ResourceDelete<SessionResourceFile>;

  #suppress "@azure-tools/typespec-azure-core/byos" "Storage service is not used"
  @doc("Upload a file to a session.")
  @route("/files")
  upload is RpcOperation<
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

  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "GET allowed on Action"
  @doc("Get the content of the file.")
  @get
  @action("content")
  @actionSeparator("/")
  getContent is SessionResourceFilesOperations.ResourceAction<
    SessionResourceFile,
    {},
    {
      @body _: bytes;
    }
  >;
}
