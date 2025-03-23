import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";
import "./examples.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "MetricAlertClient",
  version: "2024-03-01-preview"
})
namespace Microsoft.Insights;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface MetricAlerts {
  @doc("Retrieve an alert rule definition.")
  get is Azure.ResourceManager.Operations.GetByName<MetricAlertResource>;

  @doc("Create or update an alert rule.")
  createOrUpdate is Azure.ResourceManager.Operations.CreateOrUpdateByName<MetricAlertResource>;

  @doc("Update an alert rule. Only tags, enabled, and actions fields can be updated.")
  @armResourceUpdate(MetricAlertResource)
  patch is Azure.ResourceManager.Operations.PatchByName<
    MetricAlertResource,
    MetricAlertResourcePatch
  >;

  @doc("Delete an alert rule.")
  delete is Azure.ResourceManager.Operations.DeleteByName<MetricAlertResource>;

  @doc("Retrieve alert rule definitions in a resource group.")
  listByResourceGroup is Azure.ResourceManager.Operations.ListByParent<MetricAlertResource>;

  @doc("Retrieve alert rule definitions in a subscription.")
  listBySubscription is Azure.ResourceManager.Operations.ListBySubscription<MetricAlertResource>;
}
