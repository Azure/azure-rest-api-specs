import "@typespec/rest";
import "./videoAnalysis.tsp";

using TypeSpec.Rest;

namespace VdiVideoAnalysis;

@pattern("^[a-z0-9-_]+$")
@maxLength(32)
@minLength(1)
scalar TaskName extends string;

@doc("The ApiVersion query parameter for VideoAnalysisTask API.")
model VideoAnalysisTaskApiVersionParameter {
    @doc("The API version to use for this operation.")
    @minLength(1)
    apiVersion?: string;
}

@resource("videoDescriptions")
@doc("A task that describes a video")
model VideoDescriptionTask {
    @key("taskName")
    @doc("Video analysis task name information.")
    @visibility("read", "create")
    taskName: TaskName;

    @doc("Video analysis batch name information.")
    @visibility("read")
    batchName: string;

    @doc("Datetime when the video analysis task was created.")
    @visibility("read")
    createdDateTime: utcDateTime;

    @doc("Datetime when the video analysis task was last modified.")
    @visibility("read")
    lastModifiedDateTime: utcDateTime;

    @doc("Video Analysis Task Input content information")
    @visibility("create")
    input: {};

    @doc("Video Analysis Task Output content information")
    @visibility("create")
    output: {};

    @doc("Resources components used for the Video Analysis Task")
    @visibility("create")
    resource: Resource;

    @doc("TODO - Replace properties")
    @visibility("create")
    properties?: {};

    @doc("Task status.")
    status: {};

    @doc("Error related to the video analysis task.")
    @visibility("read")
    error?: {};

    @doc("Read only. The latest ETag for the dataset. May be used with the 'If-Match' header when updating or deleting a dataset.")
    @visibility("read")
    etag: string;
}

@doc("Video Description Task definition to be used with the Registration Service")
model VideoDescriptionAiTask is VideoAnalysisTaskRegistrationDefinition {
    @doc("Resources components used for the Video Analysis Task")
    @visibility("create")
    videoDescription: VideoDescriptionTask;
}
