import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(VideoAnalysis.Versions)
namespace VideoAnalysis;

alias stdServiceTraits = NoClientRequestId &
    NoRepeatableRequests &
    NoConditionalRequests &
    TraitOverride<VersionParameterTrait<void>>;

alias StdResourceOperations = ResourceOperations<
    stdServiceTraits,
    VideoDescriptionTaskRequestModel
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "TODO - Remove"
op VideoAnalysisTaskOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model & Foundations.RetryAfterHeader
> is Foundations.Operation<
    TParams,
    TResponse,
    stdServiceTraits,
    VideoAnalysisTaskResponseModel
>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
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
    stdServiceTraits,
    VideoAnalysisTaskResponseModel
>;

@added(Versions.v2024_05_01_preview)
interface VideoDescriptions {
    // @doc("Creates a video analysis task for the specified video file.")
    // @put
    // @pollingOperation(VideoDescriptions.get)
    // @route("/videodescriptions/{taskName}")
    // create is VideoAnalysisTaskOperationLongRunningOperation<
    //     VideoDescriptionTask,
    //     AnalyzeResultOperation
    // >;

    // #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "TODO - Remove"
    // @doc("Retrieves the video analysis task status/result.")
    // @get
    // getTasks is VideoAnalysisTaskOperation<{}, AnalyzeResultOperation>;

    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "TODO - Remove"
    @doc("Retrieves all video analysis task status.")
    list is StdResourceOperations.ResourceList<VideoDescriptionTaskRequestModel>;

    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "TODO - Remove"
    @doc("Deletes a video analysis task.")
    @delete
    deleteTask is StdResourceOperations.ResourceDelete<VideoDescriptionTaskRequestModel>;
}
