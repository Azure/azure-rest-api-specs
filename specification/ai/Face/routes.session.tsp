import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.session.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

alias SessionCommonDescription = "A session is best for client device scenarios where developers want to authorize a client device to perform only a liveness detection without granting full access to their resource. Created sessions have a limited life span and only authorize clients to perform the desired action before access is expired.";
alias LivenessSessionWithVerifyDescription = """
  ${SessionCommonDescription}
  
  Permissions includes...
  >
  *
    * A token lifetime of 10 minutes.
  
  > [!NOTE]
  >
  > *
  >   * Client access can be revoked by deleting the session using the Delete Liveness With Verify Session operation.
  >   * To retrieve a result, use the Get Liveness With Verify Session.
  >   * To audit the individual requests that a client has made to your resource, use the List Liveness With Verify Session Audit Entries.
  """;

alias CreateLivenessSessionDescription = """
  ${SessionCommonDescription}
  
  Permissions includes...
  >
  *
    * A token lifetime of 10 minutes.
  
  > [!NOTE]
  > Client access can be revoked by deleting the session using the Delete Liveness Session operation. To retrieve a result, use the Get Liveness Session. To audit the individual requests that a client has made to your resource, use the List Liveness Session Audit Entries.
  """;
alias CreateLivenessWithVerifySessionWithVerifyImageDescription = """
  ${LivenessSessionWithVerifyDescription}
  
  Recommended Option: VerifyImage is provided during session creation.
  """;
alias CreateLivenessWithVerifySessionDescription = """
  ${LivenessSessionWithVerifyDescription}
  
  Alternative Option: Client device submits VerifyImage during the /detectLivenessWithVerify/singleModal call.
  > [!NOTE]
  > Extra measures should be taken to validate that the client is sending the expected VerifyImage.
  """;
alias SessionCreationSuccess = "A successful call create a session for a client device and provide an authorization token for use by the client application for a limited purpose and time.";
alias DeleteSessionSummary = "Delete all session related information for matching the specified session id.";
alias DeleteSessionDescription = """
  > [!NOTE]
  > Deleting a session deactivates the Session Auth Token by blocking future API calls made with that Auth Token. While this can be used to remove any access for that token, those requests will still count towards overall resource rate limits. It's best to leverage TokenTTL to limit length of tokens in the case that it is misused.
  """;
alias ListSessionDescription = """
  List sessions from the last sessionId greater than the 'start'.
  
  The result should be ordered by sessionId in ascending order.
  """;
alias ListSessionAuditEntriesDescription = "Gets session requests and response body for the session.";
alias CreateLivenessSessionSummary = "Create a new detect liveness session.";
alias GetLivenessSessionResultDescription = "Get session result of detectLiveness/singleModal call.";
alias ListLivenessSessionsSummary = "Lists sessions for /detectLiveness/SingleModal.";
alias CreateLivenessWithVerifySessionWithVerifyImageSummary = "Create a new liveness session with verify. Provide the verify image during session creation.";
alias CreateLivenessWithVerifySessionSummary = "Create a new liveness session with verify. Client device submits VerifyImage during the /detectLivenessWithVerify/singleModal call.";
alias GetLivenessWithVerifySessionResultDescription = "Get session result of detectLivenessWithVerify/singleModal call.";
alias ListLivenessWithVerifySessionsSummary = "Lists sessions for /detectLivenessWithVerify/SingleModal.";
alias GetSessionImageDescription = "Get session image stored during the liveness session.";
alias GetLivenessSessionSettingDescription = "Get the liveness sessions setting object.";
alias PatchLivenessSessionSettingDescription = "Update the liveness setting object.";
alias SuccessfullyDeletedSession = "Successfully deleted session and all correlated data.";
alias GetClientAssetsAccessTokenDescription = "Get access token to get access to client AI model assets.";

@get
@action("audit")
@actionSeparator("/")
op FaceLivenessSessionListAuditEntries<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  ListRequestOptions,
  Body<LivenessSessionAuditEntry[]>,
  ServiceTraits,
  FaceErrorResponse
>;

alias Operations = Azure.Core.ResourceOperations<
  ServiceTraits,
  FaceErrorResponse
>;

