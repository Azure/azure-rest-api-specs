import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NeuroShieldProtectedResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace NeuroShield.Management;

@added(Versions.v2026_06_01_preview)
@armResourceOperations
interface NeuroShieldMitigations {
  /**
   * Gets a mitigation under a protected resource.
   */
  @summary("Get a mitigation")
  get is ArmResourceRead<
    NeuroShieldMitigation,
    Response = ArmResponse<NeuroShieldMitigation> &
      Azure.Core.EtagResponseEnvelope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists mitigations under a protected resource.
   */
  @summary("List mitigations")
  list is ArmResourceListByParent<
    NeuroShieldMitigation,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists mitigations across all protected resources under a NeuroShield resource.
   */
  @summary("List mitigations by NeuroShield")
  @list
  @get
  @action("mitigations")
  listByNeuroShield is ArmResourceActionSync<
    NeuroShieldResource,
    void,
    ArmResponse<ResourceListResult<NeuroShieldMitigation>>,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Approves and queues a mitigation for execution.
   */
  @summary("Execute a mitigation")
  @action("execute")
  execute is ArmResourceActionSync<
    NeuroShieldMitigation,
    void,
    ArmResponse<NeuroShieldMitigation>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Rolls back a mitigation when rollback is available.
   */
  @summary("Roll back a mitigation")
  @action("rollback")
  rollback is ArmResourceActionSync<
    NeuroShieldMitigation,
    void,
    ArmResponse<NeuroShieldMitigation>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
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
