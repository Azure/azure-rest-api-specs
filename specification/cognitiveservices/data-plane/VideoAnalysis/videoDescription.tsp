import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./shared.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.ClientGenerator.Core;

namespace VideoAnalysis;

@pattern("^[a-z0-9-_]+$")
@maxLength(32)
@minLength(1)
scalar TaskName extends string;

@doc("The ApiVersion query parameter for VideoAnalysisTask API.")
model VideoAnalysisTaskApiVersionParameter {
    @doc("The API version to use for this operation.")
    @query("api-version")
    @minLength(1)
    apiVersion?: string;
}

@doc("Time range considering the offset from 0.0s and lasting a duration.")
model TimeRange {
    @doc("Offset in ISO 8601 duration format, i.e., P[n]Y[n]M[n]DT[n]H[n]M[n]S or P[n]W.")
    offset: string;

    @doc("Duration in ISO 8601 duration format, i.e., P[n]Y[n]M[n]DT[n]H[n]M[n]S or P[n]W.")
    duration?: string;
}

@doc("Authentication method to be used.")
@discriminator("kind")
model AuthenticationModel {
    @doc("Type of authentication used")
    kind: AuthenticationModelType;
}

@doc("No authentication model")
model NoneAuthenticationModel extends AuthenticationModel {
    kind: AuthenticationModelType.none;
}

@doc("Key based authentication model")
model KeyAuthenticationModel extends AuthenticationModel {
    kind: AuthenticationModelType.key;

    @doc("Key used to authenticate.")
    key: string;
}

@doc("Azure Managed Identity authentication model")
model ManagedIdentityAuthenticationModel extends AuthenticationModel {
    kind: AuthenticationModelType.managedIdentity;
}

@doc("Represents the Video Analysis Task response model for the JSON document. Returned after the creation of a video analysis task.")
@resource("videodescriptions")
model VideoAnalysisTaskResponseModel {
    @key("taskName")
    @doc("Video analysis task name information.")
    @visibility("read", "create")
    taskName: TaskName;

    @doc("Video analysis batch name information.")
    batchName: string;

    @doc("Datetime when the video analysis task was created.")
    createdDateTime: utcDateTime;

    @doc("Datetime when the video analysis task was last modified.")
    lastModifiedDateTime: utcDateTime;

    @doc("Task status.")
    status: TaskStatusModel;

    @doc("Error related to the video analysis task.")
    error?: ErrorResponse;

    @doc("Video analysis task result.")
    taskResult?: string; // TODO - Should replace Task Result

    @doc("Read only. The latest ETag for the dataset. May be used with the 'If-Match' header when updating or deleting a dataset.")
    @visibility("read")
    etag: string;
}

@doc("A task that describes a video")
@error
model VideoDescriptionTaskRequestModel {
    @key("taskName")
    @doc("Video analysis task name information.")
    @visibility("read", "create")
    taskName: TaskName;

    @doc("Video Analysis Task Input content information")
    input: InputResourceLocationModel;

    @doc("Video Analysis Task Output content information")
    output: OutputResourceLocationModel;

    @doc("Resources components used for the Video Analysis Task")
    resource: Resource;

    @doc("TODO - Replace properties")
    properties?: PropertiesConfigModel;
}

@doc("Input resource Location")
@discriminator("kind")
model InputResourceLocationModel {
    @doc("Input resource location kind")
    kind: InputResourceLocationModelKind;

    @doc("It represents the preset configuration that will be used to run this task")
    preset?: PresetConfigurationModel;
}

@doc("Resource Location")
@discriminator("kind")
model OutputResourceLocationModel {
    @doc("Input resource location kind")
    kind: OutputResourceLocationModelKind;
}

@doc("Files accessed without authentication")
model FileResourceLocationModel extends InputResourceLocationModel {
    kind: InputResourceLocationModelKind.file;
    url: url;
    range?: TimeRange;
}

@doc("Authenticated resource definition")
model AuthenticatedResourceModel {
    @doc("Authentication information")
    authentication?: AuthenticatedResourceModel;
}

@doc("Files accessed through Azure Storage Account authentication")
model AzureBlobFileResourceLocationModel extends InputResourceLocationModel {
    kind: InputResourceLocationModelKind.azureBlobFile;
    url: url;
    range?: TimeRange;
    ...AuthenticatedResourceModel;
}

@doc("Files accessed without authentication")
model AzureBlobContainerResourceLocationModel
    extends OutputResourceLocationModel {
    kind: OutputResourceLocationModelKind.azureBlobContainer;
    containerUrl: url;
    prefix?: string;
    ...AuthenticatedResourceModel;
}

@doc("AI Resources to be used")
model Resource {
    @doc("Completion resource model to be used")
    completion: CompletionResourceModel;
}

@doc("Completion resource model definition")
@discriminator("kind")
model CompletionResourceModel {
    kind: CompletionResourceModelType;
}

