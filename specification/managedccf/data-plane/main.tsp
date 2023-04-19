import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;

@service({
    title: "CCF governance",
    version: "2023-04-19"
})
namespace Governance;

model StateDigest {
    state_digest: string;
}

model Transaction {
    @pattern("^[0-9]+\\.[0-9]+$") transactionId: string;
}

model GetCommit {
    transactionValue: Transaction;
    viewHistory: Transaction[];
}

model MemberIdToBase64 {
    @format("byte") value: string;
}

model StringToBase64 is MemberIdToBase64;

enum MDType {
    "NONE",
    "SHA1",
    "SHA256",
    "SHA384",
    "SHA512",
}

model SignedReq {
    keyId: string;
    @format("byte") req: string;
    md: MDType;
    @format("byte") requestBody: string;
    @format("byte") sig: string;
}

model MemberIdToSignedReq is SignedReq;

model JSRuntimeOptions {
    @minValue(0) @maxValue(18446744073709551615) maxExecutionTimeInMs: int64;
    @minValue(0) @maxValue(18446744073709551615) maxHeapBytes: int64;
    @minValue(0) @maxValue(18446744073709551615) maxStackBytes: int64;
}

enum JwtIssuerKeyFilter {
    "all",
    "sgx",
}

model JwtIssuerKeyPolicy {
    sgxClaims: string;
}

model JwtIssuerMetadata {
    autoRefresh?: boolean;
    caCertBundleName?: string;
    keyFilter: JwtIssuerKeyFilter;
    keyPolicy?: JwtIssuerKeyPolicy;
}

model StringToJwtIssuerMetadata is JwtIssuerMetadata;

model MemberAck {
    @format("byte") codeSign1Req?: string;
    signedReq?: SignedReq;
    stateDigest: StateDigest;
}

model MemberIdToMemberAck is MemberAck;

model Pem {
    pemValue: string;
}

model MemberIdToPem {
    Id: Pem;
}

model NodeIdToPem is MemberIdToPem;

model UserIdToPem is MemberIdToPem;

enum MemberStatus {
    "Accepted",
    "Active",
}

scalar Json;

model MemberDetails {
    memberData: Json;
    memberStatus: MemberStatus;
}

model MemberIdToMemberDetails is MemberDetails;

model ACME {
    caCerts: string[];
    challengeType: string;
    contact: string[];
    directoryUrl: string;
    serviceDNSName: string;
    termsOfServiceAgreed: boolean;
}

model ACMEConfigurations {
    acme: ACME;
}

enum QuoteFormat {
    "OE_SGX_v1",
    "Insecure_Virtual",
    "AMD_SEV_SNP_v1",
}

model QuoteInfo {
    @format("byte") endorsements: string;
    format: QuoteFormat;
    @format("byte") quote: string;
}

enum AppProtocol {
    "HTTP1",
    "HTTP2",
}

enum Authority {
    "Node",
    "Service",
    "ACME",
    "Unsecured",
}

enum NodeStatus {
    "Pending",
    "Trusted",
    "Retired",
    "Learner",
    "Retiring",
}

model Endorsement {
    acmeConfig?: string;
    authority: Authority;
}

model HttpConfiguration {
    @pattern("^[0-9]+(B|KB|MB|GB|TB|PB)?$") initialWindowSize: string;
    @pattern("^[0-9]+(B|KB|MB|GB|TB|PB)?$") maxBodySize: string;
    @minValue(0) @maxValue(18446744073709551615) maxConcurrentStreams: int64;
    @pattern("^[0-9]+(B|KB|MB|GB|TB|PB)?$") maxFrameSize: string;
    @pattern("^[0-9]+(B|KB|MB|GB|TB|PB)?$") maxHeaderSize: string;
    @minValue(0) @maxValue(4294967295) maxHeadersCount: int32;
}

model NodeToNodeInterface {
    acceptedEndpoints?: string[];
    appProtocol?: AppProtocol;
    bindAddress: string;
    endorsement?: Endorsement;
    httpConfig?: HttpConfiguration;
    @minValue(0) @maxValue(18446744073709551615) maxOpenSessionsHard?: int64;
    @minValue(0) @maxValue(18446744073709551615) maxOpenSessionsSoft?: int64;
    protocol?: string;
    publishedAddress?: string;
}

model RPCInterfaces is NodeToNodeInterface;

model NodeInfo {
    acmeConfig?: ACMEConfigurations;
    cert?: Pem;
    certificateSigningRequest?: Pem;
    codeDigest?: string;
    encryptionPublicKey: Pem;
    @minValue(0) @maxValue(18446744073709551615) ledgerSecretSeqno?: int64;
    nodeData?: Json;
    nodeToNodeInterface: NodeToNodeInterface;
    publicKey?: Pem;
    quoteInfo: QuoteInfo;
    retiredCommitted?: boolean;
    rpcInterfaces: RPCInterfaces;
    status: NodeStatus;
}

model NodeIdToNodeInfo is NodeInfo;

model Failure {
    reason: string;
    trace?: string;
}

model MemberIdToFailure is Failure;

