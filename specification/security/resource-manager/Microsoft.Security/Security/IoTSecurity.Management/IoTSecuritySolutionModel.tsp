import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * IoT Security solution configuration and resource information.
 */
model IoTSecuritySolutionModel
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<IoTSecuritySolutionProperties> {
  ...ResourceNameParameter<
    Resource = IoTSecuritySolutionModel,
    KeyName = "solutionName",
    SegmentName = "iotSecuritySolutions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IoTSecuritySolutionModels {
  /**
   * User this method to get details of a specific IoT Security solution based on solution name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolution_Get")
  get is ArmResourceRead<IoTSecuritySolutionModel>;

  /**
   * Use this method to create or update yours IoT Security solution
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolution_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IoTSecuritySolutionModel>;

  /**
   * Use this method to update existing IoT Security solution tags or user defined resources. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolution_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    IoTSecuritySolutionModel,
    PatchModel = UpdateIotSecuritySolutionData
  >;

  /**
   * Use this method to delete yours IoT Security solution
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolution_Delete")
  delete is ArmResourceDeleteSync<IoTSecuritySolutionModel>;

  /**
   * Use this method to get the list IoT Security solutions organized by resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolution_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    IoTSecuritySolutionModel,
    Parameters = {
      /**
       * Filter the IoT Security solution with OData syntax. Supports filtering by iotHubs.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<IoTSecuritySolutionsList>
  >;

  /**
   * Use this method to get the list of IoT Security solutions by subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolution_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    IoTSecuritySolutionModel,
    Parameters = {
      /**
       * Filter the IoT Security solution with OData syntax. Supports filtering by iotHubs.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<IoTSecuritySolutionsList>
  >;
}

@@doc(IoTSecuritySolutionModel.name, "The name of the IoT Security solution.");
@@doc(IoTSecuritySolutionModel.properties, "Security Solution data");
@@doc(IoTSecuritySolutionModels.createOrUpdate::parameters.resource,
  "The security solution data"
);
@@doc(IoTSecuritySolutionModels.update::parameters.properties,
  "The security solution data"
);
