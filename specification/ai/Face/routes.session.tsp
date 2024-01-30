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

interface BaseSessions<
  T extends LivenessSessionItem,
  U extends BaseSessionAuditEntry
> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("""
Lists all matching session types.
List sessions from the last sessionId greater than the \"start\".
The result should be ordered by sessionId in ascending order.
""")
  listSessions is FaceResourceListOperation<T, LivenessSessionItem>;

  @doc("Get session result of detectLiveness.")
  getSession is Operations.ResourceRead<T>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceDelete does not fit, we return 200 instead of 204"
  @doc("Deletes a session and all of it's audit results.")
  @deletesResource(T)
  deleteSession is FaceResourceDeleteOperation<T>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceList does not fit, we put object array in response directly"
  @doc("Get session audit requests/responses for the session.")
  listSessionAuditEntries is Foundations.NonPagedResourceList<
    U,
    ServiceTraits & ListQueryParametersTrait<ListRequestOptions>
  >;
}

interface LivenessSessions
  extends BaseSessions<LivenessSession, LivenessSessionAuditEntry> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceCreateWithServiceProvidedName does not fit, we don't return Location in header."
  @doc("Creates face liveness detection session.")
  createSession is FaceResourceCreateWithServiceProvidedName<
    LivenessSession,
    LivenessSessionCreationContent,
    LivenessSessionCreationResult
  >;
}

interface LivenessWithVerifySessions
  extends BaseSessions<
      LivenessWithVerifySession,
      LivenessWithVerifySessionAuditEntry
    > {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "ResourceCreateWithServiceProvidedName does not fit, we don't return Location in header."
  @doc("Creates face liveness detection session.")
  @sharedRoute
  createSession is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    LivenessSessionCreationContent,
    LivenessSessionCreationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/byos" "Representation of existing multipart/form-data operation"
  @doc("Creates face liveness detection session with verify image.")
  @sharedRoute
  createSessionWithVerifyImage is FaceResourceCreateWithServiceProvidedName<
    LivenessWithVerifySession,
    LivenessSessionWithVerifyImageCreationContent,
    LivenessSessionCreationResult
  >;
}
