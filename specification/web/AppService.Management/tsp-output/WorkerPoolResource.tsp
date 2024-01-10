import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Worker pool of an App Service Environment ARM resource.")
@singleton("default")
@parentResource(AppServiceEnvironmentResource)
model WorkerPoolResource is ProxyResource<WorkerPool> {
  @key("multiRolePool")
  @segment("multiRolePools")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "AppServiceEnvironments")
interface WorkerPoolResources_AppServiceEnvironments {
  @doc("Description for Get properties of a multi-role pool.")
  getMultiRolePool is ArmResourceRead<WorkerPoolResource>;

  @doc("Description for Create or update a multi-role pool.")
  createOrUpdateMultiRolePool is ArmResourceCreateOrUpdateAsync<WorkerPoolResource>;

  @doc("Description for Create or update a multi-role pool.")
  updateMultiRolePool is ArmCustomPatchSync<
    WorkerPoolResource,
    WorkerPoolResource
  >;

  @doc("Description for Get all multi-role pools.")
  listMultiRolePools is ArmResourceListByParent<WorkerPoolResource>;

  @summary("Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.")
  @doc("Description for Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListMultiRolePoolInstanceMetricDefinitions could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/instances/{instance}/metricdefinitions")
  @get
  ListMultiRolePoolInstanceMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Name of the instance in the multi-role pool.")
      @path
      instance: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  @summary("Get metric definitions for a multi-role pool of an App Service Environment.")
  @doc("Description for Get metric definitions for a multi-role pool of an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListMultiRoleMetricDefinitions could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/metricdefinitions")
  @get
  ListMultiRoleMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  @summary("Get available SKUs for scaling a multi-role pool.")
  @doc("Description for Get available SKUs for scaling a multi-role pool.")
  // FIXME: AppServiceEnvironments_ListMultiRolePoolSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/skus")
  @get
  ListMultiRolePoolSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SkuInfoCollection
  >;

  @summary("Get usage metrics for a multi-role pool of an App Service Environment.")
  @doc("Description for Get usage metrics for a multi-role pool of an App Service Environment.")
  // FIXME: AppServiceEnvironments_ListMultiRoleUsages could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/usages")
  @get
  ListMultiRoleUsages is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service Environment.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    UsageCollection
  >;
}
