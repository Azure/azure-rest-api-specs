import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.NetworkSecurity;

/** AgentFabric resource */
model AgentFabric is TrackedResource<AgentFabricProperties> {
  @doc("The name of the AgentFabric")
  @key("agentFabricName")
  @segment("agentFabrics")
  @path
  @typeChangedFrom(
    Versions.v2026_11_01_preview,
    AgentFabricResourceNames.ResourceNameUpTo24Characters
  )
  name: AgentFabricResourceNames.ResourceName;

  ...ManagedSystemAssignedIdentityProperty;
}

// `identity` is spread from the ARM library rather than declared in the model body: the envelope is
// reserved, and arm-resource-invalid-envelope-property only accepts envelope properties whose source
// model lives in Azure.ResourceManager. A spread property cannot take inline decorators, so its
// version gate and description are applied here instead.
@@added(AgentFabric.identity, Versions.v2026_07_21_preview);
@@doc(
  AgentFabric.identity,
  "The managed service identity assigned to this fabric. The service uses it to reach the\nclusters associated with the fabric on the customer's behalf."
);

/** The type used for updating tags in AgentFabric resources. */
model AgentFabricTagsUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The managed service identity assigned to this fabric. */
  @added(Versions.v2026_07_21_preview)
  identity?: CommonTypes.SystemAssignedServiceIdentity;
}

/** Provisioning state of the resource */
union ProvisioningState {
  string,

  /** Resource provisioning succeeded */
  Succeeded: "Succeeded",

  /** Resource provisioning failed */
  Failed: "Failed",

  /** Resource provisioning was canceled */
  Canceled: "Canceled",

  /** The resource create request has been accepted; provisioning is in progress. */
  Provisioning: "Provisioning",

  /** The resource is being created. */
  @added(Versions.v2026_10_07_preview)
  Creating: "Creating",

  /** The resource update request has been accepted; the update is in progress. */
  Updating: "Updating",

  /** The resource delete request has been accepted; deletion is in progress. */
  Deleting: "Deleting",

  /** The long-running operation has been accepted and is not yet complete. */
  Accepted: "Accepted",
}

