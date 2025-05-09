import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./common.tsp";

@TypeSpec.Http.route("/gov")
namespace Microsoft.ManagedCcf.ServiceState;

/// Common types
@doc("PEM encoding of a cryptographic identifier. Contains a base64-encoded payload wrapped in content type identifiers.")
scalar pem extends string;

/// Member types
@doc("Possible states for a CCF governing member.")
union MemberStatus {
  string,

  @doc("Member has been approved to join the service, but have not yet submitted an ACK to indicate their participation. These members should not be considered by constitutions in quorum calculations, and their signed requests will be rejected until they become Active.")
  "Accepted",

  @doc("Member has submitted a valid ACK and is a full voting participant.")
  "Active",
}

@doc("Information on individual members within a consortium.")
@TypeSpec.Rest.resource("service/members")
model Member {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Read visibility produces linter-breaking readOnly"
  @doc("ID of CCF member who this object refers to.")
  @key
  memberId: memberId;

  @doc("Current status of this member.")
  status: MemberStatus;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "This is arbitrary JSON"
  @doc("Arbitrary service-defined metadata about this member. May be used by constitution or application code, but will not affect any core framework decisions.")
  memberData?: unknown;

  @doc("x509 certificate used as this member's identity.")
  certificate: pem;
}

/// Node types
@doc("Lifecycle state of a CCF node. Nodes will generally start as Pending, then transition to Trusted, then to Retired. They are only full participants in the service while they are Trusted.")
union NodeStatus {
  string,

  @doc("Indicates a node which has successfully completed a join request to the service (including attestation checks), but has not yet been approved by governance.")
  "Pending",

  @doc("Indicates a node which has been approved by governance, and is a full participant in the service.")
  "Trusted",

  @doc("Indicates a node which has been removed from a service by a reconfiguration.")
  "Retired",
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
@doc("Common type for attestation information, describing the cryptographically-endorsed claim of what code is executing, and what platform it is executing on. Derived types contain platform-specific details.")
@discriminator("format")
model QuoteInfo {}

@doc("Attestation information for Intel SGX enclaves.")
model SgxQuoteInfo extends QuoteInfo {
  @doc("Fixed identifier for SGX information.")
  format: "OE_SGX_v1";

  @doc("Base-64 encoded SGX quote.")
  quote: bytes;

  @doc("Base-64 encoded SGX endorsements.")
  endorsements: bytes;
}

@doc("Attestation information for AMD SEV-SNP containers.")
model SnpQuoteInfo extends QuoteInfo {
  @doc("Fixed identifier for SNP information.")
  format: "AMD_SEV_SNP_v1";

  @doc("Base-64 encoded SNP UVM endorsements.")
  uvmEndorsements: bytes;

  @doc("Base-64 encoded SNP TCB endorsements.")
  endorsedTcb: bytes;
}

@doc("Details of how to contact a CCF node. Each node may listen on multiple interfaces, for different kinds of traffic.")
model NetworkInterface {
  @doc("The network address where this node believes it is publicly accessible, in the format <host>[:<port>].")
  publishedAddress: string;

  @doc("The application layer protocol which the node expects on this interface. Currently supports \"http1\" and \"http2\", more protocols may be added in future.")
  protocol: string;
}

@doc("Information on individual nodes within a service.")
@TypeSpec.Rest.resource("service/nodes")
model Node {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Read visibility produces linter-breaking readOnly"
  @doc("ID of CCF node who this object refers to.")
  @key
  nodeId: nodeId;

  @doc("Current status of this node.")
  status: NodeStatus;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "This is arbitrary JSON"
  @doc("Arbitrary service-defined metadata about this node. May be used by constitution or application code, but will not affect any core framework decisions.")
  nodeData?: unknown;

  @doc("x509 certificate containing this node's identity.")
  certificate: pem;

  @doc("This is false during node's normal operation. It transitions to true once the node has been retired, and that retirement has been committed by the service. At this point it is safe to terminate a node. Terminating a node any earlier may affect liveness of the service.")
  retiredCommitted: boolean;

  @doc("Contains this node's hardware attestation. This is generated during node startup, and must meet the current join policy restrictions for the node to successfully join a service.")
  quoteInfo: QuoteInfo;

  @doc("A collection of interfaces by which this node may be contacted. Some may be limited to private networks, and others may be DNS names or internet-public network addresses. The keys are arbitrary strings determined by the node operator.")
  rpcInterfaces: Record<NetworkInterface>;
}

/// constitution types
@TypeSpec.Rest.resource("service")
@doc("Constitution used to make governance decisions on the service. All governance changes are presented as proposals which must be validated, approved, and applied by the code in this constitution.")
model ConstitutionResponse {
  @doc("Singleton key for accessing constitution")
  @visibility(Lifecycle.Query)
  @key
  id: "constitution";

  @doc("Javascript source code of constitution.")
  constitution: string;
}

/// JS app types
@doc("Describes the forwarding behavior of a specific endpoint. Write requests cannot be executed on a backup, so will generally be forwarded by any backup node which receives them to the current primary. Future requests on the same session may then be forwarded to maintain session consistency.")
union ForwardingRequired {
  string,