enum ProposalState {
    "Open",
    "Accepted",
    "Withdrawn",
    "Rejected",
    "Failed",
    "Dropped"    
}

model ProposalInfo {
    ballots: string;
    failure?: Failure;
    finalVotes?: boolean;
    @pattern("^[a-f0-9]{64}$") proposerId: string;
    state: ProposalState;
    voteFailures: MemberIdToFailure;
}

model StringToProposalInfo is ProposalInfo;

model StringToPem is Pem;

enum ConsensusType {
    "BFT",
    "CFT",
}

enum reconfigurationType {
    "OneTransaction",
    "TwoTransaction",
}

model ServiceConfiguration {
    consensus: ConsensusType;
    @minValue(0) @maxValue(18446744073709551615) maxNodeCertValidityDays?: int64;
    @minValue(0) @maxValue(18446744073709551615) maxServiceCertValidityDays?: int64;
    @minValue(0) @maxValue(18446744073709551615) recentCoseProposalsWindowSize?: int64;
    reconfigurationType?: reconfigurationType;
    @minValue(0) @maxValue(18446744073709551615) recoveryThreshold: int64;
}

enum ServiceStatus {
    "Opening",
    "Open",
    "WaitingForRecoveryShares",
    "Recovering"
}

model ServiceInfo {
    cert: Pem;
    @pattern("^[0-9]+\\.[0-9]+$") currentServiceCreateTxId?: string;
    @minValue(0) @maxValue(18446744073709551615) prevServiceIdentityVersion?: int64;
    @minValue(0) @maxValue(18446744073709551615) recoveryCount?: int64;
    serviceData?: Json;
    status: ServiceStatus;
}

model UserDetails {
    userData: Json;
}

model Action {
    args: Json;
    name: string;
}

model ActionArray {
    actions: Action[];
}

model Proposal {
    actions: ActionArray;
}

model ProposalInfoSummary {
    @minValue(0) @maxValue(18446744073709551615) ballotCount: int64;
    failure?: Failure;
    proposalId: string;
    @pattern("^[a-f0-9]{64}$") proposerId: string;
    state: ProposalState;
    voteFailures?: MemberIdToFailure;
    votes?: boolean;
}

model Ballot {
    ballot: string;
}

model GetEncryptedRecoveryShare {
    encryptedShare: string;
}

model SubmitRecoveryShareIn {
    share: string;
}

model SubmitRecoveryShareOut {
    message: string;
}

enum TxStatus {
    "Unknown",
    "Pending",
    "Committed",
    "Invalid",
}

model GetTxStatusOut {
    status : TxStatus;
    @pattern("^[0-9]+\\.[0-9]+$")transactionID: string;
}

enum CodeStatusValues {
    "AllowedToJoin",
}

model CodeDetails {
    @pattern("^[a-f0-9]+$") codeDigest: string;
    codeStatus: CodeStatusValues;
}

model CodeDigestToCodeStatus {
    value: CodeDetails[];
}

model Sha256DigestToStringMap {
    @pattern("^[a-f0-9]{32}$") digest: string;
    value: string;
}

model Sha256DigestToString {
    value: Sha256DigestToStringMap[];
}

@route("/gov/ack")
@summary("Provide a member endorsement of a service state digest")
@post op ack(@body state_digest: StateDigest): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @statusCode statusCode: 204;
};

@route("/gov/ack/update_state_digest")
@summary("Update and fetch a service state digest, for the purpose of member endorsement")
@post op updateStateDigest(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body stateDigest: StateDigest;
};

@route("/gov/commit")
@doc("Latest transaction ID that has been committed on the service")
@summary("Current commit level")
@get op commit(@query view_history?: boolean, @query view_history_since?: int64): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body govCommit: GetCommit;
};

@route("/gov/kv/constitution")
@get op getConstitution(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body constitution: string;
};

// TODO: @extension("x-ccf-forwarding", true), @defaultresponse -- decorators don't work
@route("/gov/kv/cose_history")
@get op getCoseHistory(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body coseHistory: StringToBase64;
};

@route("/gov/kv/cose_recent_proposals")
@get op getCoseRecentProposals(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body coseRecentProposals: string;
};

@route("/gov/kv/history")
@get op getHistory(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body history: MemberIdToSignedReq;
};

@route("/gov/kv/js_runtime_options")
@get op getJSRuntimeOptions(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body jsRuntimeOptions: JSRuntimeOptions;
};

@route("/gov/kv/jwt/issuers")
@get op getJwtIssuers(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body jwtIssuers: StringToJwtIssuerMetadata;
};

@route("/gov/kv/jwt/public_signing_key_issuer")
@get op getJwtPublicSigningKeyIssuer(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body jwtPublicSigningKeyIssuer: string;
};

@route("/gov/kv/jwt/public_signing_keys")
@get op getJwtPublicSigningKeys(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body jwtPublicSigningKeys: StringToBase64;
};

@route("/gov/kv/members/acks")
@get op getMembersAcks(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body membersAcks: MemberIdToMemberAck;
};

@route("/gov/kv/members/certs")
@get op getMembersCerts(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body membersCerts: MemberIdToPem;
};