/** AgentFabric properties */
model AgentFabricProperties {
  /** The unique identifier (GUID) assigned to the agent fabric by the resource provider when it is created. */
  @added(Versions.v2026_10_07_preview)
  @visibility(Lifecycle.Read)
  resourceGuid?: Azure.Core.uuid;

  /** The default policy groups to apply to all members of this fabric. */
  @removed(Versions.v2026_10_07_preview)
  @renamedFrom(Versions.v2026_10_07_preview, "defaultPolicyGroups")
  defaultPolicyGroupsBefore20261007?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/policyGroups";
    }
  ]>[];

  /**
   * The default policy groups to apply to all members of this fabric. A fabric without a configured
   * inspection connection cannot reference a group containing any ContentInspection policy,
   * even when that policy's selectors currently match no traffic.
   * For an existing fabric, compatibility uses the stored configuration when PUT omits
   * contentInspectionProfile or supplies an empty object. Existing legacy fabrics retain their regional
   * Content Safety connection, which satisfies the inspection prerequisite without new probes.
   * A connection still being validated is not an absent connection. Removing a group
   * reference remains allowed, subject to other validation.
   */
  @added(Versions.v2026_10_07_preview)
  defaultPolicyGroups?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/policyGroups";
    }
  ]>[];

  /**
   * The connection to the customer's Azure Content Safety account. For a new
   * fabric created with API version `2026-10-07-preview` or later, omitting this profile or supplying {}
   * requests no inspection capability and uses no platform-owned account or shared-key fallback.
   *
   * For an existing fabric, omitting the profile from PUT, including requests from older clients,
   * or supplying {} preserves its customer-owned connection, legacy regional connection, or absence
   * of connection. The empty object is a request for no connection change, not a stored replacement
   * profile. Neither omission nor {} removes, probes, or creates a connection or cancels a pending
   * connection update. Other Fabric fields and policy compatibility rules still apply.
   * A nonempty request profile requires both endpoint and apiKey, even at the unchanged endpoint.
   * PUT can rotate the key or replace the endpoint by supplying the complete pair. Tags- or
   * identity-only PATCH requests cannot change this profile.
   *
   * Existing legacy fabrics without a profile retain their regional Content Safety endpoint and
   * authentication path. Omission or {} triggers no connection probe, account-management call, key
   * retrieval, or credential requirement. Supplying a complete profile explicitly configures a
   * customer-owned connection; there is no automatic conversion or failed-connection fallback
   * to regional credentials.
   *
   * The customer owns, pays for, and operates the account. The service does not create, reserve,
   * manage, or delete it. The service validates new or changed endpoint/credential configuration
   * and the required Content Safety API before activation; configuration alone does not indicate
   * readiness or active policy enforcement. Unchanged configuration, GET, and list do not trigger
   * a new validation request. A failed replacement preserves the existing connection and credential,
   * including a legacy regional connection.
   */
  @added(Versions.v2026_10_07_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  contentInspectionProfile?: ContentInspectionProfile;

  /**
   * The trust domain that scopes this fabric's member identities. It is the leading component of
   * each member's identity, which takes the form `<trustDomain>/<agentFabricName>/<memberName>`.
   * Set at creation and immutable thereafter; when omitted, the shared default trust domain
   * `microsoft.agentfabric` is used.
   */
  @added(Versions.v2026_07_21_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @maxLength(253)
  @pattern("^[a-z0-9]([a-z0-9.-]*[a-z0-9])?$")
  trustDomain?: string;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A connection to a customer-owned Azure Content Safety account. Configuring the connection
 * does not create or attach a ContentInspection policy or select traffic for inspection.
 * The endpoint routes Content Safety calls; a key alone cannot identify the account endpoint.
 * The customer supplies the key, so the service does not discover account keys through Azure
 * Resource Manager or require permission to perform the account's listKeys action.
 * Fields are schema-optional to allow an empty request object. Service cross-field validation
 * requires both endpoint and apiKey in a nonempty request profile. Read responses contain only
 * the endpoint; they are not complete connection-update inputs.
 */
@added(Versions.v2026_10_07_preview)
model ContentInspectionProfile {
  /**
   * The HTTPS account endpoint, for example `https://contoso.cognitiveservices.azure.com/`.
   * Only Azure Content Safety account endpoints in the service's supported Azure cloud are
   * accepted. Credentials must not be forwarded to other destinations, including redirects.
   * Required together with apiKey in a nonempty request profile, including key rotation.
   * Changing the endpoint requires a key for the new account; the stored key is not reused.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @pattern("^https://[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\\.cognitiveservices\\.(azure\\.com|azure\\.us|azure\\.cn)/?$")
  endpoint?: url;

  /**
   * The nonempty API key for the specified account. Required together with endpoint in every
   * nonempty request profile, even when the endpoint is unchanged. Supplying a different key
   * with the endpoint on PUT rotates the stored credential. A missing key in a nonempty profile
   * is rejected without retrieving a saved key or comparing with the saved endpoint to permit omission.
   * Null and empty values are rejected, not treated as removal. The key is never returned in
   * resource, list, or long-running operation responses.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @minLength(1)
  apiKey?: string;
}

@armResourceOperations
interface AgentFabrics {
  get is ArmResourceRead<AgentFabric>;

  @removed(Versions.v2026_10_07_preview)
  @renamedFrom(Versions.v2026_10_07_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateBefore20261007 is ArmResourceCreateOrReplaceAsync<AgentFabric>;

  /**
   * Creates or replaces an AgentFabric.
   *
   * Before accepting the request or changing policy-group associations, validate the policy
   * types in every proposed defaultPolicyGroups reference against the fabric's effective
   * inspection configuration. If no connection is configured and any referenced group contains a
   * ContentInspection policy, reject the request with HTTP 409 and error code
   * ContentInspectionCapabilityDisabled, targeting properties.defaultPolicyGroups. No incompatible
   * association change is accepted. This check does not depend on whether policy selectors
   * currently match traffic.
   *
   * Omitting contentInspectionProfile or supplying {} on PUT for an existing fabric preserves its
   * customer-owned connection, legacy regional connection, or absence of connection.
   * Do not persist {} over the stored connection or cancel a pending connection update.
   * New-fabric omission or {} requests no inspection capability and no regional fallback.
   * Existing legacy fabrics without a profile retain their regional Content Safety connection,
   * which satisfies the inspection prerequisite without new probes, management calls, or key
   * retrieval. A connection still being validated is not an absent connection.
   * Error messages must not disclose associated fabric IDs the caller is not authorized to read.
   *
   * If a connection update is in progress for this fabric, reject a PUT requesting a different
   * connection with HTTP 409 Conflict, without changing the connection update already in progress.
   * A retry of the same requested connection is not a conflicting change. This does not prevent
   * later key rotations or endpoint replacements.
   *
   * In API version `2026-10-07-preview` and later, reject definite invalid customer connection input before
   * accepting PUT with HTTP 400 Bad Request. A nonempty profile must contain both endpoint and apiKey.
   * Reject a missing field before connection validation, without retrieving a saved key or comparing
   * with the saved endpoint to permit key omission. Only a truly empty object is a connection no-op;
   * partial objects or objects containing only unrecognized fields must not be treated as empty.
   * Invalid input also includes a null or nonobject profile;
   * a malformed, untrusted, or unsupported endpoint (including a non-HTTPS or unrecognized Azure
   * account host or an unsupported cloud); and explicit null, empty, or wrong-type endpoint or key.
   * An endpoint without a key is invalid even when unchanged; a key without an endpoint is invalid.
   * An omitted profile or {} is not invalid connection input. Its no-op applies only to connection
   * handling; caller authorization, other Fabric fields, policy compatibility, and ordinary
   * pending-operation rules still apply.
   *
   * For service-level connection validation rejection, return ContentInspectionConnectionValidationFailed
   * in the standard error response, targeting properties.contentInspectionProfile or its endpoint
   * or apiKey field when the invalid field is known. Ordinary schema/model validation may retain
   * its standard HTTP 400 errors. The connection code also applies to definitively rejected
   * credentials or a confirmed account/access setting or missing required Content Safety API
   * capability that prevents use of the supplied connection. Interpret upstream 401/403 responses
   * to distinguish credentials from account access, local authentication, or network restrictions;
   * do not report them as authentication/authorization failures of the Fabric caller.
   *
   * Throttling (HTTP 429), service failures (5xx), DNS/TLS failures, timeouts, and inconclusive
   * availability do not establish bad customer input and must not be classified as this HTTP 400
   * rejection. A DNS timeout or an arbitrary upstream 404 does not prove that the account is absent.
   * If a definite validation rejection is discovered after PUT acceptance, report terminal Failed
   * with the corresponding error in the established long-running operation status response;
   * the accepted PUT response does not become HTTP 400. Failed replacement preserves the previously
   * active connection; never validate or operate failed customer input using regional credentials.
   * Error responses must not contain key values or raw upstream response bodies.
   *
   * Example connection rejection response (HTTP 400 Bad Request):
   *
   * ```json
   * {
   *   "error": {
   *     "code": "ContentInspectionConnectionValidationFailed",
   *     "message": "The supplied Content Safety connection could not be validated. Verify the endpoint, API key, and account access settings.",
   *     "target": "properties.contentInspectionProfile"
   *   }
   * }
   * ```
   *
   * Example rejection response (HTTP 409 Conflict):
   *
   * ```json
   * {
   *   "error": {
   *     "code": "ContentInspectionCapabilityDisabled",
   *     "message": "The referenced policy group contains a ContentInspection policy, but this fabric has no configured inspection connection.",
   *     "target": "properties.defaultPolicyGroups"
   *   }
   * }
   * ```
   */
  @added(Versions.v2026_10_07_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentFabric>;
  update is ArmCustomPatchAsync<AgentFabric, AgentFabricTagsUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentFabric,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          ArmLroLocationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
  listByResourceGroup is ArmResourceListByParent<AgentFabric>;
  listBySubscription is ArmListBySubscription<AgentFabric>;
}

/** The workload type of a member. */
union WorkloadType {
  string,

  /** Foundry workload type */
  @removed(Versions.v2026_07_21_preview)
  Foundry: "Foundry",

  /** ACI (Azure Container Instances) sandbox workload type */
  @added(Versions.v2026_07_21_preview)
  ACI: "ACI",

  /** Agent Fabric sandbox workload type */
  AgentFabricSandbox: "AgentFabricSandbox",

  /** AKS workload type */
  @added(Versions.v2026_10_07_preview)
  AKS: "AKS",
}

/** Base workload configuration for a member. */
@discriminator("type")
model WorkloadBase {
  /** The workload type. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type: WorkloadType;

  /** The unique identifier assigned to the workload by the resource provider. */
  @removed(Versions.v2026_11_02_preview)
  @renamedFrom(Versions.v2026_11_02_preview, "workloadId")
  @visibility(Lifecycle.Read)
  workloadIdBefore20261102?: string;

  /**
   * The unique identifier (GUID) assigned to the member when it is created. For most workload
   * types this is assigned by the resource provider and is read-only. Starting in API version
   * `2026-10-07-preview`, ACI workloads instead supply this value at creation: the ACI resource
   * provider generates the GUID for the sandbox and this field is immutable afterward. Starting in
   * API version `2026-11-02-preview`, the ACI member resource name is this GUID: the service sets
   * memberGuid from the member name, and a value supplied in the request must match the member name.
   */
  @added(Versions.v2026_10_07_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  memberGuid?: Azure.Core.uuid;
}

/** Foundry workload configuration. */
@removed(Versions.v2026_07_21_preview)
model FoundryWorkload extends WorkloadBase {
  /** The workload type. */
  type: "Foundry";

  /** The Azure Resource Manager resource ID of the Foundry resource. */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/** ACI (Azure Container Instances) sandbox workload configuration. */
@added(Versions.v2026_07_21_preview)
model AciWorkload extends WorkloadBase {
  /** The workload type. */
  type: "ACI";

  /**
   * The Azure Resource Manager resource ID of the Azure Container Instances (ACI)
   * resource backing this member's sandbox. Starting in API version
   * `2026-10-07-preview`, this identifies the parent SandboxGroup -- the enrollment
   * boundary associated with the fabric through a ClusterAssociation -- rather than
   * the individual container group.
   */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerInstance/containerGroups";
    },
    {
      @added(Versions.v2026_10_07_preview)
      type: "Microsoft.ContainerInstance/sandboxGroups";
    }
  ]>;

  /** The Entra agent identity associated with the workload. */
  @added(Versions.v2026_10_07_preview)
  agentIdentity?: AgentIdentity;

  /**
   * The human-readable name of the ACI sandbox. The ACI resource provider supplies it at creation.
   * It must be unique within the agent fabric and cannot be changed after the member is created.
   * The member resource name is the sandbox GUID, not this name.
   */
  @added(Versions.v2026_11_02_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  workloadId: string;

  // memberGuid is inherited from WorkloadBase; see its description for the ACI rules.
}

/** A reference to the Kubernetes workload enrolled as a member. */
@added(Versions.v2026_10_07_preview)
model AksWorkloadReference {
  /** The API group and version of the workload, for example `apps/v1`. */
  apiVersion: string;

  /** The kind of the workload, for example `Deployment`. */
  kind: string;

  /** The namespace the workload runs in. */
  @maxLength(63)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  `namespace`: string;

  /** The name of the workload. */
  @maxLength(253)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  name: string;
}

/** A service-to-workload port mapping for an AKS workload. */
@added(Versions.v2026_10_07_preview)
model AksWorkloadPortMapping {
  /** The name of the port mapping. */
  name: string;

  /** The port exposed by the service. */
  @minValue(1)
  @maxValue(65535)
  servicePort: int32;

  /** The network protocol used by the endpoint. */
  protocol: string;

  /** The port on the workload targeted by the service. */
  @minValue(1)
  @maxValue(65535)
  targetPort: int32;
}

/**
 * AKS workload configuration. The workload already exists in the enrolled
 * cluster; the service does not create or schedule it.
 */
@added(Versions.v2026_10_07_preview)
model AksWorkload extends WorkloadBase {
  /** The workload type. */
  type: "AKS";

  /** The Azure Resource Manager resource ID of the cluster association through which this member's workload is enrolled. */
  clusterAssociationId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/agentFabrics/clusterAssociations";
    }
  ]>;

  /** The Azure Resource Manager resource ID of the managed cluster that hosts the workload. */
  @added(Versions.v2026_10_07_preview)
  clusterResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    }
  ]>;

  /** The Kubernetes workload enrolled as this member. Reported when the workload is discovered in the enrolled cluster; member identity derives from the fabric and member name alone. */
  workload: AksWorkloadReference;

  /** The network endpoints exposed by the workload. */
  @added(Versions.v2026_10_07_preview)
  @identifiers(#["name"])
  endpoints?: AksWorkloadPortMapping[];

  /** The unique identifier assigned to the workload by the resource provider. */
  @added(Versions.v2026_11_02_preview)
  @visibility(Lifecycle.Read)
  workloadId?: string;
}

/** The image pull policy for a sandbox workload container image. */
union ImagePullPolicy {
  string,

  /** Always pull the image. */
  Always: "Always",

  /** Pull the image only if it is not already present on the host. */
  IfNotPresent: "IfNotPresent",
}

/** The container image to run for an Agent Fabric sandbox workload. */
model AgentFabricSandboxImage {
  /** The image reference URI (e.g., registry/repository:tag). */
  uri: string;

  /** The image content digest used to pin an exact image version. */
  digest?: string;

  /** The policy controlling when the image is pulled. */
  pullPolicy?: ImagePullPolicy;
}

/** The compute resources allocated to an Agent Fabric sandbox workload. */
model AgentFabricSandboxResources {
  /** The amount of CPU to allocate to the workload. */
  cpu: string;

  /** The amount of memory to allocate to the workload. */
  memory: string;

  /** The amount of disk to allocate to the workload. */
  disk?: string;
}

/** The Entra agent identity associated with an Agent Fabric sandbox workload. */
model AgentIdentity {
  /** The Azure tenant ID that owns the agent identity. */
  tenantId: string;

  /** The Entra agent ID representing the workload's identity. */
  agentId: string;

  /**
   * The Entra agent blueprint ID that this agent identity was instantiated from. The blueprint
   * describes the agent's declared capabilities and is used to scope the policies applied to the
   * workload.
   */
  @added(Versions.v2026_10_07_preview)
  blueprintId?: string;
}

/** A network endpoint exposed by an Agent Fabric sandbox workload. */
model AgentFabricSandboxEndpoint {
  /** The name of the endpoint. */
  name: string;

  /** The port the endpoint listens on. */
  @removed(Versions.v2026_10_07_preview)
  port: int32;

  /** The port exposed by the service. */
  @added(Versions.v2026_10_07_preview)
  @minValue(1)
  @maxValue(65535)
  servicePort: int32;

  /** The network protocol used by the endpoint. */
  @added(Versions.v2026_10_07_preview)
  protocol: string;

  /** The port on the workload targeted by the service. */
  @added(Versions.v2026_10_07_preview)
  @minValue(1)
  @maxValue(65535)
  targetPort: int32;
}

/** Agent Fabric sandbox workload configuration. */
model AgentFabricSandboxWorkload extends WorkloadBase {
  /** The workload type. */
  type: "AgentFabricSandbox";

  /** The container image to run for the workload. */
  image: AgentFabricSandboxImage;

  /** The compute resources allocated to the workload. */
  resources: AgentFabricSandboxResources;

  /** The Entra agent identity associated with the workload. */
  agentIdentity?: AgentIdentity;

  /** The network endpoints exposed by the workload. */
  @identifiers(#["name"])
  endpoints?: AgentFabricSandboxEndpoint[];

  /** The resolvable DNS name assigned to the workload. */
  domain: string;

  /** The unique identifier assigned to the workload by the resource provider. */
  @added(Versions.v2026_11_02_preview)
  @visibility(Lifecycle.Read)
  workloadId?: string;
}

/** Member resource */
@parentResource(AgentFabric)
model Member is TrackedResource<MemberProperties> {
  @doc("The name of the Member")
  @key("memberName")
  @segment("members")
  @path
  @typeChangedFrom(
    Versions.v2026_11_01_preview,
    AgentFabricResourceNames.ResourceNameUpTo24Characters
  )
  name: AgentFabricResourceNames.ResourceName;
}

/** Member properties */
model MemberProperties {
  /** The customer-provided fully qualified domain name associated with the member. */
  @added(Versions.v2026_10_07_preview)
  fqdn?: string;

  /**
   * The workload configuration of the member. Set at creation and immutable
   * thereafter; to change the workload, delete and recreate the member.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  workload?: WorkloadBase;

  /**
   * The SPIFFE ID that identifies this member's workload identity, system-assigned by the service
   * at creation time. It takes the form `spiffe://<trustDomain>/<agentFabricName>/<memberName>`,
   * using the owning fabric's trust domain (or the default `microsoft.agentfabric` when unset), with
   * all segments lower-cased to conform to the SPIFFE ID scheme. Read-only.
   */
  @visibility(Lifecycle.Read)
  spiffeId?: string;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The Member properties that can be updated. */
@added(Versions.v2026_10_07_preview)
model MemberUpdateProperties {
  /** The customer-provided fully qualified domain name associated with the member. */
  fqdn?: string;
}

/** The type used for updating tags in Member resources. */
model MemberTagsUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The Member properties to update. */
  @added(Versions.v2026_10_07_preview)
  properties?: MemberUpdateProperties;
}

@armResourceOperations
interface Members {
  get is ArmResourceRead<Member>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Member>;
  update is ArmCustomPatchAsync<Member, MemberTagsUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<
    Member,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          ArmLroLocationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
  listByParent is ArmResourceListByParent<Member>;
}

/** The direction of network traffic for a policy. */
union PolicyDirection {
  string,

  /** Outbound traffic only. */
  Outbound: "Outbound",

  /** Inbound traffic only. */
  Inbound: "Inbound",

  /** Both inbound and outbound traffic. */
  Both: "Both",
}

/** The type of network security policy. */
union NetworkSecurityPolicyType {
  string,

  /** FQDN filtering policy type. */
  FqdnFiltering: "FqdnFiltering",

  /** URL filtering policy type. */
  UrlFiltering: "UrlFiltering",

  /** MCP server policy type. */
  Mcp: "Mcp",

  /** TLS inspection policy type. */
  TlsInspection: "TlsInspection",

  /** Content inspection policy type. */
  ContentInspection: "ContentInspection",
}

/** Base network security policy configuration. */
@discriminator("type")
model NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: NetworkSecurityPolicyType;
}

/** The type of source selector for an FQDN filtering policy. */
union FqdnFilteringSourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that an FQDN filtering policy applies to. */
@discriminator("type")
model FqdnFilteringSource {
  /** The type of source selector. */
  type: FqdnFilteringSourceType;
}

/** Selects FQDN filtering sources by workload ID patterns. */
model FqdnFilteringWorkloadIdPatternsSource extends FqdnFilteringSource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects FQDN filtering sources by IP address prefixes. */
model FqdnFilteringAddressPrefixesSource extends FqdnFilteringSource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** The type of destination selector for an FQDN filtering policy. */
union FqdnFilteringDestinationType {
  string,

  /** Select destinations by fully qualified domain names. */
  Fqdns: "Fqdns",
}

/** Selects the destination(s) that an FQDN filtering policy applies to. */
@discriminator("type")
model FqdnFilteringDestination {
  /** The type of destination selector. */
  type: FqdnFilteringDestinationType;
}

/** Selects FQDN filtering destinations by fully qualified domain names. */
model FqdnFilteringFqdnsDestination extends FqdnFilteringDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names that identify the destination(s). */
  fqdns: string[];
}

