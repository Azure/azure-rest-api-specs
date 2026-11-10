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

@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface NeuroShieldMitigations
  extends NeuroShieldMitigationOperations<NeuroShieldMitigation> {}

/** Operations shared by the version-specific mitigation resource envelopes. */
interface NeuroShieldMitigationOperations<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  /**
   * Gets a mitigation under a protected resource.
   */
  @summary("Get a mitigation")
  @sharedRoute
  get is ArmResourceRead<
    Resource,
    Response = ArmResponse<Resource> & Azure.Core.EtagResponseEnvelope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists mitigations under a protected resource.
   */
  @summary("List mitigations")
  @sharedRoute
  list is ArmResourceListByParent<
    Resource,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists mitigations across all protected resources under a NeuroShield resource.
   */
  @summary("List mitigations by NeuroShield")
  @sharedRoute
  @list
  @get
  @action("mitigations")
  listByNeuroShield is ArmResourceActionSync<
    NeuroShieldResource,
    void,
    ArmResponse<ResourceListResult<Resource>>,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Approves and queues a mitigation for execution.
   */
  @summary("Execute a mitigation")
  @sharedRoute
  @action("execute")
  execute is ArmResourceActionSync<
    Resource,
    void,
    ArmResponse<Resource>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Rolls back a mitigation when rollback is available.
   */
  @summary("Roll back a mitigation")
  @sharedRoute
  @action("rollback")
  rollback is ArmResourceActionSync<
    Resource,
    void,
    ArmResponse<Resource>,
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
