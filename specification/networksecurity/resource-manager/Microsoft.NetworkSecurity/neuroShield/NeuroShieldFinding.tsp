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
interface NeuroShieldFindings
  extends NeuroShieldFindingOperations<NeuroShieldFinding> {}

/** Operations shared by the version-specific finding resource envelopes. */
interface NeuroShieldFindingOperations<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  /**
   * Gets a finding under a protected resource.
   */
  @summary("Get a finding")
  @sharedRoute
  get is ArmResourceRead<
    Resource,
    Response = ArmResponse<Resource> & Azure.Core.EtagResponseEnvelope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists findings under a protected resource.
   */
  @summary("List findings")
  @sharedRoute
  list is ArmResourceListByParent<
    Resource,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Lists findings across all protected resources under a NeuroShield resource.
   */
  @summary("List findings by NeuroShield")
  @sharedRoute
  @list
  @get
  @action("findings")
  listByNeuroShield is ArmResourceActionSync<
    NeuroShieldResource,
    void,
    ArmResponse<ResourceListResult<Resource>>,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Triggers mitigation for all awaiting-approval mitigations under a finding.
   */
  @summary("Mitigate a finding")
  @sharedRoute
  @action("mitigate")
  mitigate is ArmResourceActionSync<
    Resource,
    void,
    ArmResponse<NeuroShieldMitigationActionResult>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Rolls back succeeded rollbackable mitigations under a finding.
   */
  @summary("Roll back mitigations for a finding")
  @sharedRoute
  @action("rollback")
  rollback is ArmResourceActionSync<
    Resource,
    void,
    ArmResponse<NeuroShieldMitigationActionResult>,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;
}

@@doc(
  NeuroShieldFinding.name,
  "The system-generated identifier of the finding."
);
@@doc(NeuroShieldFinding.properties, "Properties of the finding resource.");
