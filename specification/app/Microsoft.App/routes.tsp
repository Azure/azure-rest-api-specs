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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sessionPools/{sessionPoolName}/code/execute")
  executeCode is Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      @segment("subscriptions")
      subscriptionId: uuid;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      @segment("resourceGroups")
      @maxLength(90)
      @minLength(1)
      resourceGroupName: string;

      @doc("The name of the session pool.")
      @path
      @key("sessionPoolName")
      @segment("sessionPools")
      sessionPoolName: string;

      @doc("The identifier of the session.")
      @query
      identifier: string;

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

  @doc("Get the content of the file.")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sessionPools/{sessionPoolName}/files/content/{filename}")
  getFileContent is Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      @segment("subscriptions")
      subscriptionId: uuid;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      @segment("resourceGroups")
      @maxLength(90)
      @minLength(1)
      resourceGroupName: string;

      @doc("The name of the session pool.")
      @path
      @key("sessionPoolName")
      @segment("sessionPools")
      sessionPoolName: string;

      @doc("The name of the file.")
      @path
      @key("filename")
      @segment("files")
      filename: string;

      @doc("The identifier of the session.")
      @query
      identifier: string;
    },
    bytes,
    {},
    Foundations.ErrorResponse
  >;

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
