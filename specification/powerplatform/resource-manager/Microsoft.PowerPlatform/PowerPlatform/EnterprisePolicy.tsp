import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PowerPlatform;
/**
 * Definition of the EnterprisePolicy.
 */
model EnterprisePolicy is Azure.ResourceManager.TrackedResource<Properties> {
  ...ResourceNameParameter<
    Resource = EnterprisePolicy,
    KeyName = "enterprisePolicyName",
    SegmentName = "enterprisePolicies",
    NamePattern = ""
  >;

  /**
   * The identity of the EnterprisePolicy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: EnterprisePolicyIdentity;

  /**
   * The kind (type) of Enterprise Policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind: EnterprisePolicyKind;
}

@armResourceOperations
interface EnterprisePolicies {
  /**
   * Get information about an EnterprisePolicy
   */
  get is ArmResourceRead<EnterprisePolicy>;

  /**
   * Creates an EnterprisePolicy
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<EnterprisePolicy>;

  /**
   * Updates an EnterprisePolicy
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    EnterprisePolicy,
    PatchModel = PatchEnterprisePolicy
  >;

  /**
   * Delete an EnterprisePolicy
   */
  delete is ArmResourceDeleteSync<EnterprisePolicy>;

  /**
   * Retrieve a list of EnterprisePolicies within a given resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    EnterprisePolicy,
    Response = ArmResponse<EnterprisePolicyList>
  >;

  /**
   * Retrieve a list of EnterprisePolicies within a subscription
   */
  listBySubscription is ArmListBySubscription<
    EnterprisePolicy,
    Response = ArmResponse<EnterprisePolicyList>
  >;
}

@@doc(EnterprisePolicy.name, "The EnterprisePolicy name.");
@@doc(EnterprisePolicy.properties,
  "The properties that define configuration for the enterprise policy"
);
@@doc(EnterprisePolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update EnterprisePolicy."
);
@@doc(EnterprisePolicies.update::parameters.properties,
  "Parameters supplied to update EnterprisePolicy."
);
