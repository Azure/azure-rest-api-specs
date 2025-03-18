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
    * Ability to call /detectLivenessWithVerify/singleModal for up to 3 retries.
    * A token lifetime of 10 minutes.
  
  > [!NOTE]
  >
  > *
  >   * Client access can be revoked by deleting the session using the Delete Liveness With Verify Session operation.
  >   * To retrieve a result, use the Get Liveness With Verify Session.
  >   * To audit the individual requests that a client has made to your resource, use the List Liveness With Verify Session Audit Entries.
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

interface LivenessSessionOperations {
  @doc("""
    ${SessionCommonDescription}
    
    Permissions includes...
    >
    *
      * Ability to call /detectLiveness/singleModal for up to 3 retries.
      * A token lifetime of 10 minutes.
    
    > [!NOTE]
    > Client access can be revoked by deleting the session using the Delete Liveness Session operation. To retrieve a result, use the Get Liveness Session. To audit the individual requests that a client has made to your resource, use the List Liveness Session Audit Entries.
    """)
  @summary("Create a new detect liveness session.")
  @returnsDoc(SessionCreationSuccess)
  createLivenessSession is FaceResourceCreateWithServiceProvidedName<
    LivenessSession,
    BodyParameter<CreateLivenessSessionContent>,
    CreateLivenessSessionResult
  >;

  @summary(DeleteSessionSummary)
  @doc(DeleteSessionDescription)
  @returnsDoc("Successfully deleted session and all correlated data.")
  deleteLivenessSession is FaceResourceDeleteOperation<LivenessSession>;

  @doc("Get session result of detectLiveness/singleModal call.")
  getLivenessSessionResult is FaceResourceReadOperation<LivenessSession>;

  @doc(ListSessionDescription)
  @summary("Lists sessions for /detectLiveness/SingleModal.")
  getLivenessSessions is FaceResourceListOperation<
    LivenessSession,
    LivenessSessionItem
  >;

  @doc(ListSessionAuditEntriesDescription)
  getLivenessSessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessSession>;

  #suppress "@azure-tools/typespec-azure-core/byos" "Representation of existing multipart/form-data operation"
  @doc("""
    ${LivenessSessionWithVerifyDescription}
    
    Recommended Option: VerifyImage is provided during session creation.
    """)
  @summary("Create a new liveness session with verify. Provide the verify image during session creation.")
  @returnsDoc(SessionCreationSuccess)
  @sharedRoute
  createLivenessWithVerifySessionWithVerifyImage is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    CreateLivenessWithVerifySessionRequest,
    CreateLivenessWithVerifySessionResult
  >;

  @doc("""
    ${LivenessSessionWithVerifyDescription}
    
    Alternative Option: Client device submits VerifyImage during the /detectLivenessWithVerify/singleModal call.
    > [!NOTE]
    > Extra measures should be taken to validate that the client is sending the expected VerifyImage.
    """)
  @summary("Create a new liveness session with verify. Client device submits VerifyImage during the /detectLivenessWithVerify/singleModal call.")
  @returnsDoc(SessionCreationSuccess)
  @sharedRoute
  createLivenessWithVerifySession is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    BodyParameter<CreateLivenessWithVerifySessionJsonContent>,
    CreateLivenessWithVerifySessionResult
  >;

  @summary(DeleteSessionSummary)
  @doc(DeleteSessionDescription)
  @returnsDoc("Successfully deleted session and all correlated data.")
  deleteLivenessWithVerifySession is FaceResourceDeleteOperation<LivenessWithVerifySession>;

  @doc("Get session result of detectLivenessWithVerify/singleModal call.")
  getLivenessWithVerifySessionResult is FaceResourceReadOperation<LivenessWithVerifySession>;

  @summary("Lists sessions for /detectLivenessWithVerify/SingleModal.")
  @doc("""
    List sessions from the last sessionId greater than the \"start\".
    
    The result should be ordered by sessionId in ascending order.
    """)
  getLivenessWithVerifySessions is FaceResourceListOperation<
    LivenessWithVerifySession,
    LivenessSessionItem
  >;

  @doc(ListSessionAuditEntriesDescription)
  getLivenessWithVerifySessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessWithVerifySession>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Does not fit in resource operation pattern."
  @added(Versions.v1_2_preview_1)
  @doc("Get session image stored during the liveness session.")
  @get
  @route("session/sessionImages/{sessionImageId}")
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
}
