import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AlertsManagement;
/**
 * The Prometheus rule group resource.
 */
model PrometheusRuleGroupResource
  is Azure.ResourceManager.TrackedResource<
    PrometheusRuleGroupProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = PrometheusRuleGroupResource,
    KeyName = "ruleGroupName",
    SegmentName = "prometheusRuleGroups",
    NamePattern = "^[^:@/#{}%&+*<>?]+$"
  >;
}

@armResourceOperations
interface PrometheusRuleGroupResources {
  /**
   * Retrieve a Prometheus rule group definition.
   */
  get is ArmResourceRead<PrometheusRuleGroupResource>;

  /**
   * Create or update a Prometheus rule group definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrometheusRuleGroupResource>;

  /**
   * Update an Prometheus rule group definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PrometheusRuleGroupResource,
    PatchModel = PrometheusRuleGroupResourcePatchParameters
  >;

  /**
   * Delete a Prometheus rule group definition.
   */
  delete is ArmResourceDeleteSync<PrometheusRuleGroupResource>;

  /**
   * Retrieve Prometheus rule group definitions in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    PrometheusRuleGroupResource,
    Response = ArmResponse<PrometheusRuleGroupResourceCollection>
  >;

  /**
   * Retrieve Prometheus all rule group definitions in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    PrometheusRuleGroupResource,
    Response = ArmResponse<PrometheusRuleGroupResourceCollection>
  >;
}

@@doc(PrometheusRuleGroupResource.name, "The name of the rule group.");
@@doc(PrometheusRuleGroupResource.properties,
  "The Prometheus rule group properties of the resource."
);
@@doc(PrometheusRuleGroupResources.createOrUpdate::parameters.resource,
  "The parameters of the rule group to create or update."
);
@@doc(PrometheusRuleGroupResources.update::parameters.properties,
  "The parameters of the rule group to update."
);
