import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./cose.tsp";
import "./common.tsp";

@TypeSpec.Http.route("/gov/recovery")
namespace Microsoft.ManagedCcf.Recovery;

@doc("A share of a recovery key, granted for a specific recovery member, and encrypted with that member's share-encryption key. This is safe to share in the ledger or amongst untrusted callers, as only the intended member will be able to decrypt and access the secret content.")
@TypeSpec.Rest.resource("encrypted-shares")
model EncryptedRecoveryShare {
  @doc("ID of CCF member who this recovery share belongs to.")
  @visibility(Lifecycle.Query)
  @key
  memberId: memberId;

  @doc("Base-64 encoding of a member's encrypted share.")
  encryptedShare: bytes;
}

@doc("Container for a member's raw recovery share. This should be carefully guarded, and only submitted to a trusted service over a secure channel, for the purposes of recovery.")
model RecoveryShare {
  @doc("Base-64 encoding of a member's raw recovery share (unencrypted).")
  share: bytes;
}

@doc("Response to a submitted recovery share.")
model RecoveryResponse {
  @doc("Human-readable description of current recovery progress.")
  message: string;

  @doc("Count of how many accepted member shares have been submitted, including the current request.")
  submittedCount: safeuint;

  @doc("Count of how many member shares are required to initiate the end-of-recovery procedure.")
  recoveryThreshold: safeuint;
}

@doc("Recovery-specific details for a given member.")
@TypeSpec.Rest.resource("members")
model Member {
  @doc("Identifier for member this recovery state applies to.")
  @visibility(Lifecycle.Query)
  @key
  memberId: memberId;
}

interface EncryptedShares {
  @doc("Retrieve a member's recovery share, encrypted with that member's share-encryption key.")
  get is Azure.Core.StandardResourceOperations.ResourceRead<EncryptedRecoveryShare>;
}

interface Shares {
  @doc("Provide a recovery share for the purpose of completing a service recovery.")
  @TypeSpec.Rest.action("recover")
  submit is Azure.Core.StandardResourceOperations.ResourceAction<
    Member,
    CoseSigned<RecoveryShare>,
    RecoveryResponse,
    TxIdReadHeader
  >;
}