  @doc("Indicates that this request should be forwarded if-and-only-if it is needed to maintain session consistency. If stale reads are acceptable then they can be completed on a backup, and the request will not be forwarded. This should be the default behavior for read-only endpoints.")
  "Sometimes",

  @doc("Indicates that this request should always be forwarded. This will trigger forwarding of any additional requests on the same session, even those marked ForwardRequired::Sometimes. This should be the default behavior for any endpoint which writes to the Key-Value store.")
  "Always",

  @doc("Indicates endpoints which will never be forwarded, even when this will result in a break of session consistency. This should be used only to access node-local information, or when weaker consistency is acceptable.")
  "Never",
}

@doc("Describes the execution requirements of a specific endpoint.")
union JsExecMode {
  string,

  @doc("Indicates that the endpoint does (or may) produces writes to the Key-Value store.")
  "ReadWrite",

  @doc("Indicates that the endpoint is a pure read, and will never write to the Key-Value store. Note that this includes endpoints which only access node-local state, and do not read from the Key-Value store at all.")
  "ReadOnly",

  @doc("Indicates that the endpoint operates over a historical write to the Key-Value store rather than the latest, current state. These endpoints are also read-only, and may not produce writes.")
  "Historical",
}

@doc("Describes an endpoint implemented by a Javascript handler.")
model JsEndpointInfo {
  @doc("The name of the module where the endpoint function is located.")
  jsModule: string;

  @doc("The name of the exported function which implements this endpoint.")
  jsFunction: string;

  @doc("Describes whether requests to this endpoint should be forwarded to the primary or executed on backups.")
  forwardingRequired: ForwardingRequired;

  @doc("The authentication policies which restrict access to this endpoint")
  authnPolicies: string[];

  @doc("Describes how this endpoint should be executed.")
  mode: JsExecMode;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Multiple value types"
  @doc("An OpenAPI Operation object (https://swagger.io/specification/#operation-object) describing this operation. This is merged into the auto-generated OpenAPI to describe the current application's API.")
  openApi: Record<unknown>;
}

@doc("The collection of operations available on each path. Keyed by HTTP method.")
model JsOperations extends Record<JsEndpointInfo> {}

@TypeSpec.Rest.resource("service")
@doc("Describes the currently installed JavaScript application.")
model JsApp {
  @doc("Singleton key for accessing javascript-app.")
  @visibility(Lifecycle.Query)
  @key
  id: "javascript-app";

  @doc("The collection of endpoints exposed by the application. Keyed by path.")
  endpoints: Record<JsOperations>;

  // TODO:
  // - Endpoint source?
  // - Module source?
  // - Engine config?
  // - QuickJS version
}

/// Join policy types
@doc("Describes what a joining node must present, in order to join the service.")
model JoinPolicy {
  @doc("Code measurements of acceptable enclaves.")
  measurements: bytes[];
}

@doc("Join policy fields specific to nodes running on AMD SEV-SNP hardware.")
model SnpJoinPolicy {
  ...JoinPolicy;

  // TODO: Work out what the actual types of these are

  @doc("Collection of acceptable host data values.")
  hostData: Record<bytes>;

  @doc("Collection of acceptable UVM endorsements.")
  uvmEndorsements: Record<bytes>;
}

@TypeSpec.Rest.resource("service")
@doc("Collection of all policies which determine currently acceptable nodes, across multiple platforms.")
model JoinPolicies {
  @doc("Singleton key for accessing join-policy")
  @visibility(Lifecycle.Query)
  @key
  id: "join-policy";

  @doc("Policy applied to nodes running in SGX enclaves.")
  sgx: JoinPolicy;

  @doc("Policy applied to nodes running in AMD SEV-SNP containers.")
  snp: SnpJoinPolicy;
}

/// JWK/JWT types
@doc("Possible restrictions on what keys will be accepted from a JWT issuer.")
union JwtIssuerKeyFilter {
  string,

  @doc("Accepts any JWT issuer.")
  "All",

