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

namespace Microsoft.App;

alias SessionTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId &
  QueryParametersTrait<SessionIdentifier>;

alias SessionOperations = Azure.Core.ResourceOperations<SessionTraits>;

interface CodeExecution {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @doc("Execute code in a session.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sessionPools/{sessionPoolName}/code/execute")
  executeCode is Foundations.Operation<
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupNameParameter;
      ...SessionPoolNameParameter;
      ...SessionIdentifier;

      @doc("The request to execute code.")
      @body
      codeExecutionRequest: CodeExecutionRequest;
    },
    CodeExecutionResponse,
    {},
    Foundations.ErrorResponse
  >;
}

interface CodeExecutionFiles {
  @doc("Get the file resource.")
  getFileMetadata is SessionOperations.ResourceRead<CodeExecutionFile>;

  @doc("Delete the file.")
  deleteFile is SessionOperations.ResourceDelete<CodeExecutionFile>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @doc("Get the content of the file.")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sessionPools/{sessionPoolName}/files/content/{filename}")
  getFileContent is Foundations.Operation<
    {
      ...SubscriptionIdParameter;
      ...ResourceGroupNameParameter;
      ...SessionPoolNameParameter;
      ...CodeExecutionFileNameParameter;
      ...SessionIdentifier;
    },
    bytes,
    {},
    Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/byos" ""
  @doc("Upload a file to a session.")
  uploadFile is SessionOperations.ResourceAction<
    CodeExecutionFile,
    {
      @doc("The content type for the operation. Always multipart/form-data for this operation.")
      @header("content-type")
      contentType: "multipart/form-data";

      @doc("The file to upload.")
      file: bytes;
    },
    CodeExecutionFileCollection
  >;
}