interface LivenessSessionOperations {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "createLivenessSession")
  @doc(CreateLivenessSessionDescription)
  @summary(CreateLivenessSessionSummary)
  @returnsDoc(SessionCreationSuccess)
  createLivenessSessionBeforeV1_2 is FaceResourceCreateWithServiceProvidedName<
    LivenessSessionBeforeV1_2,
    BodyParameter<CreateLivenessSessionContent>,
    CreateLivenessSessionResult
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "deleteLivenessSession")
  @summary(DeleteSessionSummary)
  @doc(DeleteSessionDescription)
  @returnsDoc(SuccessfullyDeletedSession)
  deleteLivenessSessionBeforeV1_2 is FaceResourceDeleteOperation<LivenessSessionBeforeV1_2>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "getLivenessSessionResult")
  @doc(GetLivenessSessionResultDescription)
  getLivenessSessionResultBeforeV1_2 is FaceResourceReadOperation<LivenessSessionBeforeV1_2>;

  @removed(Versions.v1_2)
  @doc(ListSessionDescription)
  @summary(ListLivenessSessionsSummary)
  getLivenessSessions is FaceResourceListOperation<
    LivenessSessionBeforeV1_2,
    LivenessSessionItem
  >;

  @removed(Versions.v1_2)
  @doc(ListSessionAuditEntriesDescription)
  getLivenessSessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessSessionBeforeV1_2>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  #suppress "@azure-tools/typespec-azure-core/byos" "Representation of existing multipart/form-data operation"
  @removed(Versions.v1_2)
  @doc(CreateLivenessWithVerifySessionWithVerifyImageDescription)
  @summary(CreateLivenessWithVerifySessionWithVerifyImageSummary)
  @returnsDoc(SessionCreationSuccess)
  @sharedRoute
  createLivenessWithVerifySessionWithVerifyImage is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySessionBeforeV1_2,
    CreateLivenessWithVerifySessionRequestBeforeV1_2,
    CreateLivenessWithVerifySessionResult
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "createLivenessWithVerifySession")
  @doc(CreateLivenessWithVerifySessionDescription)
  @summary(CreateLivenessWithVerifySessionSummary)
  @returnsDoc(SessionCreationSuccess)
  @sharedRoute
  createLivenessWithVerifySessionBeforeV1_2 is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySessionBeforeV1_2,
    BodyParameter<CreateLivenessWithVerifySessionJsonContent>,
    CreateLivenessWithVerifySessionResult
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "deleteLivenessWithVerifySession")
  @summary(DeleteSessionSummary)
  @doc(DeleteSessionDescription)
  @returnsDoc(SuccessfullyDeletedSession)
  deleteLivenessWithVerifySessionBeforeV1_2 is FaceResourceDeleteOperation<LivenessWithVerifySessionBeforeV1_2>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "getLivenessWithVerifySessionResult")
  @doc(GetLivenessWithVerifySessionResultDescription)
  getLivenessWithVerifySessionResultBeforeV1_2 is FaceResourceReadOperation<LivenessWithVerifySessionBeforeV1_2>;

  @removed(Versions.v1_2)
  @summary(ListLivenessWithVerifySessionsSummary)
  @doc(ListSessionDescription)
  getLivenessWithVerifySessions is FaceResourceListOperation<
    LivenessWithVerifySessionBeforeV1_2,
    LivenessSessionItem
  >;

  @removed(Versions.v1_2)
  @doc(ListSessionAuditEntriesDescription)
  getLivenessWithVerifySessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessWithVerifySessionBeforeV1_2>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Workaround for redefine path for operation."
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Does not fit in resource operation pattern."
  @added(Versions.v1_2_preview_1)
  @removed(Versions.v1_2)
  @renamedFrom(Versions.v1_2, "getSessionImage")
  @doc(GetSessionImageDescription)
  @get
  @route("session/sessionImages/{sessionImageId}")
  getSessionImageBeforeV1_2 is Azure.Core.RpcOperation<
    {
      @doc("The request ID of the image to be retrieved")
      @path
      sessionImageId: string;
    },
    SessionImageStream,
    ServiceTraits,
    FaceErrorResponse
  >;

  @added(Versions.v1_2)
  @doc(CreateLivenessSessionDescription)
  @summary(CreateLivenessSessionSummary)
  @returnsDoc(SessionCreationSuccess)
  createLivenessSession is FaceResourceCreateWithServiceProvidedName<
    LivenessSession,
    BodyParameter<CreateLivenessSessionContent>,
    LivenessSession
  >;

  @added(Versions.v1_2)
  @summary(DeleteSessionSummary)
  @doc(DeleteSessionDescription)
  @returnsDoc(SuccessfullyDeletedSession)
  deleteLivenessSession is Operations.ResourceDelete<LivenessSession>;

  @added(Versions.v1_2)
  @doc(GetLivenessSessionResultDescription)
  getLivenessSessionResult is Operations.ResourceRead<LivenessSession>;

  #suppress "@azure-tools/typespec-azure-core/byos" "Representation of existing multipart/form-data operation"
  @added(Versions.v1_2)
  @doc(LivenessSessionWithVerifyDescription) // No need to add option descriptions about providing VerifyImage since we only keep MFD request
  @summary(CreateLivenessWithVerifySessionWithVerifyImageSummary)
  @returnsDoc(SessionCreationSuccess)
  createLivenessWithVerifySession is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    CreateLivenessWithVerifySessionRequest,
    LivenessWithVerifySession
  >;

  @added(Versions.v1_2)
  @summary(DeleteSessionSummary)
  @doc(DeleteSessionDescription)
  @returnsDoc(SuccessfullyDeletedSession)
  deleteLivenessWithVerifySession is Operations.ResourceDelete<LivenessWithVerifySession>;

  @added(Versions.v1_2)
  @doc(GetLivenessWithVerifySessionResultDescription)
  getLivenessWithVerifySessionResult is Operations.ResourceRead<LivenessWithVerifySession>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Does not fit in resource operation pattern."
  @added(Versions.v1_2)
  @doc(GetSessionImageDescription)
  @get
  @route("sessionImages/{sessionImageId}")
  getSessionImage is Azure.Core.RpcOperation<
    {
      @doc("The request ID of the image to be retrieved")
      @path
      sessionImageId: string;
    },
    SessionImageStream,
    ServiceTraits,
    FaceErrorResponse
  >;

  @added(Versions.v1_3_preview_1)
  @doc(GetClientAssetsAccessTokenDescription)
  @get
  @route("settings/getClientAssetsAccessToken")
  getClientAssetsAccessToken is Azure.Core.RpcOperation<
    {},
    ClientAssetsAccessTokenResponse,
    ServiceTraits,
    FaceErrorResponse
  >;

  @added(Versions.v1_3_preview_1)
  @doc(GetLivenessSessionSettingDescription)
  @get
  @route("settings")
  getSettings is Azure.Core.RpcOperation<
    {},
    Settings,
    ServiceTraits,
    FaceErrorResponse
  >;

  @added(Versions.v1_3_preview_1)
  @doc(PatchLivenessSessionSettingDescription)
  @patch(#{ implicitOptionality: true })
  @route("settings")
  patchSettings is Azure.Core.RpcOperation<
    BodyParameter<Settings>,
    Settings,
    ServiceTraits,
    FaceErrorResponse
  >;
}
