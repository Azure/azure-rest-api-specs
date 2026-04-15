import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace IoTSecurityAPI;
/**
 * IoT Security solution configuration and resource information.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecuritySolutionModel
  is Azure.ResourceManager.ProxyResource<IoTSecuritySolutionProperties> {
  ...ResourceNameParameter<
    Resource = IoTSecuritySolutionModel,
    KeyName = "solutionName",
    SegmentName = "iotSecuritySolutions",
    NamePattern = ""
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface IoTSecuritySolutionModels {
  /**
   * User this method to get details of a specific IoT Security solution based on solution name
   */
  @tag("IoT Security Solution")
  get is ArmResourceRead<IoTSecuritySolutionModel, Error = CloudError>;

  /**
   * Use this method to create or update yours IoT Security solution
   */
  @tag("IoT Security Solution")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IoTSecuritySolutionModel,
    Error = CloudError
  >;

  /**
   * Use this method to update existing IoT Security solution tags or user defined resources. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("IoT Security Solution")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    IoTSecuritySolutionModel,
    PatchModel = UpdateIotSecuritySolutionData,
    Error = CloudError
  >;

  /**
   * Use this method to delete yours IoT Security solution
   */
  @tag("IoT Security Solution")
  delete is ArmResourceDeleteSync<IoTSecuritySolutionModel, Error = CloudError>;

  /**
   * Use this method to get the list IoT Security solutions organized by resource group.
   */
  @tag("IoT Security Solution")
  listByResourceGroup is ArmResourceListByParent<
    IoTSecuritySolutionModel,
    Parameters = {
      /**
       * Filter the IoT Security solution with OData syntax. Supports filtering by iotHubs.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<IoTSecuritySolutionsList>,
    Error = CloudError
  >;

  /**
   * Use this method to get the list of IoT Security solutions by subscription.
   */
  @tag("IoT Security Solution")
  listBySubscription is ArmListBySubscription<
    IoTSecuritySolutionModel,
    Parameters = {
      /**
       * Filter the IoT Security solution with OData syntax. Supports filtering by iotHubs.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<IoTSecuritySolutionsList>,
    Error = CloudError
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
