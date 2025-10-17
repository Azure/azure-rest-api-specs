import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Face;

@doc("The liveness operation mode to drive the client's end-user experience.")
union LivenessOperationMode {
  string,

  @doc("Utilizes a passive liveness technique that requires no additional actions from the user. Requires normal indoor lighting and high screen brightness for optimal performance. And thus, this mode has a narrow operational envelope and will not be suitable for scenarios that requires the end-user's to be in bright lighting conditions. Note: this is the only supported mode for the Mobile (iOS and Android) solution.")
  "Passive",

  @doc("This mode utilizes a hybrid passive or active liveness technique that necessitates user cooperation. It is optimized to require active motion only under suboptimal lighting conditions. Unlike the passive mode, this mode has no lighting restrictions, and thus offering a broader operational envelope. This mode is preferable on Web based solutions due to the lack of automatic screen brightness control available on browsers which hinders the Passive mode's operational envelope on Web based solutions.")
  "PassiveActive",
}

@doc("Request model for creating liveness session.")
model CreateLivenessSessionContent {
  @doc("Type of liveness mode the client should follow.")
  livenessOperationMode: LivenessOperationMode;

  @removed(Versions.v1_2)
  @doc("Whether or not to allow a '200 - Success' response body to be sent to the client, which may be undesirable for security reasons. Default is false, clients will receive a '204 - NoContent' empty body response. Regardless of selection, calling Session GetResult will always contain a response body enabling business logic to be implemented.")
  sendResultsToClient?: boolean;

  @doc("Whether or not to allow client to set their own 'deviceCorrelationId' via the Vision SDK. Default is false, and 'deviceCorrelationId' must be set in this request body.")
  deviceCorrelationIdSetInClient?: boolean;

  @doc("Whether or not store the session image.")
  @added(Versions.v1_2_preview_1)
  enableSessionImage?: boolean;

  @doc("The model version used for liveness classification. This is an optional parameter, and if this is not specified, then the latest supported model version will be chosen")
  @renamedFrom(Versions.v1_2, "livenessSingleModalModel")
  @added(Versions.v1_2_preview_1)
  livenessModelVersion?: LivenessModel;

  ...LivenessSessionData;
}

#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Provide convenient interface for multipart/form-data in SDK"
@doc("Request for creating liveness with verify session.")
model CreateLivenessWithVerifySessionJsonContent
  is CreateLivenessSessionContent {
  @doc("Whether or not return the verify image hash.")
  @added(Versions.v1_2_preview_1)
  returnVerifyImageHash?: boolean;

  @doc("Threshold for confidence of the face verification. Please refer to the documentation for more details. https://learn.microsoft.com/legal/cognitive-services/face/characteristics-and-limitations?context=%2Fazure%2Fai-services%2Fcomputer-vision%2Fcontext%2Fcontext#recognition-confidence-score")
  @added(Versions.v1_2_preview_1)
  @minValue(0)
  @maxValue(1)
  verifyConfidenceThreshold?: float32;
}

@doc("Data for liveness session.")
model LivenessSessionData {
  @doc("Unique Guid per each end-user device. This is to provide rate limiting and anti-hammering. If 'deviceCorrelationIdSetInClient' is true in this request, this 'deviceCorrelationId' must be null.")
  deviceCorrelationId?: string;

  @doc("Seconds the session should last for. Range is 60 to 86400 seconds. Default value is 600.")
  @minValue(60)
  @maxValue(86400)
  authTokenTimeToLiveInSeconds?: int32 = 600;

  @added(Versions.v1_3_preview_1)
  @doc("The number of times a client can attempt a liveness check using the same authToken. Default value is 1. Maximum value is 3.")
  numberOfClientAttemptsAllowed?: HttpPart<numberOfClientAttemptsAllowed>; // = 1;

  @added(Versions.v1_3_preview_1)
  @doc("Unique Guid per each end-user. This is to provide rate limiting and anti-hammering. If 'userCorrelationIdSetInClient' is true in this request, this 'userCorrelationId' must be null.")
  userCorrelationId?: string;

  @added(Versions.v1_3_preview_1)
  @doc("Whether or not to allow client to set their own 'userCorrelationId' via the Vision SDK. Default is false, and 'userCorrelationId' must be set in this request body.")
  userCorrelationIdSetInClient?: boolean;

  @added(Versions.v1_3_preview_1)
  @doc("Specify the expected IP address or CIDR block of the client that runs the liveness check.")
  expectedClientIpAddress?: string;
}

