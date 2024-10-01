import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.Portal;
/**
 * The shared dashboard resource definition.
 */
@doc("The shared dashboard resource definition.")
model Dashboard
  is Azure.ResourceManager.TrackedResource<DashboardPropertiesWithProvisioningState> {
  ...ResourceNameParameter<Resource = Dashboard>;
}

@armResourceOperations
interface Dashboards {
  /**
   * Gets the Dashboard.
   */
  get is ArmResourceRead<Dashboard>;

  /**
   * Creates or updates a Dashboard.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Dashboard>;

  /**
   * Updates an existing Dashboard.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Dashboard, PatchableDashboard>;

  /**
   * Deletes the Dashboard.
   */
  delete is ArmResourceDeleteSync<Dashboard>;

  /**
   * Gets all the Dashboards within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Dashboard>;

  /**
   * Gets all the dashboards within a subscription.
   */
  listBySubscription is ArmListBySubscription<Dashboard>;
}

@@maxLength(Dashboard.name, 64);
@@minLength(Dashboard.name, 3);
@@doc(Dashboard.name, "The name of the dashboard.");
@@doc(Dashboards.createOrUpdate::parameters.resource,
  "The parameters required to create or update a dashboard."
);
@@doc(Dashboards.update::parameters.properties,
  "The updatable fields of a Dashboard."
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Dashboards.createOrUpdate::parameters.resource,
  "application/json",
  "dashboard"
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Dashboards.update::parameters.properties,
  "application/json",
  "dashboard"
);