@route("/gov/kv/members/encryption_public_keys")
@get op getMembersEncryptionPublicKeys(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body membersEncryptionPublicKeys: MemberIdToPem;
};

@route("/gov/kv/members/info")
@get op getMembersInfo(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body membersInfo: MemberIdToMemberDetails;
};

@route("/gov/kv/modules")
@get op getModules(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body modules: string;
};

@route("/gov/kv/modules_quickjs_bytecode")
@get op getModulesQuickJSBytecode(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body modulesQuickJSBytecode: StringToBase64;
};

@route("/gov/kv/modules_quickjs_version")
@get op getModulesQuickJSVersion(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body modulesQuickJSVersion: string;
};

@route("/gov/kv/nodes/code_ids")
@get op getNodeCodeIds(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body nodeCodeIds: CodeDigestToCodeStatus;
};

@route("/gov/kv/nodes/endorsed_certificates")
@get op getNodesEndorsedCertificates(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body nodesEndorsedCertificates: NodeIdToPem;
};

@route("/gov/kv/nodes/info")
@get op getNodesInfo(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body nodesInfo: NodeIdToNodeInfo;
};

@route("/gov/kv/nodes/snp/host_data")
@get op getNodeSnpHostData(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body nodesSnpHostData: Sha256DigestToString;
};

@route("/gov/kv/nodes/snp/measurements")
@get op getNodeSnpMeasurements(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body nodesSnpMeasurements: CodeDigestToCodeStatus;
};

@route("/gov/kv/proposals")
@get op getProposals(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposals: StringToBase64;
};

@route("/gov/kv/proposals_info")
@get op getProposalsInfo(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposalsInfo: StringToProposalInfo;
};

@route("/gov/kv/service/acme_certificates")
@get op getServiceAcmeCertificates(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body serviceAcmeCertificates: StringToPem;
};

@route("/gov/kv/service/config")
@get op getServiceConfig(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body serviceConfig: ServiceConfiguration;
};

@route("/gov/kv/service/info")
@get op getServiceInfo(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body serviceInfo: ServiceInfo;
};

@route("/gov/kv/service/previous_service_identity")
@get op getServicePreviousServiceIdentity(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body servicePreviousServiceIdentity: Pem;
};

@route("/gov/kv/tls/ca_cert_bundles")
@get op getTlsCaCertBundles(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body tlsCaCertBundles: string;
};

@route("/gov/kv/users/certs")
@get op getUsersCerts(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body usersCerts: UserIdToPem;
};

@route("/gov/kv/users/info")
@get op getUsersInfo(): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body usersInfo: UserDetails;
};

@route("/gov/proposals")
namespace proposals {
    @summary("Proposed changes to the service pending resolution")
    @get op allProposals(): {
        @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposals: StringToProposalInfo
    };
    @summary("Submit a proposed change to the service")
    @post op proposalInfo(@body proposal: Proposal): {
        @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposalInfoDetail: ProposalInfoSummary;
    };
}

@route("/gov/proposals/{proposal_id}")
@summary("Information about a proposed change to the service")
@get op getProposalId(@path proposal_id: string): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposalInfoDetail: ProposalInfo;
};

@route("/gov/proposals/{proposal_id}/actions")
@summary("Actions contained in a proposed change to the service")
@get op getProposalIdActions(@path proposal_id: string): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposalActions: Proposal;
};

@route("/gov/proposals/{proposal_id}/ballots")
@summary("Ballots submitted against a proposed change to the service")
@post op postProposalIdBallots(@path proposal_id: string, @body ballot: Ballot): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body ballotInfo: ProposalInfoSummary;
};

@route("/gov/proposals/{proposal_id}/ballots/{member_id}")
@summary("Ballot for a given member about a proposed change to the service")
@get op getMemberIdBallot(@path proposal_id: string, @path member_id: string): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body ballot: Ballot;
};

@route("/gov/proposals/{proposal_id}/withdraw")
@summary("Withdraw a proposed change to the service")
@post op postProposalIdWithdraw(@path proposal_id: string): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body proposalInfoDetail: ProposalInfo;
};

@route("/gov/receipt")
@doc("A signed statement from the service over a transaction entry in the ledger")
@summary("Receipt for a transaction")
@get op getReceipt(@query @pattern("^[0-9]+\\.[0-9]+$")transactionID: string): {
    @body receipt: Json;
};

@route("/gov/recovery_share")
@summary("Provide a recovery share for the purpose of completing a service recovery")
@post op postRecoveryShare(@body recoveryShare: SubmitRecoveryShareIn): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body recoveryShare: SubmitRecoveryShareOut;
};

@route("/gov/encrypted_recovery_share/{member_id}")
@summary("A member's encrypted recovery share")
@get op getEncryptedRecoveryShare(@path member_id: string): {
    @header("x-ms-ccf-transaction-id") transactionID: string;
    @body recoveryShare: GetEncryptedRecoveryShare;
};

@route("/gov/tx")
@doc("Possible statuses returned are Unknown, Pending, Committed or Invalid.")
@get op getTx(@query @pattern("^[0-9]+\\.[0-9]+$")transactionID: string): {
    @body tx: GetTxStatusOut;
};