/** FQDN filtering network security policy. */
model FqdnFilteringPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "FqdnFiltering";

  /** The name of the policy. */
  name?: string;

  /** The priority of the policy. */
  priority?: int32;

  /** The direction of traffic for the policy. */
  direction?: PolicyDirection;

  /** The ports for the policy. */
  ports?: int32[];

  /** The source details for the policy. */
  source: FqdnFilteringSource;

  /** The destination details for the policy. */
  destination?: FqdnFilteringDestination;
}

/** The action to take when a network security policy or rule matches traffic. */
union PolicyAction {
  string,

  /** Allow the matching traffic. */
  Allow: "Allow",

  /** Deny the matching traffic. */
  Deny: "Deny",
}

/** The HTTP method matched by a URL filtering rule. */
union HttpMethod {
  string,

  /** HTTP GET method. */
  Get: "GET",

  /** HTTP POST method. */
  Post: "POST",

  /** HTTP PUT method. */
  Put: "PUT",

  /** HTTP DELETE method. */
  Delete: "DELETE",

  /** HTTP PATCH method. */
  Patch: "PATCH",

  /** HTTP HEAD method. */
  Head: "HEAD",

  /** HTTP OPTIONS method. */
  Options: "OPTIONS",
}

/** A single rule within a URL filtering policy. */
model UrlFilteringRule {
  /** The name of the rule. */
  name: string;

  /** The priority of the rule. Rules are evaluated in ascending priority order. */
  priority: int32;

  /** The hostname matched by the rule. If omitted, the rule matches any hostname. */
  @removed(Versions.v2026_11_03_preview)
  @renamedFrom(Versions.v2026_11_03_preview, "hostname")
  hostnameBefore20261103?: string;

  /**
   * The hostname matched by the rule, such as api.contoso.com or *.contoso.com, with no scheme,
   * port or path. Optional in the schema for compatibility; specify it for rules-based authoring.
   */
  @added(Versions.v2026_11_03_preview)
  hostname?: string;

  /** The HTTP method matched by the rule. If omitted, the rule matches any method. */
  method?: HttpMethod;

  /** The URL paths matched by the rule. If omitted, the rule matches any path. */
  paths?: string[];

  /** The action to take when the rule matches. */
  @removed(Versions.v2026_11_03_preview)
  @renamedFrom(Versions.v2026_11_03_preview, "action")
  actionBefore20261103: PolicyAction;

  /** The action to take when the rule matches. If omitted, the rule uses the policy defaultAction. */
  @added(Versions.v2026_11_03_preview)
  action?: PolicyAction;
}

