import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ComputerVisionClient;

/**
 * Specify the authentication mode as a string.
 */
enum AuthenticationType {
  Sas,
  Key,
  ManagedIdentity,
}

/**
 * Resource location
 */
enum ResourceLocationModelType {
  File,
  AzureBlobContainer,
}

/**
 * Completion Resource Model
 */
enum CompletionResourceModelType {
  Gptv,
}

/**
 * Preset Task Configuration: Default or Custom
 */
enum PresetConfigurationModelType {
  default,
  custom,
}

/**
 * Task status.
 */
enum TaskStatusModel {
  notStarted,
  running,
  completed,
  failed,
  partiallyCompleted,
}

/**
 * Specify the video segmentation mode as a string.
 */
enum VideoSegmentationModeType {
  Timespan,
  Shot,
}

model VideoAnalysisTaskRequest {
  /**
   * Task version to use. Default is the latest version.
   */
  version?: string;

  input?: FileResourceLocationModel;
  output?: AzureBlobContainerResourceLocationModel;
  resource?: Resource;

  /**
   * Preset Task Configuration: Default or Custom
   */
  preset?: PresetConfigurationModelType;

  /**
   * Dictionary of <any>
   */
  properties?: Record<unknown>;
}

model FileResourceLocationModel extends ResourceLocationModel {
  url: url;
  range?: TimeRange;
  authentication?: AuthenticationModel;

  /**
   * Resource location
   */
  kind: "File";
}

model TimeRange {
  offset?: string;
  duration?: string;
}

@discriminator("kind")
model AuthenticationModel {}

@discriminator("kind")
model ResourceLocationModel {}

model AzureBlobContainerResourceLocationModel extends ResourceLocationModel {
  containerUrl: url;
  prefix?: string;
  authentication?: AuthenticationModel;

  /**
   * Resource location
   */
  kind: "AzureBlobContainer";
}

model Resource {
  /**
   * Completion resource model.
   */
  completion?: CompletionResourceModel;
}

@discriminator("kind")
model CompletionResourceModel {}

/**
 * Represents the Video Analysis Task response model for the JSON document.
 * Returned after the creation of a video analysis task.
 */
model VideoAnalysisTaskResponse {
  /**
   * Video analysis task name information.
   */
  @maxLength(255)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
  name?: string;

  /**
   * Video analysis batch name information.
   */
  batchName?: string;

  /**
   * Datetime when the video analysis task was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Datetime when the video analysis task was last modified.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * Task status.
   */
  status?: TaskStatusModel;

  /**
   * Error info.
   */
  error?: ErrorResponseDetails;

  /**
   * Represents the Video Analysis Task response model for the JSON document.
   * Returned after the creation of a video analysis task.
   */
  taskResult?: VideoAnalysisTaskResult;

  /**
   * Read only. The latest ETag for the dataset. May be used with the 'If-Match'
   * header when updating or deleting a dataset.
   */
  eTag: string;
}

/**
 * Error info.
 */
model ErrorResponseDetails {
  /**
   * Error code.
   */
  code: string;

  /**
   * Error message.
   */
  message: string;

  /**
   * Target of the error.
   */
  target?: string;

  /**
   * List of detailed errors.
   */
  details?: ErrorResponseDetails[];

  /**
   * Detailed error.
   */
  innererror?: ErrorResponseInnerError;
}

/**
 * Detailed error.
 */
model ErrorResponseInnerError {
  /**
   * Error code.
   */
  code: string;

  /**
   * Error message.
   */
  message: string;

  /**
   * Detailed error.
   */
  innererror?: ErrorResponseInnerError;
}

/**
 * Represents the Video Analysis Task response model for the JSON document.
 * Returned after the creation of a video analysis task.
 */
model VideoAnalysisTaskResult {
  /**
   * Video analysis task api version information.
   */
  @maxLength(255)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]*$")
  apiVersion?: string;

  /**
   * Input video file metadata.
   */
  metadata?: Metadata;

  /**
   * Specifies the video segmentation mode that will be used by the analysis task.
   */
  videoSegmentationMode?: VideoSegmentationModeModel;

  /**
   * Video analysis task result video segments.
   */
  videoSegments?: VideoSegment[];

  /**
   * Video analysis task result speech segment.
   */
  speechSegments?: SpeechSegment[];
}

