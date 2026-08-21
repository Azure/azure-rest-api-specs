import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NeuroShield.tsp";
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
interface NeuroShieldProtectedResources {
  /**
   * Gets a protected resource under a NeuroShield resource.
   */
  @summary("Gets a protected resource under a NeuroShield resource.")
  get is ArmResourceRead<
    NeuroShieldProtectedResource,
    Response = ArmResponse<NeuroShieldProtectedResource> &
      Azure.Core.EtagResponseEnvelope,
    Error = CloudError
  >;

  /**
   * Creates or updates a protected resource under a NeuroShield resource.
   */
  @summary("Creates or updates a protected resource under a NeuroShield resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NeuroShieldProtectedResource,
    Error = CloudError
  >;

  /**
   * Deletes a protected resource under a NeuroShield resource.
   */
  @summary("Deletes a protected resource under a NeuroShield resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NeuroShieldProtectedResource,
    Error = CloudError
  >;

  /**
   * Lists all protected resources under a NeuroShield resource.
   */
  @summary("Lists all protected resources under a NeuroShield resource.")
  list is ArmResourceListByParent<
    NeuroShieldProtectedResource,
    Error = CloudError
  >;
}

@@doc(NeuroShieldProtectedResource.name, "The name of the protected resource.");
@@doc(
  NeuroShieldProtectedResource.properties,
  "Properties of the protected resource."
);
@@doc(
  NeuroShieldProtectedResources.createOrUpdate::parameters.resource,
  "The create or update request body for a protected resource."
);
