import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";
import "./models/code-execution.tsp";
import "./models/code-execution-file.tsp";
import "./models/session.tsp";
import "./models/common.tsp";
import "./models/sessionpool-metadata.tsp";

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
  @doc("Execute code in a session.")
  @route("/executions")
  execute is RpcOperation<
    {
      ...ExecutionOperationIdHeader;

      @doc("The request to execute code.")
      @body
      codeExecutionRequest: SessionCodeExecutionRequest;
    },
    SessionCodeExecutionResource &
      ExecutionOperationIdHeader &
      Foundations.LongRunningStatusLocation,
    CodeExecutionTraits
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

      /** Multipart body */
      @multipartBody body: {
        @doc("The file to upload.")
        file: HttpPart<bytes>;
      };
    },
    SessionResourceFile,
    SessionResourceFilesTraits
  >;

  // Azure standard operations require resource identifier (here session id) to be passed in the request path.
  // But for sessions, session identifier needs to be passed as a query parameter for conformity with other operations.
  // So we need to use custom operations instead of standard operations.
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

// Azure standard operations require resource identifier (here session id) to be passed in the request path.
// But for sessions, session identifier needs to be passed as a query parameter for conformity with other operations.
// So we need to use custom operations instead of standard operations.
@route("/session")
@added(Versions.v2025_02_02_preview)
interface SessionManagement {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @doc("Get the session.")
  @get
  get is Foundations.Operation<SessionIdentifier, Session>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @doc("Delete the session.")
  @delete
  delete is Foundations.Operation<
    SessionIdentifier,
    TypeSpec.Http.NoContentResponse
  >;
}

// Azure standard operations require resource identifier (here session id) to be passed in the request path.
// But for sessions, session identifier needs to be passed as a query parameter for conformity with other operations.
// So we need to use custom operations instead of standard operations.
@route("/listSessions")
@added(Versions.v2025_02_02_preview)
interface ListSessions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @doc("List the sessions.")
  @get
  get is Foundations.Operation<
    {
      @doc("The offset for pagination purpose.")
      @query
      skip?: int32;
    },
    SessionsListResponse
  >;
}

// Azure standard operations require resource identifier (here session id) to be passed in the request path.
// But for sessions, session identifier needs to be passed as a query parameter for conformity with other operations.
// So we need to use custom operations instead of standard operations.
@added(Versions.v2025_02_02_preview)
interface SessionPoolMetadata {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @doc("Get the metadata information.")
  @route("/metadata")
  @get
  get is Foundations.Operation<{}, SessionPoolMetadataResponse>;
}
