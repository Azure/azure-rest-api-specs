import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Face;

@doc("The operation mode for the liveness modal.")
union LivenessOperationMode {
  string,

  @doc("The operation mode for the liveness modal.")
  "Passive",
}

#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Provide convenient interface for multipart/form-data in SDK"
@doc("Request for creating liveness session.")
model LivenessSessionCreationContent {
  @doc("The operation mode for the liveness modal.")
  livenessOperationMode: LivenessOperationMode;

  @doc("Whether or not send back the operation response to client.")
  sendResultsToClient?: boolean;

  @doc("Whether or not the device correlation id is set by the client.")
  deviceCorrelationIdSetInClient?: boolean;

  ...LivenessSessionData;
}

@doc("Data for liveness session.")
model LivenessSessionData {
  @doc("Device Correlation Id to use for linking multiple sessions together.")
  deviceCorrelationId: string;

  @doc("Session length in seconds. Range is 60 to 86400 seconds.")
  @minValue(60)
  @maxValue(86400)
  authTokenTimeToLiveInSeconds?: int32 = 600;
}

@doc("Session data returned for enumeration.")
model LivenessSessionItem {
  @doc("Unique ID to reference this session.")
  @key("sessionId")
  @visibility("read")
  id: string;

  @doc("Session creation time in millisecond from epoch.")
  @visibility("read")
  createdDateTime: utcDateTime;

  @doc("Session started time from session auth token.")
  @visibility("read")
  sessionStartDateTime?: utcDateTime;

  @doc("Whether or not the session is expired.")
  @visibility("read")
  sessionExpired: boolean;

  ...LivenessSessionData;
}

@doc("Session details data.")
model LivenessSessionDetails {
  @doc("The session status.")
  @visibility("read")
  status: FaceSessionStatus;

  @doc("The last result of session.")
  @visibility("read")
  result?: LivenessSessionAuditEntry;
}

@doc("Session result of detect liveness.")
@resource("detectLiveness/singleModal/sessions")
model LivenessSession is LivenessSessionItem {
  ...LivenessSessionDetails;
}

@doc("Session result of detect liveness with verify.")
@resource("detectLivenessWithVerify/singleModal/sessions")
model LivenessWithVerifySession is LivenessSessionItem {
  ...LivenessSessionDetails;
}

@doc("Response of liveness session creation.")
model LivenessSessionCreationResult {
  @doc("Unique ID to reference this session.")
  sessionId: string;

  @doc("Authorization token for use by the client application")
  authToken: string;
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

@doc("Audit entry for a request in the session.")
model SessionAuditEntryRequestInfo {
  @doc("The relative URL of the liveness request.")
  url: string;

  @doc("The HTTP method of the request.")
  method: string;

  @doc("The length of the request body in bytes.")
  contentLength?: int64;

  @doc("The content type of the request.")
  contentType: string;

  @doc("The user agent of the request.")
  userAgent?: string;
}

@doc("Audit entry for a response in the session.")
model SessionAuditEntryResponseInfo {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Represent complex JSON object"
  @doc("The response body.")
  body: Record<unknown>;

  @doc("The HTTP status code of the request.")
  statusCode: int32;

  @doc("The latency of the request.")
  latencyInMilliseconds: int64;
}

@doc("Audit entry for a request in session.")
model LivenessSessionAuditEntry {
  @doc("ID of this audit entry.")
  id: int64;

  @doc("Session ID of this audit entry.")
  sessionId: string;

  @doc("Request ID in the request header.")
  requestId: string;

  @doc("Client request ID in the request header.")
  clientRequestId: string;

  @doc("The UTC date time of the request.")
  receivedDateTime: utcDateTime;

  @doc("The request of this entry.")
  request: SessionAuditEntryRequestInfo;

  @doc("The response of this entry.")
  response: SessionAuditEntryResponseInfo;

  @doc("The digest of the request body.")
  digest: string;
}

#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Provide convenient interface for multipart/form-data in SDK"
@doc("Dedicated parameter model for multipart/form-data.")
model LivenessSessionCreationContentForMultipart {
  ...LivenessSessionCreationContent;
}

@doc("Request of liveness with verify session creation.")
model LivenessSessionWithVerifyImageCreationContent {
  @doc("The content type for the operation. Always multipart/form-data for this operation.")
  @header("content-type")
  contentType: "multipart/form-data";

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("The parameters for creating session.")
  Parameters: LivenessSessionCreationContentForMultipart;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("The image stream for verify.")
  VerifyImage: bytes;
}
