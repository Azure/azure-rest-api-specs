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

alias virtualMachineExternalResource = Extension.ExternalResource<
  "Microsoft.Compute",
  "virtualMachines",
  "{virtualMachineName}"
>;

@armResourceOperations
interface ReplicationEligibilityResultsOperationGroup {
  /**
   * Validates whether a given VM can be protected or not in which case returns list of errors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ReplicationEligibilityResults_Get")
  @summary("Validates whether a given VM can be protected or not in which case returns list of errors.")
  get is ArmResourceRead<ReplicationEligibilityResults>;

  // /**
  //  * Validates whether a given VM can be protected or not in which case returns list of errors.
  //  */
  // #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  // @operationId("ReplicationEligibilityResults_List")
  // list is ArmResourceListByParent<
  //   ReplicationEligibilityResults,
  //   virtualMachineExternalResource,
  //   Response = ArmResponse<ReplicationEligibilityResultsCollection>
  // >;
}

@@doc(ReplicationEligibilityResults.name, "");
@@doc(ReplicationEligibilityResults.properties,
  "Gets properties model for replication eligibility results API."
);