@doc("Gptv completion resource model definition")
model GptvCompletionResourceModel extends CompletionResourceModel {
    @doc("GPTv completion resource model type")
    kind: CompletionResourceModelType.gptv;

    @doc("Model Endpoint")
    endpoint: url;

    @doc("Model deployment name")
    deploymentName?: string;

    ...AuthenticatedResourceModel;
}

@doc("User defined properties")
model PropertiesConfigModel {
    ...Record<PropertyConfigurationModel>;
}

@doc("Customized Property Configuration")
@discriminator("kind")
model PropertyConfigurationModel {
    kind: PropertyConfigurationModelType;
}

@doc("Describe property definition")
model DescribePropertyConfigurationModel extends PropertyConfigurationModel {
    kind: PropertyConfigurationModelType.describe;

    @doc("Property description")
    description: string;

    examples?: string[];
}

@doc("Error response object.")
@error
model ErrorResponse {
    @doc("Error info.")
    error: Error;
}

@doc("The error object.")
@clientName("DocumentIntelligenceError", "csharp")
model Error {
    @doc("One of a server-defined set of error codes.")
    code: string;

    @doc("A human-readable representation of the error.")
    message: string;

    @doc("The target of the error.")
    target?: string;

    @doc("An array of details about specific errors that led to this reported error.")
    details?: Error[];

    @doc("An object containing more specific information than the current object about the error.")
    innererror?: InnerError;
}

@doc("An object containing more specific information about the error.")
model InnerError {
    @doc("One of a server-defined set of error codes.")
    code?: string;

    @doc("A human-readable representation of the error.")
    message?: string;

    #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "https://github.com/Azure/typespec-azure/issues/417"
    @doc("Inner error.")
    @clientName("InnerErrorObject", "csharp")
    innererror?: InnerError;
}

@lroStatus
@doc("Operation status.")
union TaskStatusModel {
    string,

    @doc("The operation has not started yet.")
    notStarted: "notStarted",

    @doc("The operation is in progress.")
    running: "running",

    @doc("The operation has failed.")
    @lroFailed
    failed: "failed",

    @doc("The operation has succeeded.")
    @lroSucceeded
    succeeded: "succeeded",

    @doc("The operation is running and is writting back results.")
    @lroSucceeded
    partiallyCompleted: "completed",

    @doc("The operation has failed but wrote partial results back.")
    partiallyCompletedFailed: "partiallyCompletedFailed",

    @doc("The operation has been canceled.")
    @lroCanceled
    canceled: "canceled",
}

@doc("Preset Configuration")
union PresetConfigurationModel {
    string,
    @doc("Default preset configuration") "default",
    @doc("Example 1 preset configuration") "example1",
}

@doc("Authentication model type: None, Key, MI")
union AuthenticationModelType {
    string,

    @doc("No authentication")
    none: "None",

    @doc("Key based authentication")
    key: "Key",

    @doc("Azure Managed Identity authentication")
    managedIdentity: "ManagedIdentity",
}

@doc("Input resource location model kind")
union InputResourceLocationModelKind {
    string,

    @doc("Resource Location is publicly available")
    file: "File",

    @doc("Resource Location is a file on an Azure Storage Account")
    azureBlobFile: "AzureBlobFile",
}

@doc("Output resource location model kind")
union OutputResourceLocationModelKind {
    string,

    @doc("Resource Location is a container on an Azure Storage Account")
    azureBlobContainer: "AzureBlobContainer",
}

@doc("Completion resources model types")
union CompletionResourceModelType {
    string,

    @doc("Completion resource based on GPTv APIs")
    gptv: "Gptv",
}

@doc("Property Configuration model types")
union PropertyConfigurationModelType {
    string,

    @doc("Describe property configuration type")
    describe: "describe",
}

@doc("Property items configuration acceptable types")
union PropertyItemConfigurationModelType {
    string,
    @doc("String items") "string",
}

op VideoAnalysisTaskOperationLongRunningOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model
> is Foundations.Operation<
    TParams,
    TypeSpec.Http.AcceptedResponse &
        Foundations.RetryAfterHeader & {
            @pollingLocation
            @header("Operation-Location")
            operationLocation: ResourceLocation<TResponse>;
        },
    JobServiceTraits,
    VideoAnalysisTaskResponseModel
>;

@tag("VideoDescription")
@added(Versions.v2024_05_01_preview)
interface VideoDescriptions {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
    @doc("Creates a video analysis task for the specified video file.")
    @pollingOperation(VideoDescriptions.get)
    @route("/videodescriptions/{taskName}")
    create is VideoAnalysisTaskOperationLongRunningOperation<
        {
            ...VideoDescriptionTaskRequestModel;

            @doc("Input content type")
            @header
            contentType: "application/json";
        },
        VideoAnalysisTaskResponseModel
    >;

    @doc("Retrieves the video analysis task status/result.")
    get is JobOperations.ResourceRead<VideoAnalysisTaskResponseModel>;

    @doc("Retrieves all video analysis task status.")
    list is JobOperations.ResourceList<VideoAnalysisTaskResponseModel>;

    @doc("Deletes a video analysis task.")
    @delete
    delete is JobOperations.ResourceDelete<VideoAnalysisTaskResponseModel>;
}