/** The type of source selector for a URL filtering policy. */
union UrlFilteringSourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that a URL filtering policy applies to. */
@discriminator("type")
model UrlFilteringSource {
  /** The type of source selector. */
  type: UrlFilteringSourceType;
}

/** Selects URL filtering sources by workload ID patterns. */
model UrlFilteringWorkloadIdPatternsSource extends UrlFilteringSource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects URL filtering sources by IP address prefixes. */
model UrlFilteringAddressPrefixesSource extends UrlFilteringSource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** The type of destination selector for a URL filtering policy. */
union UrlFilteringDestinationType {
  string,

  /** Select destinations by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select destinations by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",

  /** Select destinations by fully qualified domain names. */
  @removed(Versions.v2026_11_03_preview)
  @renamedFrom(Versions.v2026_11_03_preview, "Fqdns")
  FqdnsBefore20261103: "Fqdns",

  /** Deprecated. Select destinations by fully qualified domain names; use rule hostname for new configurations. */
  #deprecated "Use UrlFilteringRule.hostname for new configurations."
  @added(Versions.v2026_11_03_preview)
  Fqdns: "Fqdns",
}

/** Selects the destination(s) that a URL filtering policy applies to. */
@discriminator("type")
model UrlFilteringDestination {
  /** The type of destination selector. */
  type: UrlFilteringDestinationType;
}

/** Selects URL filtering destinations by workload ID patterns. */
model UrlFilteringWorkloadIdPatternsDestination
  extends UrlFilteringDestination {
  /** The type of destination selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the destination(s). */
  patterns: string[];
}

/** Selects URL filtering destinations by IP address prefixes. */
model UrlFilteringAddressPrefixesDestination extends UrlFilteringDestination {
  /** The type of destination selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the destination(s). */
  prefixes: string[];
}

/** Selects URL filtering destinations by fully qualified domain names. */
#deprecated "Use UrlFilteringRule.hostname for new configurations."
model UrlFilteringFqdnsDestination extends UrlFilteringDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names that identify the destination(s). */
  fqdns: string[];
}

/** URL filtering network security policy. */
model UrlFilteringPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "UrlFiltering";

  /** The default action to take when no rule in the policy matches. */
  @removed(Versions.v2026_11_03_preview)
  @renamedFrom(Versions.v2026_11_03_preview, "defaultAction")
  defaultActionBefore20261103: PolicyAction;

  /**
   * The action for a request to a host that one of the policy's rules names when no rule matches,
   * and the action of a rule that has none. Requests to other hosts are not decided by this policy.
   */
  @added(Versions.v2026_11_03_preview)
  defaultAction: PolicyAction;

  /** The source details for the policy. */
  source: UrlFilteringSource;

  /** The destination details for the policy. */
  destination?: UrlFilteringDestination;

  /** The list of URL filtering rules. */
  @removed(Versions.v2026_11_03_preview)
  @renamedFrom(Versions.v2026_11_03_preview, "rules")
  @identifiers(#["name"])
  rulesBefore20261103: UrlFilteringRule[];

  /**
   * The list of URL filtering rules. Service validation may limit rules-based policies to 1 to 5
   * rules; the schema retains the earlier array shape for compatibility. Rules are evaluated in
   * ascending priority order and the first matching rule decides; rule priorities must be unique
   * within the policy. A rule without an action uses the policy defaultAction. When no rule matches
   * a request to a host that a rule names, the policy defaultAction applies. Requests to other
   * hosts are not decided by this policy.
   */
  @added(Versions.v2026_11_03_preview)
  @identifiers(#["name"])
  rules: UrlFilteringRule[];
}

/** The type of source selector for an MCP policy. */
union McpPolicySourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that an MCP policy applies to. */
@discriminator("type")
model McpPolicySource {
  /** The type of source selector. */
  type: McpPolicySourceType;
}

/** Selects MCP policy sources by workload ID patterns. */
model McpPolicyWorkloadIdPatternsSource extends McpPolicySource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects MCP policy sources by IP address prefixes. */
model McpPolicyAddressPrefixesSource extends McpPolicySource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** The type of destination selector for an MCP policy. */
union McpPolicyDestinationType {
  string,

  /** Select destinations by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select destinations by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",

  /** Select destinations by fully qualified domain names. */
  Fqdns: "Fqdns",
}

/** Selects the MCP server(s) that an MCP policy applies to. */
@discriminator("type")
model McpPolicyDestination {
  /** The type of destination selector. */
  type: McpPolicyDestinationType;
}

/** Selects MCP policy destinations by workload ID patterns. */
model McpPolicyWorkloadIdPatternsDestination extends McpPolicyDestination {
  /** The type of destination selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the destination(s). */
  patterns: string[];
}

/** Selects MCP policy destinations by IP address prefixes. */
model McpPolicyAddressPrefixesDestination extends McpPolicyDestination {
  /** The type of destination selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the destination(s). */
  prefixes: string[];
}

/** Selects MCP policy destinations by fully qualified domain names. */
model McpPolicyFqdnsDestination extends McpPolicyDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names that identify the destination(s). */
  fqdns: string[];
}

