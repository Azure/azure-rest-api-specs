import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
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
interface IoTSecuritySolutionModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("User this method to get details of a specific IoT Security solution based on solution name")
  @operationId("IotSecuritySolution_Get")
  get is ArmResourceRead<IoTSecuritySolutionModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to create or update yours IoT Security solution")
  @operationId("IotSecuritySolution_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IoTSecuritySolutionModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to update existing IoT Security solution tags or user defined resources. To update other fields use the CreateOrUpdate method.")
  @operationId("IotSecuritySolution_Update")
  update is ArmCustomPatchSync<
    IoTSecuritySolutionModel,
    UpdateIotSecuritySolutionData
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to delete yours IoT Security solution")
  @operationId("IotSecuritySolution_Delete")
  delete is ArmResourceDeleteSync<IoTSecuritySolutionModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get the list IoT Security solutions organized by resource group.")
  @operationId("IotSecuritySolution_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    IoTSecuritySolutionModel,
    {
      ...BaseParameters<IoTSecuritySolutionModel>;

      @doc("Filter the IoT Security solution with OData syntax. Supports filtering by iotHubs.")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get the list of IoT Security solutions by subscription.")
  @operationId("IotSecuritySolution_ListBySubscription")
  listBySubscription is ArmListBySubscription<IoTSecuritySolutionModel>;
}

@@projectedName(IoTSecuritySolutionModels.createOrUpdate::parameters.resource,
  "json",
  "iotSecuritySolutionData"
);
@@extension(IoTSecuritySolutionModels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iotSecuritySolutionData"
);
@@doc(IoTSecuritySolutionModels.createOrUpdate::parameters.resource,
  "The security solution data"
);
@@projectedName(IoTSecuritySolutionModels.update::parameters.properties,
  "json",
  "updateIotSecuritySolutionData"
);
@@extension(IoTSecuritySolutionModels.update::parameters.properties,
  "x-ms-client-name",
  "updateIotSecuritySolutionData"
);
@@doc(IoTSecuritySolutionModels.update::parameters.properties,
  "The security solution data"
);