/**
 * Input video file metadata.
 */
model Metadata {
  /**
   * URL of the video file.
   */
  videoUrl: url;

  /**
   * Input video file duration. ISO8601 duration format.
   */
  duration: string;

  /**
   * Input video resolution.
   */
  resolution: Resolution;

  /**
   * Video frames per second.
   */
  fps: int32;
}

/**
 * Input video resolution.
 */
model Resolution {
  /**
   * Video width in pixels.
   */
  width?: int32;

  /**
   * Video height in pixels.
   */
  height?: int32;
}

/**
 * Specifies the video segmentation mode that will be used by the analysis task.
 */
model VideoSegmentationModeModel {
  /**
   * Specify the video segmentation mode as a string.
   */
  kind: VideoSegmentationModeType;
}

/**
 * Video segment.
 */
model VideoSegment {
  id?: int32;
  offset?: string;
  duration?: string;
  properties?: Properties;
}

model Properties extends Record<unknown> {
  /**
   * Video segment textual description using visual and audible information.
   */
  description?: string;

  /**
   * Video segment key frames. Identified by ISO8601 duration format as offsets from
   * the start of the video.
   */
  keyFrames?: string[];

  detectedObjects?: DetectedObject[];
}

model DetectedObject {
  /**
   * Detected object label (e.g., 'car', 'people', 'face')
   */
  label?: string;

  /**
   * Detection confidence score (e.g., 0.85)
   */
  confidence?: float64;

  /**
   * Offset considering the beginning of the video where the object was detected.
   * ISO8601 duration format.
   */
  offset?: string;

  /**
   * Rectangle bounding box.definition.
   */
  boundingBox?: BoundingBox;

  properties?: Properties;
}

/**
 * Rectangle bounding box.definition.
 */
model BoundingBox {
  /**
   * Top left corner x-coordinate.
   */
  x?: float64;

  /**
   * Top left corner y-coordinate.
   */
  y?: float64;

  /**
   * Bounding box width.
   */
  width?: float64;

  /**
   * Bounding box height.
   */
  height?: float64;
}

/**
 * Video segment.
 */
model SpeechSegment {
  offset?: string;
  duration?: string;
  nBest?: SpeechTranscript[];
  speaker?: int32;
}

/**
 * Speech transcript.
 */
model SpeechTranscript {
  /**
   * Speech transcript confidence.
   */
  confidence?: float64;

  /**
   * Speech recognized transcript.
   */
  display?: string;
}

/**
 * Contains an array of results that may be paginated.
 */
model VideoAnalysisTaskResponseModelCollectionApiModel {
  /**
   * The array of results.
   */
  value: VideoAnalysisTaskResponse[];

  /**
   * A link to the next set of paginated results, if there are more results
   * available; not present otherwise.
   */
  nextLink?: string;
}

/**
 * Response returned when an error occurs.
 */
@error
model ErrorResponse {
  /**
   * Error info.
   */
  error: ErrorResponseDetails;
}

model GptvCompletionResourceModel extends CompletionResourceModel {
  endpoint: url;
  authentication: AuthenticationModel;
  deploymentName?: string;

  /**
   * Completion Resource Model
   */
  kind: "Gptv";
}

model KeyAuthenticationModel extends AuthenticationModel {
  key: string;

  /**
   * Specify the authentication mode as a string.
   */
  kind: "Key";
}

model ManagedIdentityAuthenticationModel extends AuthenticationModel {
  /**
   * Specify the authentication mode as a string.
   */
  kind: "ManagedIdentity";
}

model SasAuthenticationModel extends AuthenticationModel {
  sas: string;

  /**
   * Specify the authentication mode as a string.
   */
  kind: "Sas";
}

/**
 * Segmentation mode based on video shot boundaries.
 */
model ShotSegmentation extends VideoSegmentationModeModel {}

/**
 * Segmentation mode based on user provided time spans.
 */
model TimespanSegmentation extends VideoSegmentationModeModel {
  /**
   * Timespan used to segment the video. ISO8601 duration format.
   */
  timeSpan?: string;
}
