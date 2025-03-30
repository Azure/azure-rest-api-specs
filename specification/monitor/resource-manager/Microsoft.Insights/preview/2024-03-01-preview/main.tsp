import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{
  title: "MetricAlertClient",
  version: "2024-03-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Insights;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface MetricAlerts {
  @doc("Retrieve an alert rule definition.")
  get is ArmResourceRead<MetricAlertResource>;

  @doc("Create or update an alert rule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MetricAlertResource>;

  @doc("Update an alert rule. Only tags, enabled, and actions fields can be updated.")
  @armResourceUpdate(MetricAlertResource)
  patch is ArmResourcePatchSync<MetricAlertResource, MetricAlertResourcePatch>;

  @doc("Delete an alert rule.")
  delete is ArmResourceDeleteSync<MetricAlertResource>;

  @doc("Retrieve alert rule definitions in a resource group.")
  listByResourceGroup is ArmResourceListByParent<MetricAlertResource>;

  @doc("Retrieve alert rule definitions in a subscription.")
  listBySubscription is ArmListBySubscription<MetricAlertResource>;
}