@doc("Session data returned for enumeration.")
model LivenessSessionItem {
  @doc("The unique ID to reference this session.")
  @key("sessionId")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("DateTime when this session was created.")
  createdDateTime: utcDateTime;

  @doc("DateTime when this session was started by the client.")
  sessionStartDateTime?: utcDateTime;

  @doc("Whether or not the session is expired.")
  sessionExpired: boolean;

  ...LivenessSessionData;
}

@doc("Session details data.")
model LivenessSessionDetails {
  @doc("The current status of the session.")
  status: FaceSessionStatus;

  @doc("The latest session audit result only populated if status == 'ResultAvailable'.")
  result?: LivenessSessionAuditEntry;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
@removed(Versions.v1_2)
@renamedFrom(Versions.v1_2, "LivenessSession")
@doc("Session result of detect liveness.")
@resource("detectLiveness/singleModal/sessions")
model LivenessSessionBeforeV1_2 is LivenessSessionItem {
  ...LivenessSessionDetails;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
@removed(Versions.v1_2)
@renamedFrom(Versions.v1_2, "LivenessWithVerifySession")
@doc("Session result of detect liveness with verify.")
@resource("detectLivenessWithVerify/singleModal/sessions")
model LivenessWithVerifySessionBeforeV1_2 is LivenessSessionItem {
  ...LivenessSessionDetails;
}

@doc("Response of liveness session creation.")
model CreateLivenessSessionResult {
  @doc("The unique session ID of the created session. It will expire 48 hours after it was created or may be deleted sooner using the corresponding Session DELETE operation.")
  sessionId: string;

  @doc("Bearer token to provide authentication for the Vision SDK running on a client application. This Bearer token has limited permissions to perform only the required action and expires after the TTL time. It is also auditable.")
  authToken: string;
}

@doc("Response of liveness session with verify creation with verify image provided.")
model CreateLivenessWithVerifySessionResult is CreateLivenessSessionResult {
  @doc("The detail of face for verification.")
  verifyImage?: LivenessWithVerifyImage;
}

@doc("The current status of the session.")
union FaceSessionStatus {
  string,

  @doc("Session has not started.")
  "NotStarted",

  @doc("Session has started.")
  "Started",

  @doc("Session has available result.")
  "ResultAvailable",
}

@doc("The outcome of the liveness classification.")
union LivenessDecision {
  string,

  @doc("The algorithm could not classify the target face as either real or spoof.")
  uncertain: "uncertain",

  @doc("The algorithm has classified the target face as real.")
  realFace: "realface",

  @doc("The algorithm has classified the target face as a spoof.")
  spoofFace: "spoofface",
}

@doc("The type of image.")
union ImageType {
  string,

  /** Color image. */
  "Color",

  /** Infrared image. */
  "Infrared",

  /** Depth image. */
  "Depth",
}

@doc("The liveness classification for target face.")
model LivenessOutputsTarget {
  @doc("The face region where the liveness classification was made on.")
  faceRectangle: FaceRectangle;

  @doc("The file name which contains the face rectangle where the liveness classification was made on.")
  fileName: string;

  @doc("The time offset within the file of the frame which contains the face rectangle where the liveness classification was made on.")
  timeOffsetWithinFile: int32;

  @doc("The image type which contains the face rectangle where the liveness classification was made on.")
  imageType: ImageType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Values are self-documenting."
@doc("The model version used for liveness classification.")
union LivenessModel {
  string,

  @removed(Versions.v1_2)
  v2022_10_15_preview_04: "2022-10-15-preview.04",

  @removed(Versions.v1_2)
  v2023_12_20_preview_06: "2023-12-20-preview.06",

  @added(Versions.v1_2)
  v2024_11_15: "2024-11-15",
}

@doc("The detail of face for verification.")
model LivenessWithVerifyImage {
  @doc("The face region where the comparison image's classification was made.")
  faceRectangle: FaceRectangle;

  @doc("Quality of face image for recognition.")
  qualityForRecognition: QualityForRecognition;
}

@doc("The face verification output.")
model LivenessWithVerifyOutputs {
  @removed(Versions.v1_2)
  @doc("The detail of face for verification.")
  verifyImage: LivenessWithVerifyImage;

  @doc("The target face liveness face and comparison image face verification confidence.")
  @minValue(0)
  @maxValue(1)
  matchConfidence: float32;

  @doc("Whether the target liveness face and comparison image face match.")
  isIdentical: boolean;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Use Record for accepting failure response"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending Record for accepting failure response"
@doc("The response body of detect liveness API call.")
model LivenessResponseBody extends Record<unknown> {
  @doc("The liveness classification for the target face.")
  livenessDecision?: LivenessDecision;

  @doc("Specific targets used for liveness classification.")
  target?: LivenessOutputsTarget;

  @doc("The model version used for liveness classification.")
  modelVersionUsed?: LivenessModel;

  @doc("The face verification output. Only available when the request is liveness with verify.")
  verifyResult?: LivenessWithVerifyOutputs;
}

@doc("Audit entry for a request in the session.")
model AuditRequestInfo {
  @doc("The relative URL and query of the liveness request.")
  url: string;

  @doc("The HTTP method of the request (i.e., GET, POST, DELETE).")
  method: string;

  @doc("The length of the request body in bytes.")
  contentLength?: int64;

  @doc("The content type of the request.")
  contentType: string;

  @doc("The user agent used to submit the request.")
  userAgent?: string;
}

@doc("Audit entry for a response in the session.")
model AuditLivenessResponseInfo {
  @doc("The response body. The schema of this field will depend on the request.url and request.method used by the client.")
  body: LivenessResponseBody;

  @doc("The HTTP status code returned to the client.")
  statusCode: int32;

  @doc("The server measured latency for this request in milliseconds.")
  latencyInMilliseconds: int64;
}

@doc("Audit entry for a request in session.")
model LivenessSessionAuditEntry {
  @doc("The unique id to refer to this audit request. Use this id with the 'start' query parameter to continue on to the next page of audit results.")
  id: int64;

  @doc("The unique sessionId of the created session. It will expire 48 hours after it was created or may be deleted sooner using the corresponding session DELETE operation.")
  sessionId: string;

  @doc("The unique requestId that is returned by the service to the client in the 'apim-request-id' header.")
  requestId: string;

  @doc("The unique clientRequestId that is sent by the client in the 'client-request-id' header.")
  clientRequestId: string;

  @doc("The UTC DateTime that the request was received.")
  receivedDateTime: utcDateTime;

  @doc("The request of this entry.")
  request: AuditRequestInfo;

  @doc("The response of this entry.")
  response: AuditLivenessResponseInfo;

  @doc("The server calculated digest for this request. If the client reported digest differs from the server calculated digest, then the message integrity between the client and service has been compromised and the result should not be trusted. For more information, see how to guides on how to leverage this value to secure your end-to-end solution.")
  digest: string;

  @doc("The image ID of the session request.")
  @added(Versions.v1_2_preview_1)
  sessionImageId?: string;

  @doc("The sha256 hash of the verify-image in the request.")
  @added(Versions.v1_2_preview_1)
  verifyImageHash?: string;
}

@doc("Request of liveness with verify session creation.")
model CreateLivenessWithVerifySessionMultipartContent {
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("The parameters for creating session.")
  Parameters: HttpPart<CreateLivenessWithVerifySessionJsonContent>;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("The image stream for verify. Content-Disposition header field for this part must have filename.")
  VerifyImage: HttpPart<bytes>;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for update model in new version."
@removed(Versions.v1_2)
@renamedFrom(Versions.v1_2, "CreateLivenessWithVerifySessionRequest")
@doc("Request wrapper of liveness with verify session creation.")
model CreateLivenessWithVerifySessionRequestBeforeV1_2 {
  @doc("The content type for the operation. Always multipart/form-data for this operation.")
  @header("content-type")
  contentType: "multipart/form-data";

  @doc("Request content of liveness with verify session creation.")
  @multipartBody
  body: CreateLivenessWithVerifySessionMultipartContent;
}

@added(Versions.v1_2_preview_1)
@doc("Response model of get session image.")
model SessionImageStream {
  @doc("The format of the HTTP payload.")
  @header
  contentType: "application/octet-stream";

  @doc("The image to be analyzed")
  @body
  imageContent: bytes;
}

@added(Versions.v1_2)
@doc("Common liveness session data.")
model LivenessSessionCommonData {
  @doc("The unique ID to reference this session.")
  @key
  @visibility(Lifecycle.Read)
  sessionId: string;

  @doc("Bearer token to provide authentication for the Vision SDK running on a client application. This Bearer token has limited permissions to perform only the required action and expires after the TTL time. It is also auditable.")
  authToken: string;

  @doc("The current status of the session.")
  status: Foundations.OperationState;

  @doc("The model version used for liveness classification. This is an optional parameter, and if this is not specified, then the latest supported model version will be chosen")
  modelVersion?: LivenessModel;

  @added(Versions.v1_3_preview_1)
  @doc("Denotes if the abuse monitoring feature was enabled during this session.")
  isAbuseMonitoringEnabled?: HttpPart<boolean>;

  @added(Versions.v1_3_preview_1)
  @doc("The expected IP address or CIDR block of the client that runs the liveness check.")
  expectedClientIpAddress?: string;
}

@added(Versions.v1_2)
@doc("Session result of detect liveness.")
@resource("detectLiveness-sessions")
model LivenessSession is LivenessSessionCommonData {
  @doc("The results of the liveness session.")
  results: LivenessSessionResults;
}

@added(Versions.v1_2)
@doc("Session result of detect liveness with verify.")
@resource("detectLivenessWithVerify-sessions")
model LivenessWithVerifySession is LivenessSessionCommonData {
  @doc("The results of the liveness with verify session.")
  results: LivenessWithVerifySessionResults;
}

@added(Versions.v1_2)
@doc("The results of the liveness session.")
model LivenessSessionResults {
  @doc("The attempts data of underlying liveness call with the session.")
  attempts: LivenessSessionAttempt[];
}

@added(Versions.v1_2)
@doc("The results of the liveness with verify session.")
model LivenessWithVerifySessionResults {
  @doc("The references used for face verification.")
  verifyReferences: LivenessWithVerifyReference[];

  @doc("The attempts data of underlying liveness with verify call with the session.")
  attempts: LivenessWithVerifySessionAttempt[];
}

@added(Versions.v1_2)
@doc("The liveness session attempt.")
model LivenessSessionAttempt {
  @doc("The attempt ID, start from 1.")
  attemptId: int32;

  @doc("The status of the attempt.")
  attemptStatus: Foundations.OperationState;

  @doc("The result of the liveness call, will be null if there is error.")
  result?: LivenessResult;

  @doc("The error of the liveness call, will be null if there is result.")
  error?: LivenessError;

  @added(Versions.v1_3_preview_1)
  @doc("The client information gathered during the liveness attempt.")
  clientInformation?: ClientInformation[];

  @added(Versions.v1_3_preview_1)
  @doc("The abuse monitoring result for the liveness attempt.")
  abuseMonitoringResult?: AbuseMonitoringResult;
}

@added(Versions.v1_2)
@doc("The liveness with verify session attempt.")
model LivenessWithVerifySessionAttempt {
  @doc("The attempt ID, start from 1.")
  attemptId: int32;

  @doc("The status of the attempt.")
  attemptStatus: Foundations.OperationState;

  @doc("The result of the liveness with verify call, will be null if there is error.")
  result?: LivenessWithVerifyResult;

  @doc("The error of the liveness with verify call, will be null if there is result.")
  error?: LivenessError;

  @added(Versions.v1_3_preview_1)
  @doc("The client information gathered during the liveness attempt.")
  clientInformation?: ClientInformation[];

  @added(Versions.v1_3_preview_1)
  @doc("The abuse monitoring result for the liveness attempt.")
  abuseMonitoringResult?: AbuseMonitoringResult;
}

@added(Versions.v1_2)
@doc("The detail of face for verification.")
model LivenessWithVerifyReference {
  @doc("The image type which contains the face rectangle where the liveness classification was made on.")
  referenceType: ImageType;

  @doc("The face region where the comparison image's classification was made.")
  faceRectangle: FaceRectangle;

  @doc("Quality of face image for recognition.")
  qualityForRecognition: QualityForRecognition;
}

@added(Versions.v1_2)
@doc("The results of the liveness classification.")
model LivenessResult {
  @doc("The liveness classification for the target face.")
  livenessDecision?: LivenessDecision;

  @doc("Targets used for liveness classification.")
  targets: LivenessDecisionTargets;

  @doc("The server calculated digest for this request. If the client reported digest differs from the server calculated digest, then the message integrity between the client and service has been compromised and the result should not be trusted. For more information, see how to guides on how to leverage this value to secure your end-to-end solution.")
  digest: string;

  @doc("The image ID of the session request.")
  sessionImageId?: string;
}

@added(Versions.v1_2)
@doc("The results of the liveness with verify call.")
model LivenessWithVerifyResult {
  ...LivenessResult;

  @doc("The face verification output. Only available when the request is liveness with verify.")
  verifyResult?: LivenessWithVerifyOutputs;

  @doc("The sha256 hash of the verify-image in the request.")
  verifyImageHash?: string;
}

@added(Versions.v1_2)
@doc("The error of the liveness classification.")
model LivenessError {
  @doc("The error code.")
  code: string;

  @doc("The error message.")
  message: string;

  @doc("Targets used for liveness classification.")
  targets: LivenessDecisionTargets;
}

@added(Versions.v1_3_preview_1)
@doc("The client information gathered during the liveness attempt.")
model ClientInformation {
  @doc("The client ip address seen during the liveness attempt.")
  ip: string;
}

@added(Versions.v1_3_preview_1)
@doc("The abuse monitoring result for the liveness attempt.")
model AbuseMonitoringResult {
  @doc("Denotes if abuse detection triggered during this liveness attempt.")
  isAbuseDetected: HttpPart<boolean>;

  @doc("Denotes if abuse detection triggered during this liveness attempt.")
  otherFlaggedSessions: OtherFlaggedSessions[];
}

@added(Versions.v1_3_preview_1)
@doc("The other sessions flagged as abuse based on the information gathered during this attempt.")
model OtherFlaggedSessions {
  @doc("The attempt ID, start from 1.")
  attemptId: int32;

  @doc("The unique session ID of the flagged session.")
  sessionId: string;

  @doc("The image ID from the flagged session.")
  sessionImageId?: string;
}

@added(Versions.v1_2)
@doc("The targets used for liveness classification.")
model LivenessDecisionTargets {
  @doc("The target from color image used for liveness classification.")
  color: LivenessColorDecisionTarget;
}

@added(Versions.v1_2)
@doc("The target from color image used for liveness classification.")
model LivenessColorDecisionTarget {
  @doc("The face region where the liveness classification was made on.")
  faceRectangle: FaceRectangle;
}

@added(Versions.v1_2)
@doc("Request wrapper of liveness with verify session creation.")
model CreateLivenessWithVerifySessionRequest {
  @doc("The content type for the operation. Always multipart/form-data for this operation.")
  @header("content-type")
  contentType: "multipart/form-data";

  @doc("Request content of liveness with verify session creation.")
  @multipartBody
  body: CreateLivenessWithVerifySessionContent;
}

@added(Versions.v1_2)
@doc("Request of liveness with verify session creation.")
model CreateLivenessWithVerifySessionContent {
  @doc("Type of liveness mode the client should follow.")
  livenessOperationMode: HttpPart<LivenessOperationMode>;

  @doc("Whether or not to allow client to set their own 'deviceCorrelationId' via the Vision SDK. Default is false, and 'deviceCorrelationId' must be set in this request body.")
  deviceCorrelationIdSetInClient?: HttpPart<boolean>;

  @doc("Whether or not store the session image.")
  enableSessionImage?: HttpPart<boolean>;

  @doc("The model version used for liveness classification. This is an optional parameter, and if this is not specified, then the latest supported model version will be chosen")
  livenessModelVersion?: HttpPart<LivenessModel>;

  @doc("Whether or not return the verify image hash.")
  returnVerifyImageHash?: HttpPart<boolean>;

  @doc("Threshold for confidence of the face verification. Please refer to the documentation for more details. https://learn.microsoft.com/legal/cognitive-services/face/characteristics-and-limitations?context=%2Fazure%2Fai-services%2Fcomputer-vision%2Fcontext%2Fcontext#recognition-confidence-score")
  verifyConfidenceThreshold?: HttpPart<confidenceScore>;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("The image stream for verify. Content-Disposition header field for this part must have filename.")
  verifyImage: HttpPart<bytes>;

  @doc("Unique Guid per each end-user device. This is to provide rate limiting and anti-hammering. If 'deviceCorrelationIdSetInClient' is true in this request, this 'deviceCorrelationId' must be null.")
  deviceCorrelationId?: HttpPart<string>;

  @doc("Seconds the session should last for. Range is 60 to 86400 seconds. Default value is 600.")
  authTokenTimeToLiveInSeconds?: HttpPart<authTokenLifetimeInSeconds>; // = 600;

  @added(Versions.v1_3_preview_1)
  @doc("The number of times a client can attempt a liveness check using the same authToken. Default value is 1. Maximum value is 3.")
  numberOfClientAttemptsAllowed?: HttpPart<numberOfClientAttemptsAllowed>; // = 1;
}

@added(Versions.v1_3_preview_1)
@doc("Settings for liveness abuse monitoring.")
model LivenessAbuseMonitoringSetting {
  /** Whether liveness abuse monitoring is enabled */
  enabled: HttpPart<boolean>;
}

@added(Versions.v1_3_preview_1)
@doc("Response model for client assets access token.")
model ClientAssetsAccessTokenResponse {
  @doc("The expiry time of the access token.")
  expiry: utcDateTime;

  @doc("The access token for client assets.")
  accessToken: string;

  @doc("The base64 encoded access token.")
  base64AccessToken: string;
}

@added(Versions.v1_3_preview_1)
@doc("Response model for settings.")
model Settings {
  /** Liveness abuse monitoring settings */
  livenessAbuseMonitoring: LivenessAbuseMonitoringSetting;
}

@minValue(60)
@maxValue(86400)
scalar authTokenLifetimeInSeconds extends int32;

@minValue(0)
@maxValue(1)
scalar confidenceScore extends float32;

@minValue(1)
@maxValue(3)
scalar numberOfClientAttemptsAllowed extends int32;
