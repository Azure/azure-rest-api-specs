import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RedHatOpenShift;
/**
 * PlatformWorkloadIdentityRoleSet represents a mapping from the names of OCP operators to the built-in roles that should be assigned to those operator's corresponding managed identities for a particular OCP version.
 */
@subscriptionResource
model PlatformWorkloadIdentityRoleSet
  is Azure.ResourceManager.ProxyResource<PlatformWorkloadIdentityRoleSetProperties> {
  ...ResourceNameParameter<
    Resource = PlatformWorkloadIdentityRoleSet,
    KeyName = "openShiftMinorVersion",
    SegmentName = "platformWorkloadIdentityRoleSets",
    NamePattern = "^(\\d+)\\.(\\d+)"
  >;
}

alias PlatformWorkloadIdentityRoleSetsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
    ...LocationResourceParameter;
  },
  {
    /** The desired version value of the PlatformWorkloadIdentityRoleSet resource. */
    @path
    @segment("platformWorkloadIdentityRoleSets")
    @key
    @pattern("^(\\d+)\\.(\\d+)")
    @minLength(1)
    @maxLength(63)
    openShiftMinorVersion: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface PlatformWorkloadIdentityRoleSets {
  /**
   * This operation returns Platform Workload Identity Role Set as a string
   */
  @summary("Gets a mapping of an OpenShift version to identity requirements, which includes operatorName, roleDefinitionName, roleDefinitionId, and serviceAccounts.")
  get is PlatformWorkloadIdentityRoleSetsOps.Read<PlatformWorkloadIdentityRoleSet>;

  /**
   * This operation returns a list of Platform Workload Identity Role Sets as a string
   */
  @summary("Lists a mapping of OpenShift versions to identity requirements, which include operatorName, roleDefinitionName, roleDefinitionId, and serviceAccounts.")
  list is PlatformWorkloadIdentityRoleSetsOps.List<
    PlatformWorkloadIdentityRoleSet,
    Response = ArmResponse<PlatformWorkloadIdentityRoleSetList>
  >;
}

@@maxLength(PlatformWorkloadIdentityRoleSet.name, 63);
@@minLength(PlatformWorkloadIdentityRoleSet.name, 1);
@@doc(PlatformWorkloadIdentityRoleSet.name,
  "The desired version value of the PlatformWorkloadIdentityRoleSet resource."
);
@@doc(PlatformWorkloadIdentityRoleSet.properties,
  "The properties for the PlatformWorkloadIdentityRoleSet resource."
);
