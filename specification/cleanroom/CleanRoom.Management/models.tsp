import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CleanRoom;

/**
 * Provisioning states.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
union CollaborationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CleanRoom: "CleanRoom",
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
  consortiumEndpoint: string;

  /**
   * Gets or sets the CCF public service certificate in PEM format.
   */
  consortiumServiceCertificatePem: string;

  /**
   * Gets or sets the collaboration member.
   */
  member: CollaborationMember;

  /**
   * Gets or sets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Configuration details of the collaboration members.
 */
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
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
  @OpenAPI.extension("x-ms-identifiers", #["id"])
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
