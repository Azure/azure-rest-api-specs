import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Replication eligibility results response model.
 */
@singleton("default")
model ReplicationEligibilityResults
  is Azure.ResourceManager.ProxyResource<ReplicationEligibilityResultsProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationEligibilityResults,
    KeyName = "replicationEligibilityResult",
    SegmentName = "replicationEligibilityResults",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationEligibilityResultsParentParam {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** Virtual Machine name. */
  @path
  @segment("providers/microsoft.Compute/virtualMachines")
  virtualMachineName: string;
}

@armResourceOperations
interface ReplicationEligibilityResultsOperationGroup {
  /**
   * Validates whether a given VM can be protected or not in which case returns list of errors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the validation errors in case the VM is unsuitable for protection.")
  get is ArmResourceRead<
    ReplicationEligibilityResults,
    BaseParameters = ReplicationEligibilityResultsParentParam,
    Error = never
  >;

  /**
   * Validates whether a given VM can be protected or not in which case returns list of errors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the validation errors in case the VM is unsuitable for protection.")
  list is ArmResourceListByParent<
    ReplicationEligibilityResults,
    BaseParameters = ReplicationEligibilityResultsParentParam,
    Response = ArmResponse<ReplicationEligibilityResultsCollection>,
    Error = never
  >;
}

@@doc(ReplicationEligibilityResults.name, "");
@@doc(ReplicationEligibilityResults.properties,
  "Gets properties model for replication eligibility results API."
);
