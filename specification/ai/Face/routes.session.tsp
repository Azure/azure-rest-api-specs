import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.session.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Foundations;

namespace Face;

@get
@action("audit")
@actionSeparator("/")
op FaceLivenessSessionListAuditEntries<TResource extends TypeSpec.Reflection.Model> is Foundations.ResourceOperation<
  TResource,
  ListRequestOptions,
  Body<LivenessSessionAuditEntry[]>,
  ServiceTraits
>;

interface LivenessSessionOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceCreateWithServiceProvidedName does not fit, we don't return Location in header."
  @doc("""
  A session is best for client device scenarios where developers want to authorize a client device to perform only a liveness detection without granting full access to their resource. Created sessions have a limited life span and only authorize clients to perform the desired action before access is expired.
  Permissions includes...
  * Ability to call /detectLiveness/singleModal for up to 3 reties.
  * A token lifetime of 10 minutes.
  Remarks:
  Client access can be revoked by deleting the session using the Delete Liveness Session operation. To retrieve a result, use the Get Liveness Session. To audit the individual requests that a client has made to your resource, use the List Liveness Session Audit Entries.
  """)
  createLivenessSession is FaceResourceCreateWithServiceProvidedName<
    LivenessSession,
    LivenessSessionCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceDelete does not fit, we return 200 instead of 204"
  @doc("""
  Delete all session related information for matching the specified session id.
  Note: Deleting a session deactivates the Session Auth Token by blocking future API calls made with that Auth Token. While this can be used to remove any access for that token, those requests will still count towards overall resource rate limits. It's best to leverage TokenTTL to limit length of tokens in the case that it is misused.
  """)
  deleteLivenessSession is FaceResourceDeleteOperation<LivenessSession>;

  @doc("Get session result of detectLiveness/singleModal call.")
  getLivenessSession is Operations.ResourceRead<LivenessSession>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("""
  Lists sessions for /detectLiveness/SingleModal.
  List sessions from the last sessionId greater than the \"start\".
  The result should be ordered by sessionId in ascending order.
  """)
  listLivenessSessions is FaceResourceListOperation<
    LivenessSession,
    LivenessSessionItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("Gets session requests and response body for the session.")
  listLivenessSessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessSession>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceCreateWithServiceProvidedName does not fit, we don't return Location in header."
  @doc("""
  A session is best for client device scenarios where developers want to authorize a client device to perform only a liveness detection without granting full access to their resource. Created sessions have a limited life span and only authorize clients to perform the desired action before access is expired.
  Permissions includes...
  * Ability to call /detectLiveness/singleModal for up to 3 reties.
  * A token lifetime of 10 minutes.
  Remarks:
  Client access can be revoked by deleting the session using the Delete Liveness With Verify Session operation. To retrieve a result, use the Get Liveness With Verify Session. To audit the individual requests that a client has made to your resource, use the List Liveness With Verify Session Audit Entries.
  Alternative Option: Client device submits VerifyImage during the /detectLivenessWithVerify/singleModal call.
  """)
  @sharedRoute
  createLivenessWithVerifySession is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    LivenessSessionCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "Representation of existing multipart/form-data operation"
  @doc("""
  A session is best for client device scenarios where developers want to authorize a client device to perform only a liveness detection without granting full access to their resource. Created sessions have a limited life span and only authorize clients to perform the desired action before access is expired.
  Permissions includes...
  * Ability to call /detectLiveness/singleModal for up to 3 reties.
  * A token lifetime of 10 minutes.
  Remarks:
  Client access can be revoked by deleting the session using the Delete Liveness With Verify Session operation. To retrieve a result, use the Get Liveness With Verify Session. To audit the individual requests that a client has made to your resource, use the List Liveness With Verify Session Audit Entries.
  Recommended Option: VerifyImage is provided during session creation.
  """)
  @sharedRoute
  createLivenessWithVerifySessionWithVerifyImage is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    LivenessSessionWithVerifyImageCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceDelete does not fit, we return 200 instead of 204"
  @doc("""
  Delete all session related information for matching the specified session id.
  Note: Deleting a session deactivates the Session Auth Token by blocking future API calls made with that Auth Token. While this can be used to remove any access for that token, those requests will still count towards overall resource rate limits. It's best to leverage TokenTTL to limit length of tokens in the case that it is misused.
  """)
  deleteLivenessWithVerifySession is FaceResourceDeleteOperation<LivenessWithVerifySession>;

  @doc("Get session result of detectLivenessWithVerify/singleModal call.")
  getLivenessWithVerifySession is Operations.ResourceRead<LivenessWithVerifySession>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("""
  Lists sessions for /detectLivenessWithVerify/SingleModal.
  List sessions from the last sessionId greater than the \"start\".
  The result should be ordered by sessionId in ascending order.
  """)
  @sharedRoute
  listLivenessWithVerifySessions is FaceResourceListOperation<
    LivenessWithVerifySession,
    LivenessSessionItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("Gets session requests and response body for the session.")
  listLivenessWithVerifySessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessWithVerifySession>;
}
