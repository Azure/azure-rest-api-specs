import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ComputerVisionClient;

/**
 * This method creates an video analysis task, which can then be used to generate
 * video insights.
 */
@summary("Creates a video analysis task for the specified video file.")
@route("/videoanalysis/videodescription/tasks/{taskName}")
@put
op createTask is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the video analysis task to be created.
     */
    @maxLength(255)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    @path
    taskName: string;

    /**
     * The request body containing the metadata that will configure the task.
     */
    @body
    body: VideoAnalysisTaskRequest;
  },
  VideoAnalysisTaskResponse
>;

/**
 * Retrieves the video analysis task with the specified task id.
 */
@summary("Retrieves the video analysis task status/result.")
@route("/videoanalysis/videodescription/tasks/{taskName}")
@get
op getStatus is Azure.Core.Foundations.Operation<
  {
    /**
     * The id of the video analysis task to retrieve.
     */
    @maxLength(255)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    @path
    taskName: string;
  },
  VideoAnalysisTaskResponse
>;

/**
 * Deletes a video analysis task independent of the task status.
 */
@summary("Deletes a video analysis task.")
@route("/videoanalysis/videodescription/tasks/{taskName}")
@delete
op deleteTask is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the video analysis task to be deleted.
     */
    @maxLength(255)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
    @path
    taskName: string;
  },
  void
>;

/**
 * Retrieves a list of all video analysis task.
 */
@summary("Retrieves all video analysis task status.")
@route("/videoanalysis/videodescription/tasks")
@get
op listTasks is Azure.Core.Foundations.Operation<
  {
    /**
     * Number of datasets to be skipped.
     */
    @maxValue(2147483647)
    @query("skip")
    skip?: int32;

    /**
     * Number of datasets to be returned after skipping.
     */
    @maxValue(30)
    @minValue(1)
    @query("top")
    top?: int32 = 10;
  },
  VideoAnalysisTaskResponseModelCollectionApiModel
>;
