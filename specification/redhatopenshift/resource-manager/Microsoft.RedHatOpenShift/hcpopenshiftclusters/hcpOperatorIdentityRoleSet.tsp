import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

namespace Microsoft.RedHatOpenShift;

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

/** HcpOperatorIdentityRoles represents a location based representation of
 * the required platform workload identities and their required roles for a given
 * OpenShift version
 */
@parentResource(SubscriptionLocationResource)
model HcpOperatorIdentityRoleSet
  is ProxyResource<HcpOperatorIdentityRoleSetProperties> {
  ...ResourceNameParameter<
    HcpOperatorIdentityRoleSet,
    NamePattern = "^[a-zA-Z0-9-\\.]{3,24}$"
  >;
}
@@doc(
  HcpOperatorIdentityRoleSet.name,
  "The OpenShift minor version these identities are required for."
);

/** HCP Operator Identity Roles properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Proxy resource does not have provisioning state"
model HcpOperatorIdentityRoleSetProperties {
  /** The role definitions required for the User-Assigned managed identities used
   * by Control Plane operators on a cluster. */
  @identifiers(#["name"])
  controlPlaneOperators: OperatorIdentityRoles[];

  /** The role definitions required for the User-Assigned managed identities used
   * by Data Plane operators on a cluster. */
  @identifiers(#["name"])
  dataPlaneOperators: OperatorIdentityRoles[];
}

/** Role definitions for a specific operator */
model OperatorIdentityRoles {
  /** Name of the operator */
  name: string;

  /** Whether or not the operator is required for installation */
  required: OperatorIdentityRequired;

  /** The role definitions required to be assigned to the identity assumed by this operator */
  @identifiers(#["name"])
  roleDefinitions: RoleDefinition[];
}

/** Indicates if the identity is required */
union OperatorIdentityRequired {
  string,

  /** Indicates the identity is always required. */
  "Always",

  /** Indicates the identity is only required when a functionality that leverages the operator is enabled. */
  "OnEnablement",
}

/** A single role definition required by a given operator */
@clientName("RoleDefinitionInfo", "csharp")
model RoleDefinition {
  /** The name of the required role definition */
  name: string;

  /** The resource ID of the role definition */
  resourceId: RoleDefinitionResourceId;
}

scalar RoleDefinitionResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/roleDefinitions",
      scopes: ["Tenant"],
    }
  ]>;

@armResourceOperations(HcpOperatorIdentityRoleSet)
interface HcpOperatorIdentityRoleSets {
  list is ArmResourceListByParent<HcpOperatorIdentityRoleSet>;
  get is ArmResourceRead<HcpOperatorIdentityRoleSet>;
}
