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
  /** Execute code in a session. */
  @route("/executions")
  execute is RpcOperation<
    {
      ...ExecutionOperationIdHeader;

      /** The request to execute code. */
      @body
      codeExecutionRequest: SessionCodeExecutionRequest;
    },
    SessionCodeExecutionResource &
      ExecutionOperationIdHeader &
      Foundations.LongRunningStatusLocation,
    CodeExecutionTraits
  >;

  /** Get the code execution result. */
  get is CodeExecutionOperations.ResourceRead<SessionCodeExecutionResource>;
}

alias SessionResourceFilesQueryParamsTrait = QueryParametersTrait<{
  ...SessionIdentifier;
  ...SessionResourceFilePathQueryParameter;
}>;
alias SessionResourceFilesListQueryParamsTrait = QueryParametersTrait<{
  ...SessionIdentifier;
  ...SessionResourceFilePathQueryParameter;
  ...SessionResourceFileRecursiveListParameter;
}>;

alias SessionResourceFilesOperations = Azure.Core.ResourceOperations<BaseOperationTraits>;

interface SessionResourceFiles {
  /** List the file resources. */
  list is SessionResourceFilesOperations.ResourceList<
    SessionResourceFile,
    SessionResourceFilesListQueryParamsTrait
  >;

  /** Get the file resource. */
  get is SessionResourceFilesOperations.ResourceRead<
    SessionResourceFile,
    SessionResourceFilesQueryParamsTrait
  >;

  /** Delete the file. */
  delete is SessionResourceFilesOperations.ResourceDelete<
    SessionResourceFile,
    SessionResourceFilesQueryParamsTrait
  >;

  /** Upload a file to a session. */
  #suppress "@azure-tools/typespec-azure-core/byos" "Storage service is not used"
  @route("/files")
  upload is RpcOperation<
    {
      /** The content type for the operation. Always multipart/form-data for this operation. */
      @header("content-type")
      contentType: "multipart/form-data";

      /** Multipart body */
      @multipartBody body: {
        /** The file to upload. */
        file: HttpPart<bytes>;
      };
    },
    SessionResourceFile,
    SessionResourceFilesQueryParamsTrait
  >;

  // Azure standard operations require resource identifier (here session id) to be passed in the request path.
  // But for sessions, session identifier needs to be passed as a query parameter for conformity with other operations.
  // So we need to use custom operations instead of standard operations.
  /** Get the content of the file. */
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "GET allowed on Action"
  @get
  @action("content")
  @actionSeparator("/")
  getContent is SessionResourceFilesOperations.ResourceAction<
    SessionResourceFile,
    {},
    {
      @body _: bytes;
    },
    SessionResourceFilesQueryParamsTrait
  >;
}

// Azure standard operations require resource identifier (here session id) to be passed in the request path.
// But for sessions, session identifier needs to be passed as a query parameter for conformity with other operations.
// So we need to use custom operations instead of standard operations.
@route("/session")
@added(Versions.v2025_02_02_preview)
interface SessionManagement {
  /** Get the session. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @get
  get is Foundations.Operation<SessionIdentifier, Session>;

  /** Delete the session. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
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
  /** List the sessions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @get
  get is Foundations.Operation<
    {
      /** The offset for pagination purpose. */
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
  /** Get the metadata information. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No suitable standard operation found."
  @route("/metadata")
  @get
  get is Foundations.Operation<{}, SessionPoolMetadataResponse>;
}

@route("/.management")
@added(Versions.v2025_10_02_preview)
interface SessionPoolManagement {
  /** Stop a session in a session pool. */
  @route("/stopSession")
  @post
  stopSession is RpcOperation<SessionIdentifier, OkResponse & Body<string>>;
}
