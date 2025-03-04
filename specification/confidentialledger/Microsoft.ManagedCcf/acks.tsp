import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./common.tsp";
import "./cose.tsp";

@TypeSpec.Http.route("/gov/members")
namespace Microsoft.ManagedCcf.Acks;

@doc("A compact summary of the service's state up to a certain point in time, updated and signed by members to indicate their participation in and approval of the service.")
@TypeSpec.Rest.resource("state-digests")
model StateDigest {
  @doc("Identifier for member this stateDigest applies to.")
  @visibility(Lifecycle.Query)
  @key
  memberId: memberId;

  @doc("Hex-encoding of SHA-256 hash of the root of the service's merkle tree. This should be signed by a new member and submitted as an ACK to mark that member as Active.")
  @pattern("^[a-f0-9]{64}$")
  digest: string;
}

interface StateDigests {
  @doc("Request that this member's stateDigest is updated to a fresher value. Only this member may update their own stateDigest. Returns the refreshed value.")
  @TypeSpec.Rest.action("update")
  update is Azure.Core.StandardResourceOperations.ResourceAction<
    StateDigest,
    CoseSigned,
    StateDigest,
    TxIdWriteHeader
  >;

  @doc("Submit a signed acknowledgement of a recent digest of the service status, to transition the member to Active.")
  @TypeSpec.Rest.action("ack")
  acknowledge is Azure.Core.StandardResourceOperations.ResourceAction<
    StateDigest,
    CoseSigned<StateDigest>,
    TypeSpec.Http.NoContentResponse,
    TxIdWriteHeader
  >;

  @doc("Get the stateDigest assigned to the given member, which that member must sign to become active.")
  get is Azure.Core.StandardResourceOperations.ResourceRead<
    StateDigest,
    TxIdReadHeader
  >;
}
