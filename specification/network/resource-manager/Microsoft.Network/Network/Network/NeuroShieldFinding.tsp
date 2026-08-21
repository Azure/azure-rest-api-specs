import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NeuroShieldProtectedResource.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Microsoft.Network/Network currently uses Azure.ResourceManager.Legacy templates to keep a single generated swagger surface across tags; NeuroShield 2026-06-01-preview follows this project-wide convention."
@added(Versions.v2026_06_01_preview)
@Azure.ResourceManager.Legacy.feature(Features.neuroShield)
@armResourceOperations
interface NeuroShieldFindings {
  /**
   * Gets a finding under a protected resource.
   */
  @summary("Gets a finding under a protected resource.")
  get is ArmResourceRead<
    NeuroShieldFinding,
    Response = ArmResponse<NeuroShieldFinding> &
      Azure.Core.EtagResponseEnvelope,
    Error = CloudError
  >;

  /**
   * Lists findings under a protected resource.
   */
  @summary("Lists findings under a protected resource.")
  list is ArmResourceListByParent<NeuroShieldFinding, Error = CloudError>;

  /**
   * Triggers mitigation for all awaiting-approval mitigations under a finding.
   */
  @summary("Triggers mitigation for all awaiting-approval mitigations under a finding.")
  @action("mitigate")
  mitigate is ArmResourceActionAsync<
    NeuroShieldFinding,
    void,
    Response = {
      @body body: void;
    },
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Rolls back succeeded rollbackable mitigations under a finding.
   */
  @summary("Rolls back succeeded rollbackable mitigations under a finding.")
  @action("rollback")
  rollback is ArmResourceActionAsync<
    NeuroShieldFinding,
    void,
    Response = {
      @body body: void;
    },
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(
  NeuroShieldFinding.name,
  "The system-generated identifier of the finding."
);
@@doc(NeuroShieldFinding.properties, "Properties of the finding resource.");