/** How an MCP string condition compares a request or response string with its values. */
@added(Versions.v2026_11_03_preview)
union McpMatchType {
  string,

  /** The string equals one of the values. */
  ExactMatch: "ExactMatch",

  /** The string contains one of the values. */
  Contains: "Contains",

  /** The string equals none of the values. */
  NotExactMatch: "NotExactMatch",

  /** The string contains none of the values. */
  NotContains: "NotContains",
}

/** Whether an MCP string condition compares case-sensitively. */
@added(Versions.v2026_11_03_preview)
union McpMatchCase {
  string,

  /** Compare strings exactly. This is the default. */
  CaseSensitive: "CaseSensitive",

  /** Compare strings after case folding both sides: uppercase, then lowercase. */
  CaseInsensitive: "CaseInsensitive",
}

/** An MCP tool request method. */
@added(Versions.v2026_11_03_preview)
union McpToolMethod {
  string,

  /** The tools/call request. */
  Call: "Call",

  /** The tools/list request. */
  List: "List",
}

/** An MCP prompt request method. */
@added(Versions.v2026_11_03_preview)
union McpPromptMethod {
  string,

  /** The prompts/get request. */
  Get: "Get",

  /** The prompts/list request. */
  List: "List",
}

/**
 * One text value to look for, such as a tool name, a word in an argument, or a protocol version
 * like 2025-06-18. At most 1024 characters.
 */
@added(Versions.v2026_11_03_preview)
@maxLength(1024)
scalar McpMatchValue extends string;

/**
 * Compares one string of an MCP request or response with a list of values. ExactMatch and
 * Contains hold when one value matches; NotExactMatch and NotContains hold when no value matches.
 */
@added(Versions.v2026_11_03_preview)
model McpStringMatching {
  /** The values to compare with: 1 to 64, or 1 to 16 non-empty values for Contains and NotContains. */
  @minItems(1)
  @maxItems(64)
  values: McpMatchValue[];

  /** How the string is compared with the values. */
  matchType: McpMatchType;

  /** Whether the comparison is case-sensitive. The default is CaseSensitive. */
  matchCase?: McpMatchCase;
}

/**
 * Compares the argument values of an MCP request with a list of values. Only string values
 * are compared, and a boolean compares as true or false. Without a path, object keys are
 * compared too.
 */
@added(Versions.v2026_11_03_preview)
model McpArgumentMatching {
  ...McpStringMatching;

  /**
   * A JSONPath into the request's params.arguments object, which is `$`: 1 to 8 segments,
   * the first `.name` and the others `.name` or `[*]` (at most once), for example
   * `$.repoName` or `$.paths[*]`. With a path, a missing key (also in an array element), a key
   * that differs only in case, or a value of the wrong type on the way is a mismatch: an Allow
   * condition holds only when there is none and every selected value passes, and a Deny
   * condition also holds when there is one, when the path selects nothing, or when a selected
   * value is not a string or boolean. Without a path every string or boolean argument value and
   * every object key is compared; this is allowed only for ExactMatch or Contains in a Deny
   * rule and for NotExactMatch or NotContains in an Allow rule.
   */
  @minLength(2)
  @maxLength(256)
  @pattern("^\\$\\.[A-Za-z_][A-Za-z0-9_-]*(\\.[A-Za-z_][A-Za-z0-9_-]*|\\[\\*\\])*$")
  path?: string;
}

/** The tool conditions of an MCP rule. Present properties are ANDed. */
@added(Versions.v2026_11_03_preview)
model McpToolMatching {
  /**
   * The tool methods to match. Omitted means Call. Names and callArguments need Call alone.
   * Titles and descriptions need List alone.
   */
  @minItems(1)
  @maxItems(2)
  methods?: McpToolMethod[];

  /** Compared with the tool name of a tools/call request. */
  names?: McpStringMatching;

  /** Compared with the title of each tool in a tools/list response. Needs methods List alone. */
  titles?: McpStringMatching;

  /** Compared with the description of each tool in a tools/list response. Needs methods List alone. */
  descriptions?: McpStringMatching;

  /** Compared with the arguments of a tools/call request. */
  callArguments?: McpArgumentMatching;

  /** Compared with the text of each content item, result.content[].text, of a tools/call response. */
  responseContents?: McpStringMatching;
}

/** The prompt conditions of an MCP rule. Present properties are ANDed. */
@added(Versions.v2026_11_03_preview)
model McpPromptMatching {
  /**
   * The prompt methods to match. Omitted means Get. Names and arguments need Get alone. Titles
   * and descriptions need List alone.
   */
  @minItems(1)
  @maxItems(2)
  methods?: McpPromptMethod[];

  /** Compared with the prompt name of a prompts/get request. */
  names?: McpStringMatching;

  /** Compared with the title of each prompt in a prompts/list response. Needs methods List alone. */
  titles?: McpStringMatching;

  /** Compared with the description of each prompt in a prompts/list response. Needs methods List alone. */
  descriptions?: McpStringMatching;

  /** Compared with the arguments of a prompts/get request. */
  arguments?: McpArgumentMatching;

  /**
   * Compared with the text of each message, result.messages[].content.text, of a prompts/get
   * response.
   */
  responseContents?: McpStringMatching;
}

/**
 * The MCP servers and requests an MCP rule matches. Present properties are ANDed. A rule has
 * at most one of toolMatching and promptMatching. Without either, it matches every request to
 * its servers.
 */
@added(Versions.v2026_11_03_preview)
model McpRuleDestinationMatching {
  /**
   * The MCP servers: exact names or one leading `*.`, each inside the policy destination.
   * Omitted means every server of the policy destination.
   */
  @minItems(1)
  @maxItems(16)
  serverFqdns?: string[];

  /**
   * Compared with params.protocolVersion of an initialize request, the protocol version such as
   * 2025-06-18 that a client names when it starts a session. A request that names no protocol
   * version does not match the rule, so a Deny rule blocks sessions that start with a listed version.
   */
  protocolVersions?: McpStringMatching;

  /** Conditions on tool requests. */
  toolMatching?: McpToolMatching;

  /** Conditions on prompt requests. */
  promptMatching?: McpPromptMatching;
}

/** The conditions of an MCP rule. The rule applies to the sources of its policy. */
@added(Versions.v2026_11_03_preview)
model McpRuleMatchingConditions {
  /** The servers and requests the rule matches. */
  destinations: McpRuleDestinationMatching;
}

