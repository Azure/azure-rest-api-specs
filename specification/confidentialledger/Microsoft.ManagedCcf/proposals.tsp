import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./cose.tsp";
import "./common.tsp";

@TypeSpec.Http.route("/gov/members")
namespace Microsoft.ManagedCcf.Proposals;

@doc("A single step in a proposed change to the service.")
model Action {
  @doc("The name of the action to perform. This should match an action defined in the service's constitution, so that it can be invoked by the `apply` function of the constitution if the proposal is accepted.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type can be anything."
  @doc("Arguments to modify the behavior of this action. The schema is determined by the action implementation, and should be validated by a `validate` call in the constitution.")
  args?: unknown;
}

@doc("Possible states for a proposal.")
enum ProposalState {
  @doc("Proposal is active and can be voted on.")
  Open,

  @doc("Proposal passed a successful vote and was enacted.")
  Accepted,

  @doc("Proposal was removed by proposing member. Will never be enacted.")
  Withdrawn,

  @doc("Proposal was rejected by vote. Will never be enacted.")
  Rejected,

  @doc("Proposal passed a successful vote, but its proposed actions failed. Will never be enacted.")
  Failed,

  @doc("Proposal was open when its semantics were potentially changed (code or constitution were modified), so it was automatically invalidated.")
  Dropped,
}

@doc("Description of why governance execution failed.")
model FailureInfo {
  @doc("Error message describing reason for failure.")
  reason: string;

  @doc("Call stack showing where failure occurred, if available.")
  trace?: string;
}

@doc("Each key is a memberId, and the corresponding value is the result of their ballot.")
model MemberVotes is Record<boolean>;

@doc("Each key is a memberId, and the corresponding value explains why execution of their ballot failed.")
model VoteFailures is Record<FailureInfo>;

// Corresponds to ccf::jsgov::ProposalInfoSummary in C++
@doc("Description of a proposed change to the service.")
@TypeSpec.Rest.resource("proposals")
model Proposal {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Read visibility produces linter-breaking readOnly"
  @key
  @doc("Unique ID assigned to this proposal at its submission, by the service.")
  proposalId: proposalId;

  @doc("ID of CCF member who signed and created this proposal.")
  proposerId: memberId;

  @doc("Current state of this proposal.")
  proposalState: ProposalState;

  @doc("Count of how many ballots have been submitted for this proposal.")
  ballotCount: safeuint;

  @doc("If a proposal is not open, then this contains the result of each ballot when the proposal transitioned from open.")
  finalVotes?: MemberVotes;

  @doc("This will be populated with a description of any ballots which failed to execute.")
  voteFailures?: VoteFailures;

  @doc("If proposalState is Failure, then this will describe why the proposal failed.")
  failure?: FailureInfo;
}

@doc("The actions contained in a proposal, describing the proposal's changes.")
@TypeSpec.Rest.parentResource(Proposal)
model ProposalActions {
  @doc("A list of actions to apply. Each action is considered, in order, for both proposal and execution of the proposal. All actions are validated and, if the proposal is accepted, applied atomically.")
  actions: Action[];
}

@doc("The source script of an executable vote from a member, regarding a proposed change to the service.")
@TypeSpec.Rest.resource("ballots")
@TypeSpec.Rest.parentResource(Proposal)
model Ballot {
  @doc("ID of CCF member who signed and submitted this ballot.")
  @visibility("query")
  @key
  memberId: memberId;

  @doc("The script to execute, returning the voter's support of this proposal.")
  script: string;
}

interface Proposals {
  // https://github.com/microsoft/CCF/issues/5230
  @doc("Submit a proposed change to the service. This will be assigned an ID by the service. Submitting the same signature (including signed COSE headers such as created_at) multiple times will be treated as a single idempotent operation, returning a single created proposal (or an error if it is no longer available). Any change to the request body will be treated as a new, separate proposal.")
  create is Azure.Core.StandardResourceOperations.ResourceCollectionAction<
    Proposal,
    CoseSigned<ProposalActions>,
    Proposal,
    TxIdWriteHeader
  >;

  @doc("Withdraw an existing proposal. Only the original proposer is permitted to withdraw.")
  withdraw is Azure.Core.StandardResourceOperations.ResourceAction<
    Proposal,
    CoseSigned,
    Proposal,
    TxIdWriteHeader
  >;

  @doc("Returns a summary of a single proposed change to the service.")
  get is Azure.Core.StandardResourceOperations.ResourceRead<
    Proposal,
    TxIdReadHeader
  >;

  @doc("Returns all current proposed changes to the service. Note that non-open proposals (ie - those which have already been accepted, rejected, withdrawn, etc) are not returned.")
  list is Azure.Core.StandardResourceOperations.ResourceList<
    Proposal,
    TxIdReadHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "MUST fix in next update"
  @doc("Returns actions contained in a proposal.")
  @TypeSpec.Rest.action("actions")
  @TypeSpec.Rest.actionSeparator("/")
  @TypeSpec.Http.get
  getActions is Azure.Core.StandardResourceOperations.ResourceAction<
    Proposal,
    {},
    ProposalActions,
    TxIdReadHeader
  >;
}

interface Ballots {
  @doc("Submit an executable ballot for a specific proposal. This may be as simple as `return true` to vote in favour, or contain reads from the KV and conditions on the proposal contents.")
  submit is Azure.Core.StandardResourceOperations.ResourceAction<
    Ballot,
    CoseSigned<Ballot>,
    Proposal,
    TxIdWriteHeader
  >;

  @doc("Returns a member's submitted ballot.")
  get is Azure.Core.StandardResourceOperations.ResourceRead<
    Ballot,
    Azure.Core.Traits.ResponseHeadersTrait<TxIdReadHdr & JavaScriptSource>
  >;
}