  @doc("Only accepts JWTs issued by a token provider running in SGX, which provides a suitable attestation and additional claims.")
  "Sgx",
}

@doc("Description of a JWT issuer or identity provider that the current service will trust tokens from.")
model JwtIssuer {
  @doc("Adds restrictions on whether keys should be accepted from this issuer.")
  keyFilter: JwtIssuerKeyFilter;

  @doc("Collection of claims which must be present in SGX attestation to permit updates from this issuer.")
  keyPolicy?: Record<string>;

  @doc("Whether this issuer's keys are periodically refreshed with a fetch from the current primary. If false, these will only be updated by governance.")
  autoRefresh: boolean;

  @doc("Name of bundle used to authenticate issuer when auto-refreshing.")
  caCertBundleName?: string;
}

@doc("Chain of endorsed certificates (PEM format) leading to a CA.")
scalar caCertBundle extends string;

@TypeSpec.Rest.resource("service")
@doc("Describes what Javascript Web Tokens (JWTs) are accepted by the service, and how they will be validated.")
model JwkInfo {
  @doc("Singleton key for accessing jwk")
  @visibility(Lifecycle.Query)
  @key
  id: "jwk";

  @doc("Collection of JWT issuers. Keyed by issuer ID.")
  issuers: Record<JwtIssuer>;

  @doc("Collection of CAs used to authenticate connections with issuers. Keyed by governance-controlled bundle names.")
  caCertBundles: Record<caCertBundle>;
}

/// Service info types
@doc("State machine values for current service lifetime. New services start in Opening, and transition to Open via a governance proposal. They will only accept user transactions on the `/app` endpoints once they are Open. Recovery services have additional states where they must wait for members to submit sufficient recovery shares to access the previous ledger secrets, and while they are decrypting and replaying the previous ledger contents.")
union ServiceStatus {
  string,

  @doc("Services which have not yet passed a `transition_service_to_open` proposal.")
  "Opening",

  @doc("Services which are operating normally and accepting user transactions.")
  "Open",

  @doc("Recovered services which cannot yet access private state.")
  "WaitingForRecoveryShares",

  @doc("Recovered services which are actively replaying transactions from previous service, to reach the same state.")
  "Recovering",
}

@doc("General information about the current service.")
@TypeSpec.Rest.resource("service")
model ServiceInfo {
  @doc("Singleton key for accessing info.")
  @visibility(Lifecycle.Query)
  @key
  id: "info";

  @doc("Lifetime stage of the service.")
  status: ServiceStatus;

  @doc("The current service identity. This is the public face of a secret key shared only by the nodes within the service, and should be used to authenticate TLS sessions with this service.")
  certificate: pem;

  @doc("Records how many predecessors this service has. While the service identity certificate will change on any recovery, this allows users to determine exactly how many such recoveries have occurred.")
  recoveryCount: safeuint;

  @doc("Transaction ID at which this service was first created. If this is a recovery of a previous service, this will indicate when the current service was recovered.")
  creationTransactionId: transactionId;

  @doc("Transaction ID at which the predecessor service was created, if this service is a recovery. If this is an original service rather than a recovery, this will be omitted.")
  previousServiceCreationTransactionId?: pem;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "This is arbitrary JSON"
  @doc("Arbitrary service-defined metadata about this service. May be used by constitution or application code, but will not affect any core framework decisions.")
  serviceData?: unknown;

  @doc("Lists governance-controlled configuration parameters of this service, which will be used by core framework code.")
  configuration: {
    maximumNodeCertificateValidityDays: safeuint;
    recentCoseProposalsWindowSize: safeuint;
  };
}

interface ServiceState {
  @doc("Retrieve list of all members who govern this service.")
  listMembers is Azure.Core.StandardResourceOperations.ResourceList<
    Member,
    TxIdReadHeader
  >;

  @doc("Retrieve a single governing member, by ID.")
  getMember is Azure.Core.StandardResourceOperations.ResourceRead<
    Member,
    TxIdReadHeader
  >;

  @doc("Retrieve list of all nodes participating in this service.")
  listNodes is Azure.Core.StandardResourceOperations.ResourceList<
    Node,
    TxIdReadHeader
  >;

  @doc("Retrieve a single node, by ID.")
  getNode is Azure.Core.StandardResourceOperations.ResourceRead<
    Node,
    TxIdReadHeader
  >;

  @doc("Retrieve the constitution which controls governance changes on this service.")
  getConstitution is Azure.Core.StandardResourceOperations.ResourceRead<
    ConstitutionResponse,
    Azure.Core.Traits.ResponseHeadersTrait<TxIdReadHdr & JavaScriptSource>
  >;

  @doc("Retrieve details of Javascript application and execution engine.")
  getJsApp is Azure.Core.StandardResourceOperations.ResourceRead<
    JsApp,
    TxIdReadHeader
  >;

  @doc("Retrieve policy data which determines whether new nodes are permitted to join the service. This describes the hardware attestations which are acceptable to the service, demonstrating a joining node is running approved code.")
  getJoinPolicies is Azure.Core.StandardResourceOperations.ResourceRead<
    JoinPolicies,
    TxIdReadHeader
  >;

  @doc("Returns information about OpenID Connect identity providers.")
  getJwkInfo is Azure.Core.StandardResourceOperations.ResourceRead<
    JwkInfo,
    TxIdReadHeader
  >;

  @doc("Returns general information about the service, including whether it is a recovery or original service.")
  getServiceInfo is Azure.Core.StandardResourceOperations.ResourceRead<
    ServiceInfo,
    TxIdReadHeader
  >;
}
