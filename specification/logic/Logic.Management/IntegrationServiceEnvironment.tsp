import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration service environment.")
@subscriptionResource
model IntegrationServiceEnvironment
  is Azure.ResourceManager.TrackedResource<IntegrationServiceEnvironmentProperties> {
  ...ResourceNameParameter<
    Resource = IntegrationServiceEnvironment,
    KeyName = "integrationServiceEnvironmentName",
    SegmentName = "integrationServiceEnvironments",
    NamePattern = ""
  >;

  @doc("The sku.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: IntegrationServiceEnvironmentSku;

  @doc("Managed service identity properties.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface IntegrationServiceEnvironments {
  @doc("Gets an integration service environment.")
  get is ArmResourceRead<
    IntegrationServiceEnvironment,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  @doc("Creates or updates an integration service environment.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IntegrationServiceEnvironment,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Updates an integration service environment.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    IntegrationServiceEnvironment,
    PatchModel = IntegrationServiceEnvironment,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<IntegrationServiceEnvironment>
  >;

  @doc("Deletes an integration service environment.")
  delete is ArmResourceDeleteSync<
    IntegrationServiceEnvironment,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  @doc("Gets a list of integration service environments by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationServiceEnvironment,
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Gets a list of integration service environments by subscription.")
  listBySubscription is ArmListBySubscription<
    IntegrationServiceEnvironment,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Restarts an integration service environment.")
  restart is ArmResourceActionSync<
    IntegrationServiceEnvironment,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  @doc("Gets a list of integration service environment Skus.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("IntegrationServiceEnvironmentSkus_List")
  list is ArmResourceActionSync<
    IntegrationServiceEnvironment,
    void,
    ArmResponse<IntegrationServiceEnvironmentSkuList>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  @doc("Gets the integration service environment network health.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("network")
  @operationId("IntegrationServiceEnvironmentNetworkHealth_Get")
  integrationServiceEnvironmentNetworkHealthGet is ArmResourceActionSync<
    IntegrationServiceEnvironment,
    void,
    ArmResponse<IntegrationServiceEnvironmentNetworkHealth>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(IntegrationServiceEnvironment.name,
  "The integration service environment name."
);
@@doc(IntegrationServiceEnvironment.properties,
  "The integration service environment properties."
);
@@doc(IntegrationServiceEnvironments.createOrUpdate::parameters.resource,
  "The integration service environment."
);
@@doc(IntegrationServiceEnvironments.update::parameters.properties,
  "The integration service environment."
);
