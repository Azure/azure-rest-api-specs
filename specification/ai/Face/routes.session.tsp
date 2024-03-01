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

interface LivenessSessions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceCreateWithServiceProvidedName does not fit, we don't return Location in header."
  @doc("Creates face liveness detection session.")
  createLivenessSession is FaceResourceCreateWithServiceProvidedName<
    LivenessSession,
    LivenessSessionCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceDelete does not fit, we return 200 instead of 204"
  @doc("Deletes a session and all of it's audit results.")
  deleteLivenessSession is FaceResourceDeleteOperation<LivenessSession>;

  @doc("Get session result of detectLiveness.")
  getLivenessSession is Operations.ResourceRead<LivenessSession>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("""
Lists all matching session types.
List sessions from the last sessionId greater than the \"start\".
The result should be ordered by sessionId in ascending order.
""")
  listLivenessSessions is FaceResourceListOperation<
    LivenessSession,
    LivenessSessionItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("Get session audit requests/responses for the session.")
  listLivenessSessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessSession>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceCreateWithServiceProvidedName does not fit, we don't return Location in header."
  @doc("Creates face liveness detection session.")
  @sharedRoute
  createLivenessWithVerifySession is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    LivenessSessionCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "Representation of existing multipart/form-data operation"
  @doc("Creates face liveness detection session with verify image.")
  @sharedRoute
  createLivenessWithVerifySessionWithVerifyImage is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    LivenessSessionWithVerifyImageCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceDelete does not fit, we return 200 instead of 204"
  @doc("Deletes a session and all of it's audit results.")
  deleteLivenessWithVerifySession is FaceResourceDeleteOperation<LivenessWithVerifySession>;

  @doc("Get session result of detectLiveness.")
  getLivenessWithVerifySession is Operations.ResourceRead<LivenessWithVerifySession>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("""
Lists all matching session types.
List sessions from the last sessionId greater than the \"start\".
The result should be ordered by sessionId in ascending order.
""")
  @sharedRoute
  listLivenessWithVerifySessions is FaceResourceListOperation<
    LivenessWithVerifySession,
    LivenessSessionItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("Get session audit requests/responses for the session.")
  // change to action
  listLivenessWithVerifySessionAuditEntries is FaceLivenessSessionListAuditEntries<LivenessWithVerifySession>;
}
