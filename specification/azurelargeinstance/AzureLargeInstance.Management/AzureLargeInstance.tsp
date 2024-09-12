import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureLargeInstance;
@doc("""
  Azure Large Instance info on Azure (ARM properties and AzureLargeInstance
  properties)
  """)
model AzureLargeInstance is TrackedResource<AzureLargeInstanceProperties> {
  @doc("Name of the AzureLargeInstance.")
  @pattern(".*")
  @path
  @key("azureLargeInstanceName")
  @segment("azureLargeInstances")
  name: string;
}

@armResourceOperations
@clientName("AzureLargeInstance")
interface AzureLargeInstances {
  @doc("""
    Gets an Azure Large Instance for the specified subscription, resource group,
    and instance name.
    """)
  get is ArmResourceRead<AzureLargeInstance>;

  @added(Versions.v2024_08_01_preview)
  @doc("""
    Creates an Azure Large Instance for the specified subscription,
    resource group, and instance name.
    """)
  create is ArmResourceCreateOrReplaceSync<AzureLargeInstance>;

  @added(Versions.v2024_08_01_preview)
  @armResourceDelete(AzureLargeInstance)
  @doc("""
    Deletes an Azure Large Instance for the specified subscription, resource group,
    and instance name.
    """)
  delete is ArmResourceDeleteSync<AzureLargeInstance>;

  @doc("""
    Patches the Tags field of an Azure Large Instance for the specified
    subscription, resource group, and instance name.
    """)
  update is ArmCustomPatchSync<AzureLargeInstance>;

  @doc("""
    Gets a list of Azure Large Instances in the specified subscription and resource
    group. The operations returns various properties of each Azure Large Instance.
    """)
  listByResourceGroup is ArmResourceListByParent<AzureLargeInstance>;

  @doc("""
    Gets a list of Azure Large Instances in the specified subscription. The
    operations returns various properties of each Azure Large Instance.
    """)
  listBySubscription is ArmListBySubscription<AzureLargeInstance>;

  @doc("The operation to start an Azure Large Instance (only for compute instances)")
  start is ArmResourceActionAsync<
    AzureLargeInstance,
    void,
    Foundations.OperationStatusResult
  >;

  @doc("The operation to restart an Azure Large Instance (only for compute instances)")
  restart is ArmResourceActionNoBody<
    AzureLargeInstance,
    {
      /** When set to 'active', this parameter empowers the server with the ability to forcefully terminate and halt any existing processes that may be running on the server */
      @bodyRoot forceParameter?: ForceState;
    },
    Foundations.OperationStatusResult
  >;

  @doc("The operation to shutdown an Azure Large Instance (only for compute instances)")
  shutdown is ArmResourceActionAsync<
    AzureLargeInstance,
    void,
    Foundations.OperationStatusResult
  >;
}

/**
 * A long-running resource action.
 * @template TResource The resource being acted upon
 * @template TRequest The request model for the action
 * @template TResponse The response type for the action
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template for optional body"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - migrate to LRO apis"
@autoRoute
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionNoBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TRequest extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model | void,
  TBaseParameters extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.BaseParameters<AzureLargeInstance>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
  ...TRequest,
): ArmAcceptedLroResponse | TResponse | ErrorResponse;
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(AzureLargeInstances.update::parameters.properties,
  "application/json",
  "tagsParameter"
);

// model ForceParameter {
//   /** When set to 'active', this parameter empowers the server with the ability to forcefully terminate and halt any existing processes that may be running on the server */
//   forceParameter?: ForceState;
// }