/** A single rule within an MCP policy. */
model McpRule {
  /**
   * The name of the rule: 1 to 63 ASCII letters, digits, '_', '.' or '-', starting with a
   * letter or digit, and unique within the policy ignoring case. Flow logs report the rule
   * that decided as `mcp-<n>/<name>`.
   */
  @added(Versions.v2026_11_03_preview)
  @minLength(1)
  @maxLength(63)
  @pattern("^[A-Za-z0-9][A-Za-z0-9_.-]*$")
  name?: string;

  /**
   * The priority of the rule, unique within the policy. Rules are tried from the lowest value
   * and the first rule that matches decides; a policy has 1 to 5 rules. When none
   * matches, defaultAction applies to every MCP request except session requests (initialize,
   * ping, notifications, the list methods, JSON-RPC responses, and requests with no body such
   * as GET and DELETE), which pass.
   */
  @added(Versions.v2026_11_03_preview)
  @minValue(1)
  priority?: int32;

  /** The action to take for the specified MCP tools. */
  @madeOptional(Versions.v2026_11_03_preview)
  action?: PolicyAction;

  /** The MCP tool names that the rule applies to. */
  @removed(Versions.v2026_11_03_preview)
  @renamedFrom(Versions.v2026_11_03_preview, "tools")
  toolsBefore20261103: string[];

  /** Deprecated. Legacy MCP tool names retained for compatibility; use matchingConditions.destinations.toolMatching.names for new rules. */
  #deprecated "Use matchingConditions.destinations.toolMatching.names for new rules."
  @added(Versions.v2026_11_03_preview)
  tools?: string[];

  /** The conditions of the rule. A rule without an action uses defaultAction. */
  @added(Versions.v2026_11_03_preview)
  matchingConditions?: McpRuleMatchingConditions;
}

/** MCP server network security policy. */
model McpPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "Mcp";

  /** The default action to take when no rule in the policy matches. */
  defaultAction: PolicyAction;

  /** The source(s) that this policy applies to. */
  source: McpPolicySource;

  /** The MCP server(s) that this policy applies to. */
  destination: McpPolicyDestination;

  /** The list of MCP rules. */
  @identifiers(#[])
  rules: McpRule[];
}

/** The source of the certificate used for TLS inspection. */
union TlsInspectionCertificateMode {
  string,

  /** Certificate issued by an Azure-managed certificate authority. */
  AzureManagedCA: "AzureManagedCA",
}

/** Base certificate configuration for a TLS inspection policy. */
@discriminator("mode")
model TlsInspectionCertificateBase {
  /** The source mode of the TLS inspection certificate. */
  mode: TlsInspectionCertificateMode;
}

/** TLS inspection certificate issued by an Azure-managed certificate authority. */
model AzureManagedCaCertificate extends TlsInspectionCertificateBase {
  /** The source mode of the TLS inspection certificate. */
  mode: "AzureManagedCA";
}

/** The type of source selector for a TLS inspection policy. */
union TlsInspectionPolicySourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",
}

/** Selects the source(s) that a TLS inspection policy applies to. */
@discriminator("type")
model TlsInspectionPolicySource {
  /** The type of source selector. */
  type: TlsInspectionPolicySourceType;
}

/** Selects TLS inspection sources by workload ID patterns. */
model TlsInspectionPolicyWorkloadIdPatternsSource
  extends TlsInspectionPolicySource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** The TLS inspection action. */
@added(Versions.v2026_11_03_preview)
union TlsInspectionAction {
  string,

  /** Intercept and decrypt the TLS connection, so policies that read the HTTP request apply. */
  Inspect: "Inspect",

  /** Do not intercept the TLS connection. FQDN filtering still applies, using the TLS server name (SNI). */
  Bypass: "Bypass",
}

/** The type of destination selector for a TLS inspection rule. */
@added(Versions.v2026_11_03_preview)
union TlsInspectionRuleDestinationType {
  string,

  /** Select destinations by fully qualified domain names. */
  Fqdns: "Fqdns",
}

/** Selects the destinations that a TLS inspection rule matches. */
@added(Versions.v2026_11_03_preview)
@discriminator("type")
model TlsInspectionRuleDestination {
  /** The type of destination selector. */
  type: TlsInspectionRuleDestinationType;
}

/** Selects TLS inspection rule destinations by fully qualified domain names, matched against the TLS server name (SNI). */
@added(Versions.v2026_11_03_preview)
model TlsInspectionRuleFqdnsDestination extends TlsInspectionRuleDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names. Each is an exact name, or a name after one leading '*.', which matches that name and any subdomain of it. Matching ignores case and one trailing dot. */
  @minItems(1)
  @maxItems(100)
  fqdns: string[];
}

/** A TLS inspection rule. */
@added(Versions.v2026_11_03_preview)
model TlsInspectionRule {
  /** The name of the rule, unique within the policy ignoring case. */
  @minLength(1)
  @maxLength(63)
  @pattern("^[A-Za-z0-9][A-Za-z0-9_.-]*$")
  name: string;

  /** The priority of the rule, unique within the policy. Rules are evaluated in ascending priority order and the first match applies. */
  @minValue(1)
  priority: int32;

  /** The action for TLS connections that match the rule. If omitted, the rule takes the policy's defaultAction, so it only matters for rule ordering. */
  action?: TlsInspectionAction;

  /** The destinations that the rule matches. A connection matches the rule when it matches any of them. At most one destination is supported. */
  @minItems(1)
  @maxItems(1)
  @identifiers(#[])
  destinations: TlsInspectionRuleDestination[];
}

/** TLS inspection network security policy. */
model TlsInspectionPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "TlsInspection";

  /** The source details for the policy. */
  source: TlsInspectionPolicySource;

  /** The certificate configuration used for TLS inspection. */
  certificate: TlsInspectionCertificateBase;

  /** The action for TLS connections that no rule matches, and for rules without an action. If omitted, Inspect. */
  @added(Versions.v2026_11_03_preview)
  defaultAction?: TlsInspectionAction;

  /** The TLS inspection rules. At most one rule is supported. */
  @added(Versions.v2026_11_03_preview)
  @maxItems(1)
  @identifiers(#["name"])
  rules?: TlsInspectionRule[];
}

/** The sensitivity level of content inspection. */
union ContentInspectionSensitivity {
  string,

  /** Low sensitivity. */
  Low: "Low",

  /** Medium sensitivity. */
  Medium: "Medium",

  /** High sensitivity. */
  High: "High",
}

/** The action to take when prompt injection is detected. */
union PromptInjectionOnDetection {
  string,

  /** Block the request or response and raise an alert. */
  BlockAndAlert: "BlockAndAlert",

  /** Raise an alert but allow the request or response to proceed. */
  Alert: "Alert",

  /** Remove the detected content and allow the request or response to proceed. */
  Sanitize: "Sanitize",
}

/** Prompt injection protection configuration. */
model PromptInjectionProtection {
  /** The sensitivity level of prompt injection detection. */
  sensitivity?: ContentInspectionSensitivity;

  /** The JSONPath expressions selecting the parts of the request body to scan for prompt injection. */
  promptLocations?: string[];

  /** The JSONPath expressions selecting the parts of the response body to scan for prompt injection. */
  responseLocations?: string[];

  /** The action to take when prompt injection is detected. */
  onDetection: PromptInjectionOnDetection;
}

/** The type of source selector for a content inspection policy. */
union ContentInspectionPolicySourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that a content inspection policy applies to. */
@discriminator("type")
model ContentInspectionPolicySource {
  /** The type of source selector. */
  type: ContentInspectionPolicySourceType;
}

/** Selects content inspection sources by workload ID patterns. */
model ContentInspectionPolicyWorkloadIdPatternsSource
  extends ContentInspectionPolicySource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects content inspection sources by IP address prefixes. */
model ContentInspectionPolicyAddressPrefixesSource
  extends ContentInspectionPolicySource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** Content inspection network security policy. */
model ContentInspectionPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "ContentInspection";

  /** The source details for the policy. */
  source: ContentInspectionPolicySource;

  /** The prompt injection protection configuration. */
  promptInjectionProtection?: PromptInjectionProtection;
}

