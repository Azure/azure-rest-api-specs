import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CleanRoom;

/**
 * Provisioning states.
 */
union ProvisioningState {
  ResourceProvisioningState,
  string,

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is being updated.")
  Updating: "Updating",

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  @doc("Resource operation has been accepted.")
  Accepted: "Accepted",
}

/**
 * Types of consortium types.
 */
union ConsortiumType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConfidentialACI: "ConfidentialACI",
}

/**
 * Types of collaboration types.
 */
@removed(Versions.v2025_10_31_preview)
union CollaborationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CleanRoom: "CleanRoom",
}

/**
 * Types of account types.
 */
@added(Versions.v2025_10_31_preview)
union AccountType {
  string,

  /**
   * Microsoft account.
   */
  Microsoft: "microsoft",
}

/**
 * List of collaborations.
 */
model CollaborationsList is Azure.Core.Page<Collaboration>;

/**
 * Defines the resource properties.
 */
model CollaborationProperties {
  /**
   * Gets or sets the CCF endpoint.
   */
  @removed(Versions.v2025_10_31_preview)
  consortiumEndpoint: string;

  /**
   * Gets or sets the CCF public service certificate in PEM format.
   */
  @removed(Versions.v2025_10_31_preview)
  consortiumServiceCertificatePem: string;

  /**
   * Gets or sets the collaboration member.
   */
  @removed(Versions.v2025_10_31_preview)
  member: CollaborationMember;

  /**
   * Gets or sets the cluster endpoint.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_10_31_preview)
  clusterEndpoint: string;

  /**
   * Gets or sets the consortium type.
   */
  @added(Versions.v2025_10_31_preview)
  consortiumType: ConsortiumType;

  /**
   * Gets or sets the consortium ARM ID.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_10_31_preview)
  consortiumArmId: Azure.Core.armResourceIdentifier;

  /**
   * Gets or sets the workloads.
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_10_31_preview)
  workloads: Workload[];

  /**
   * Gets or sets the user identity.
   */
  @added(Versions.v2025_10_31_preview)
  userIdentity: UserIdentity;

  /**
   * Gets or sets the health of the collaboration.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_10_31_preview)
  health: Health;

  /**
   * Gets or sets the managed on-behalf-of configuration.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_10_31_preview)
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  /**
   * Gets or sets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Types of workload types.
 */
@added(Versions.v2025_10_31_preview)
union WorkloadType {
  string,

  /**
   * Analytics workload.
   */
  Analytics: "analytics",
}

/**
 * Configuration details of the workload.
 */
@added(Versions.v2025_10_31_preview)
model Workload {
  /**
   * Type of the workload.
   */
  workloadType: WorkloadType;

  /**
   * Endpoint of the workload.
   */
  endpoint: string;

  /**
   * Namespace of the workload.
   */
  `namespace`: string;
}

/**
 * Configuration details of the user identity.
 */
@added(Versions.v2025_10_31_preview)
model UserIdentity {
  /**
   * Tenant ID of the user identity.
   */
  tenantId: string;

  /**
   * Object ID of the user identity.
   */
  objectId: string;

  /**
   * Account type of the user identity.
   */
  accountType: AccountType;
}

/**
 * Input model to enable a workload.
 */
@added(Versions.v2025_10_31_preview)
model EnableWorkloadInput {
  /**
   * Type of the workload to be enabled.
   */
  workloadType: WorkloadType;
}

/**
 * Input model to add a collaborator.
 */
@added(Versions.v2025_10_31_preview)
model AddCollaboratorInput {
  /**
   * Email of the collaborator to be added.
   */
  email: string;
}

/**
 * Input model to recover a collaboration.
 */
@added(Versions.v2025_10_31_preview)
model RecoverCollaborationInput {
  /**
   * Indicates whether to force recover the collaboration.
   */
  forceRecover: boolean;
}

/**
 * Input model to recover a consortium.
 */
@added(Versions.v2025_10_31_preview)
model RecoverConsortiumInput {
  /**
   * Indicates whether to force recover the consortium.
   */
  forceRecover: boolean;
}

/**
 * Health states.
 */
@added(Versions.v2025_10_31_preview)
union HealthState {
  string,

  /**
   * Resource is healthy.
   */
  Ok: "Ok",

  /**
   * Resource is not healthy.
   */
  Error: "Error",
}

/**
 * Health of a resource.
 */
@added(Versions.v2025_10_31_preview)
model Health {
  /**
   * Health state of the resource.
   */
  healthState: HealthState;

  /**
   * List of health issues associated with the resource.
   */
  @Azure.ResourceManager.identifiers(#[])
  healthIssues?: HealthIssue[];
}

/**
 * Health issue of a resource.
 */
@added(Versions.v2025_10_31_preview)
model HealthIssue {
  /**
   * Status code representing the health of the resource.
   */
  code: string;

  /**
   * Message providing additional information about the health status.
   */
  message: string;
}

/**
 * Configuration details of the collaboration members.
 */
@removed(Versions.v2025_10_31_preview)
model CollaborationMember {
  /**
   * Identifier of the member.
   */
  @visibility(Lifecycle.Read)
  identifier?: string;

  /**
   * Signature of the member (member identifier signed using the member private certificate).
   */
  signature: string;

  /**
   * Gets or sets the public certificate of the member in PEM format.
   */
  certificatePem: string;
}

/**
 * List of consortium views.
 */
@added(Versions.v2025_10_31_preview)
model ConsortiumViewsList is Azure.Core.Page<ConsortiumView>;

/**
 * Defines the resource properties.
 */
@added(Versions.v2025_10_31_preview)
model ConsortiumViewProperties {
  /**
   * Gets or sets the CCF endpoint.
   */
  consortiumEndpoint: string;

  /**
   * Gets or sets the CCF public service certificate in PEM format.
   */
  consortiumServiceCertificatePem: string;

  /**
   * Gets or sets the consortium view member.
   */
  member: ConsortiumViewMember;

  /**
   * Gets or sets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Configuration details of the consortium view members.
 */
@added(Versions.v2025_10_31_preview)
model ConsortiumViewMember {
  /**
   * Identifier of the member.
   */
  @visibility(Lifecycle.Read)
  identifier?: string;

  /**
   * Signature of the member (member identifier signed using the member private certificate).
   */
  @secret
  signedPayload: string;

  /**
   * Gets or sets the public certificate of the member in PEM format.
   */
  certificatePem: string;
}

/**
 * Object containing resource tags for patch operations.
 */
model ResourceTags {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * List of consortiums.
 */
model ConsortiumsList is Azure.Core.Page<Consortium>;

/**
 * Defines the resource properties.
 */
model ConsortiumProperties {
  /**
   * Gets or sets the consortium type.
   */
  consortiumType?: ConsortiumType;

  /**
   * Gets or sets the collaboration type.
   */
  @removed(Versions.v2025_10_31_preview)
  collaborationType?: CollaborationType;

  /**
   * Gets or sets the endpoint.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * Gets or sets the public service certificate in PEM format.
   */
  @visibility(Lifecycle.Read)
  serviceCertificatePem?: string;

  /**
   * Gets or sets the list of members to be added to the consortium.
   */
  @Azure.ResourceManager.identifiers(#[])
  members?: ConsortiumMember[];

  /**
   * Gets or sets the health of the consortium.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_10_31_preview)
  health: Health;

  /**
   * Gets or sets the managed on-behalf-of configuration.
   */
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  /**
   * Gets or sets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Configuration details of the consortium member.
 */
model ConsortiumMember {
  /**
   * Identifier of the member.
   */
  identifier: string;

  /**
   * Gets or sets the public certificate of the member in PEM format.
   */
  certificatePem: string;

  /**
   * Gets or sets the public encryption key of the member in PEM format.
   */
  encryptionKeyPem: string;

  /**
   * Indicates if the member is an operator.
   */
  isOperator: boolean;
}

/**
 * Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner.
 */
model ManagedOnBehalfOfConfiguration {
  /**
   * Managed-On-Behalf-Of broker resources
   */
  @identifiers(#["id"])
  moboBrokerResources?: MoboBrokerResource[];
}

/**
 * Managed-On-Behalf-Of broker resource. This resource is created by the Resource Provider to manage some resources on behalf of the user.
 */
model MoboBrokerResource {
  /**
   * Resource identifier of a Managed-On-Behalf-Of broker resource
   */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * List of contracts.
 */
model ContractsList is Azure.Core.Page<Contract>;

/**
 * List of contracts.
 */
model ConsortiumViewContractsList is Azure.Core.Page<ConsortiumViewContract>;

/**
 * Defines the resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ContractProperties {
  /**
   * Gets or sets the contract Id.
   */
  @visibility(Lifecycle.Read)
  contractId: string;

  /**
   * Gets or sets the deployment policy.
   */
  @visibility(Lifecycle.Read)
  deploymentPolicy?: string;

  /**
   * Gets or sets the deployment template.
   */
  @visibility(Lifecycle.Read)
  deploymentTemplate?: string;
}
