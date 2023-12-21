import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("IoT Security solution configuration and resource information.")
model IoTSecuritySolutionModel
  is TrackedResource<IoTSecuritySolutionProperties> {
  @doc("The name of the IoT Security solution.")
  @path
  @key("solutionName")
  @segment("iotSecuritySolutions")
  name: string;
}

@armResourceOperations
interface IotSecuritySolution {
  @doc("User this method to get details of a specific IoT Security solution based on solution name")
  get is ArmResourceRead<IoTSecuritySolutionModel>;
  @doc("Use this method to create or update yours IoT Security solution")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IoTSecuritySolutionModel>;
  @doc("Use this method to update existing IoT Security solution tags or user defined resources. To update other fields use the CreateOrUpdate method.")
  update is ArmResourcePatchSync<
    IoTSecuritySolutionModel,
    IoTSecuritySolutionProperties
  >;
  @doc("Use this method to delete yours IoT Security solution")
  delete is ArmResourceDeleteSync<IoTSecuritySolutionModel>;
  @doc("Use this method to get the list IoT Security solutions organized by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    IoTSecuritySolutionModel,
    {
      ...BaseParameters<IoTSecuritySolutionModel>;

      @doc("Filter the IoT Security solution with OData syntax. Supports filtering by iotHubs.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Use this method to get the list of IoT Security solutions by subscription.")
  listBySubscription is ArmListBySubscription<IoTSecuritySolutionModel>;
}