/** PolicyGroup resource. */
model PolicyGroup is TrackedResource<PolicyGroupProperties> {
  @doc("The name of the PolicyGroup")
  @key("policyGroupName")
  @segment("policyGroups")
  @path
  @typeChangedFrom(
    Versions.v2026_11_01_preview,
    AgentFabricResourceNames.ResourceNameUpTo24Characters
  )
  name: AgentFabricResourceNames.ResourceName;
}

/** PolicyGroup properties. */
model PolicyGroupProperties {
  /** The display name of the policy group. */
  displayName?: string;

  /** The description of the policy group. */
  description?: string;

  /** The priority of the policy group. */
  priority?: int32;

  /** The list of network security policies. */
  @removed(Versions.v2026_10_07_preview)
  @renamedFrom(Versions.v2026_10_07_preview, "networkSecurityPolicies")
  @identifiers(#[])
  networkSecurityPoliciesBefore20261007?: NetworkSecurityPolicyBase[];

  /**
   * The list of network security policies. A PUT introducing a ContentInspection
   * policy is incompatible if any associated fabric has no configured inspection connection,
   * regardless of whether selectors currently match traffic. The request is rejected before
   * persisting or distributing the proposed changes, preserving the previously
   * accepted policies; mixed compatible and incompatible associations cannot partially apply
   * changes or silently skip inspection. An unattached group, or one attached only to compatible
   * fabrics, may contain ContentInspection policies. Removing ContentInspection policies remains allowed,
   * subject to other validation.
   */
  @added(Versions.v2026_10_07_preview)
  @identifiers(#[])
  networkSecurityPolicies?: NetworkSecurityPolicyBase[];

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface PolicyGroups {
  get is ArmResourceRead<PolicyGroup>;

  @removed(Versions.v2026_10_07_preview)
  @renamedFrom(Versions.v2026_10_07_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateBefore20261007 is ArmResourceCreateOrReplaceAsync<PolicyGroup>;

  /**
   * Creates or replaces a PolicyGroup.
   *
   * If the PUT introduces a ContentInspection policy in networkSecurityPolicies and any
   * associated fabric has no configured inspection connection, reject the
   * request with HTTP 409 and error code ContentInspectionCapabilityDisabled, targeting
   * properties.networkSecurityPolicies. Validate before persisting or distributing policy changes,
   * preserving the previously accepted policies on rejection. Do not partially apply changes to
   * compatible fabrics or silently skip inspection for fabrics without an inspection connection.
   *
   * Compatibility uses the associated fabrics' stored configuration, independent of whether
   * policy selectors currently match traffic. This is a configuration check, not a fresh Content
   * Safety connectivity probe. Changes that do not introduce ContentInspection policies do not
   * require this check; transient connection failures do not remove a fabric's configuration.
   * Existing legacy fabrics without a profile retain their regional Content Safety connection,
   * which satisfies the inspection prerequisite without new probes, management calls, or key
   * retrieval. A connection still being validated is not an absent connection.
   * Unattached groups and groups associated only with compatible fabrics may
   * contain ContentInspection policies. Removing those policies or detaching a group
   * remains allowed, subject to other validation. Tags-only PATCH does not change policy contents.
   * Error messages must not disclose associated fabric IDs the caller is not authorized to read.
   *
   * Example rejection response (HTTP 409 Conflict):
   *
   * ```json
   * {
   *   "error": {
   *     "code": "ContentInspectionCapabilityDisabled",
   *     "message": "The proposed ContentInspection policy is incompatible with an associated fabric that has no configured inspection connection.",
   *     "target": "properties.networkSecurityPolicies"
   *   }
   * }
   * ```
   */
  @added(Versions.v2026_10_07_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PolicyGroup>;
  update is ArmTagsPatchAsync<PolicyGroup>;
  delete is ArmResourceDeleteWithoutOkAsync<
    PolicyGroup,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          ArmLroLocationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
  listByResourceGroup is ArmResourceListByParent<PolicyGroup>;
  listBySubscription is ArmListBySubscription<PolicyGroup>;
}

@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.NetworkSecurity",

    ...Azure.ResourceManager.CommonTypes.LocationParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");

/**
 * ClusterAssociation resource. Enrolls an AKS managed cluster, or an ACI
 * SandboxGroup, into this AgentFabric; deleting it removes the enrollment.
 *
 * This is not a Member. Workloads are enrolled separately, and creating an
 * association does not create members.
 */
@added(Versions.v2026_10_07_preview)
@parentResource(AgentFabric)
model ClusterAssociation is TrackedResource<ClusterAssociationProperties> {
  @doc("The name of the ClusterAssociation")
  @key("clusterAssociationName")
  @segment("clusterAssociations")
  @path
  @typeChangedFrom(
    Versions.v2026_11_01_preview,
    AgentFabricResourceNames.ResourceNameUpTo24Characters
  )
  name: AgentFabricResourceNames.ResourceName;
}

/** The name of a cluster association SKU. */
@added(Versions.v2026_10_07_preview)
union ClusterAssociationSkuName {
  string,

  /** AgentGateway only. */
  Standard: "Standard",

  /** AgentGateway and AgentFabric. */
  Premium: "Premium",
}

/** Error information for a failed cluster association. */
@added(Versions.v2026_10_07_preview)
model ClusterAssociationStatus {
  /** Stable, machine-readable error code. */
  @visibility(Lifecycle.Read)
  code?: string;

  /** Human-readable description of the failure. */
  @visibility(Lifecycle.Read)
  message?: string;
}

/** ClusterAssociation properties */
@added(Versions.v2026_10_07_preview)
model ClusterAssociationProperties {
  /**
   * The AKS managed cluster or ACI SandboxGroup to enroll. The resource must be
   * in the same subscription as the AgentFabric; a different resource group is
   * allowed. Set at creation and immutable thereafter; to enroll a different
   * resource, delete and recreate the association. AF rejects the request if
   * the resource is already associated with another fabric.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    },
    {
      type: "Microsoft.ContainerInstance/sandboxGroups";
    }
  ]>;

  /**
   * Determines which AgentFabric components are deployed to the cluster.
   * Defaults to Standard when omitted at creation. An update may upgrade
   * Standard to Premium but cannot downgrade Premium to Standard. The SKU
   * remains unchanged when omitted during an update.
   */
  sku?: ClusterAssociationSkuName;

  /**
   * The IPv4 or IPv6 address of the workload cluster gateway used for
   * internal Agent Fabric routing. The resource provider validates the value.
   */
  @visibility(Lifecycle.Update)
  workloadClusterGatewayIp?: string;

  /**
   * Error code and message for a failed association. A failed association is
   * retained rather than deleted, so the failure can be inspected and retried.
   * Read-only.
   */
  @visibility(Lifecycle.Read)
  status?: ClusterAssociationStatus;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Properties that may be updated on a ClusterAssociation. */
@added(Versions.v2026_10_07_preview)
model ClusterAssociationUpdateProperties {
  /**
   * The existing AKS managed cluster or ACI SandboxGroup. This value is
   * required so Azure Resource Manager can perform linked authorization and
   * must match the immutable clusterResourceId already stored on the
   * association.
   */
  @madeOptional(Versions.v2026_11_01_preview)
  clusterResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    },
    {
      type: "Microsoft.ContainerInstance/sandboxGroups";
    }
  ]>;

  /**
   * Determines which AgentFabric components are deployed to the cluster.
   * Only an upgrade from Standard to Premium is supported; Premium cannot be
   * downgraded to Standard. When omitted, the PATCH request is an authorized
   * no-op and the existing SKU remains unchanged.
   */
  sku?: ClusterAssociationSkuName;

  /**
   * The IPv4 or IPv6 address of the workload cluster gateway used for
   * internal Agent Fabric routing. The resource provider validates the value.
   */
  workloadClusterGatewayIp?: string;
}

/** The request body for updating a ClusterAssociation. */
@added(Versions.v2026_10_07_preview)
model ClusterAssociationUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The ClusterAssociation properties to update. */
  properties: ClusterAssociationUpdateProperties;
}

/** Allowed If-None-Match values for cluster association creation. */
@added(Versions.v2026_10_07_preview)
union ClusterAssociationIfNoneMatch {
  string,

  /** Match any current representation. */
  Wildcard: "*",
}

/** Additional parameters for creating or updating a cluster association. */
@added(Versions.v2026_10_07_preview)
model ClusterAssociationCreateOrUpdateParameters {
  /**
   * Set to "*" when creating an association to require that the resource does
   * not already exist. The service returns 412 Precondition Failed when the
   * condition is not met.
   */
  @header("If-None-Match")
  ifNoneMatch?: ClusterAssociationIfNoneMatch;
}

@added(Versions.v2026_10_07_preview)
@armResourceOperations
interface ClusterAssociations {
  get is ArmResourceRead<ClusterAssociation>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterAssociation,
    Parameters = ClusterAssociationCreateOrUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<ClusterAssociation>
      | AgentFabricResourceNames.CreatedResponseWithoutPollingLocation<
          ClusterAssociation,
          ArmAsyncOperationHeader<FinalResult = ClusterAssociation> &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;
  update is ArmCustomPatchAsync<ClusterAssociation, ClusterAssociationUpdate>;
  /**
   * Deletes the association. Idempotent: returns `202 Accepted` when completion is
   * asynchronous, and `204 No Content` when it completes synchronously or the
   * association is already absent.
   *
   * For an association enrolling an ACI SandboxGroup (`clusterResourceId` of type
   * `Microsoft.ContainerInstance/sandboxGroups`), the service returns
   * `409 ClusterAssociationNotEmpty` while any Member still references the
   * SandboxGroup. All such Members must be deleted before the association can be
   * removed.
   *
   * ```json
   * {
   *   "error": {
   *     "code": "ClusterAssociationNotEmpty",
   *     "message": "The ClusterAssociation cannot be deleted because one or more members still reference it.",
   *     "target": "properties.clusterResourceId"
   *   }
   * }
   * ```
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterAssociation,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          ArmLroLocationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
  listByParent is ArmResourceListByParent<ClusterAssociation>;
}

/**
 * The egress TLS-inspection trust bundle for an agent fabric.
 *
 * AgentFabric terminates and re-encrypts enrolled egress traffic, presenting leaf
 * certificates signed by an AgentFabric-operated certificate authority. A workload can only
 * complete those handshakes if the CA's PUBLIC anchor is already present in its trust store.
 * This singleton publishes the anchors that are installed into the fabric's sandboxes, so
 * the compute platform can install them during sandbox bring-up and so you can audit exactly
 * which authorities your workloads are being asked to trust.
 *
 * The resource is read-only and computed: it is never created, updated or deleted through
 * ARM, and reading it neither enrolls a workload nor redirects any traffic. It returns PUBLIC
 * certificates only -- private key material never leaves AgentFabric's key vault.
 *
 * A bundle is always returned as a list, even when it holds a single anchor, so that a CA
 * rollover can publish the outgoing and incoming anchors together.
 */
@added(Versions.v2026_10_07_preview)
@parentResource(AgentFabric)
@singleton("default")
model EgressTrustBundle is ProxyResource<EgressTrustBundleProperties> {
  ...ResourceNameParameter<EgressTrustBundle>;
}

/** Properties of the platform egress TLS-inspection trust bundle. */
@added(Versions.v2026_10_07_preview)
model EgressTrustBundleProperties {
  /**
   * The public certificate authority anchors that make up the bundle, ordered with the
   * currently signing anchor first. Always contains at least one entry.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["certificateId"])
  certificates: EgressTrustBundleCertificate[];

  /**
   * Opaque identifier of this bundle's content. It changes whenever the set of anchors
   * changes and is stable otherwise, so a caller can record what a sandbox was provisioned
   * with and detect drift without comparing certificate bytes.
   */
  @visibility(Lifecycle.Read)
  bundleVersion: string;

  /**
   * How long, in seconds, a caller may serve this bundle from its own cache. This is a
   * ceiling, not a target: refresh well before it elapses, at roughly half this value, so a
   * transient failure still leaves time to retry before the cached copy must be discarded.
   * The service sets this value and may change it to steer how often callers re-read, so
   * honour the value returned rather than hard-coding an interval. Callers are expected to
   * cache; a synchronous dependency on this operation during every sandbox launch is not
   * intended.
   */
  @minValue(60)
  @visibility(Lifecycle.Read)
  cacheValiditySeconds: int32;

  /**
   * The absolute deadline matching `cacheValiditySeconds`. A cached copy must not be used
   * after this instant without re-reading. Reaching it means the earlier refresh was missed
   * or failing; a caller that cannot obtain an acceptable bundle must fail or retry
   * bring-up rather than silently skip anchor installation.
   */
  @visibility(Lifecycle.Read)
  cacheExpiresAt: utcDateTime;

  /**
   * The provisioning state of the resource. This resource is computed rather than
   * provisioned, so a successful read always reports `Succeeded`.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** A single public certificate authority anchor within the egress trust bundle. */
@added(Versions.v2026_10_07_preview)
model EgressTrustBundleCertificate {
  /**
   * Stable identifier of this anchor, unique within the bundle. Derived from the
   * certificate itself, so it is identical wherever the same anchor is served.
   */
  @visibility(Lifecycle.Read)
  certificateId: string;

  /**
   * The PEM-encoded X.509 public certificate. This never contains private key material.
   */
  @visibility(Lifecycle.Read)
  pem: string;

  /** Lowercase hexadecimal SHA-256 fingerprint of the certificate's DER encoding. */
  @visibility(Lifecycle.Read)
  thumbprintSha256: string;

  /** The time from which the certificate is valid. */
  @visibility(Lifecycle.Read)
  notBefore: utcDateTime;

  /** The time after which the certificate is no longer valid. */
  @visibility(Lifecycle.Read)
  notAfter: utcDateTime;
}

@added(Versions.v2026_10_07_preview)
@armResourceOperations
interface EgressTrustBundles {
  /**
   * Gets the egress TLS-inspection trust bundle for the fabric.
   *
   * The bundle changes rarely, so callers are expected to cache it for the advertised
   * validity period rather than reading it per workload. To decide whether a cached copy is
   * still current, compare `bundleVersion`: it is derived from the anchor set, so it changes
   * exactly when the anchors change and is stable otherwise. Every read returns the full
   * bundle together with refreshed cache metadata.
   */
  get is ArmResourceRead<EgressTrustBundle>;

  /**
   * Lists the egress TLS-inspection trust bundles for the fabric. The bundle is a singleton,
   * so this returns the single `default` bundle. It exists because Azure Policy cannot
   * populate compliance data for a resource type that has no collection GET.
   */
  listByParent is ArmResourceListByParent<EgressTrustBundle>;
}
