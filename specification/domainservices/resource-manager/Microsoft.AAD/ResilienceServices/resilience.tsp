import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AAD;

/** Resilience resource */
model ResilienceService is TrackedResource<ResilienceProperties> {
  ...ResourceNameParameter<ResilienceService>;
}

/** Resilience properties */
model ResilienceProperties {
  /** The Azure Resource Manager (ARM) resource ID of the Azure Arc instance linked to the resilience service */
  arcResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
      scopes: ["Tenant"];
    }
  ]>;

  /** Tenant ID */
  @visibility(Lifecycle.Read)
  tenantId: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

/** A policy enforced in the tenant where the resilience service resides */
model Policy {
  /** The unique identifier of the policy */
  id: string;

  /** The definitions of the policy */
  definition: string[];

  /** The description of the policy */
  description: string;

  /** The display name of the policy */
  displayName: string;

  /** Indicates if the policy is the organization default */
  isOrganizationDefault: boolean;

  /** The date and time when the policy was deleted */
  deletedDateTime?: utcDateTime;
}

/** The response containing the policies enforced in the tenant where the resilience service resides */
model ResilienceServicePolicyResponse {
  /** The list of multi conditional access policies */
  multiConditionalAccessPolicies: Policy[];

  /** The list of user credential policies */
  userCredentialPolicies: Policy[];

  /** The list of security risk policies */
  securityRiskPolicies: Policy[];

  /** The list of authentication strength policies */
  authenticationStrengthPolicies: Policy[];
}

@armResourceOperations
interface ResilienceServices {
  get is ArmResourceRead<ResilienceService>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ResilienceService>;
  update is ArmCustomPatchSync<
    ResilienceService,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ResilienceService,
      ResilienceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ResilienceService>;
  listByResourceGroup is ArmResourceListByParent<ResilienceService>;
  listBySubscription is ArmListBySubscription<ResilienceService>;
  syncPolicies is ArmResourceActionSync<
    ResilienceService,
    void,
    ResilienceServicePolicyResponse
  >;
}
