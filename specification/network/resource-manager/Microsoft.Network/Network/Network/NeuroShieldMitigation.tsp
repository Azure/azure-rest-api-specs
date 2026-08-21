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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Microsoft.Network/Network currently uses Azure.ResourceManager.Legacy templates to keep a single generated swagger surface across tags; NeuroShield 2026-01-01 follows this project-wide convention."
@added(Versions.v2026_01_01)
@Azure.ResourceManager.Legacy.feature(Features.neuroShield)
@armResourceOperations
interface NeuroShieldMitigations {
  /**
   * Gets a mitigation under a protected resource.
   */
  @summary("Gets a mitigation under a protected resource.")
  get is ArmResourceRead<
    NeuroShieldMitigation,
    Response = ArmResponse<NeuroShieldMitigation> &
      Azure.Core.EtagResponseEnvelope,
    Error = CloudError
  >;

  /**
   * Lists mitigations under a protected resource.
   */
  @summary("Lists mitigations under a protected resource.")
  list is ArmResourceListByParent<NeuroShieldMitigation, Error = CloudError>;

  /**
   * Approves and queues a mitigation for execution.
   */
  @summary("Approves and queues a mitigation for execution.")
  @action("execute")
  execute is ArmResourceActionAsync<
    NeuroShieldMitigation,
    void,
    Response = {
      @body body: void;
    },
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Cancels a mitigation.
   */
  @summary("Cancels a mitigation.")
  @action("cancel")
  cancel is ArmResourceActionAsync<
    NeuroShieldMitigation,
    void,
    Response = {
      @body body: void;
    },
    Error = CloudError,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Rolls back a mitigation when rollback is available.
   */
  @summary("Rolls back a mitigation when rollback is available.")
  @action("rollback")
  rollback is ArmResourceActionAsync<
    NeuroShieldMitigation,
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
  NeuroShieldMitigation.name,
  "The system-generated identifier of the mitigation."
);
@@doc(
  NeuroShieldMitigation.properties,
  "Properties of the mitigation resource."
);
