import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Information protection policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model InformationProtectionPolicy
  is Azure.ResourceManager.ExtensionResource<InformationProtectionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = InformationProtectionPolicy,
    KeyName = "informationProtectionPolicyName",
    SegmentName = "informationProtectionPolicies",
    NamePattern = "",
    Type = InformationProtectionPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface InformationProtectionPolicies {
  /**
   * Details of the information protection policy.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    InformationProtectionPolicy,
    Error = CloudError
  >;

  /**
   * Details of the information protection policy.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    InformationProtectionPolicy,
    Error = CloudError
  >;

  /**
   * Information protection policies of a specific management group.
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    InformationProtectionPolicy,
    Response = ArmResponse<InformationProtectionPolicyList>,
    Error = CloudError
  >;
}

@@doc(InformationProtectionPolicy.name,
  "Name of the information protection policy."
);
@@doc(InformationProtectionPolicy.properties,
  "Information protection policy data"
);
@@doc(InformationProtectionPolicies.createOrUpdate::parameters.resource,
  "Information protection policy."
);
