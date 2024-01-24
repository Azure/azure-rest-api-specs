import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * MSDeploy ARM response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("MSDeploy")
@parentResource(Site)
@Azure.ResourceManager.Private.armResourceInternal(MSDeployStatusProperties)
@includeInapplicableMetadataInPayload(false)
model MSDeployStatus extends ProxyOnlyResource {
  @key("extension")
  @segment("extensions")
  name: string;

  /**
   * MSDeployStatus resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: MSDeployStatusProperties;
}

@armResourceOperations
interface MSDeployStatuses {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetMSDeployStatus")
  getMSDeployStatus is ArmResourceRead<MSDeployStatus>;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateMSDeployOperation")
  createMSDeployOperation is ArmResourceCreateOrReplaceAsync<MSDeployStatus>;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  // FIXME: WebApps_GetMSDeployLog could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetMSDeployLog")
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/extensions/MSDeploy/log")
  @get
  getMSDeployLog is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;
}

@@projectedName(MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "json",
  "MSDeploy"
);
@@extension(MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "x-ms-client-name",
  "MSDeploy"
);
@@doc(MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "Details of MSDeploy operation"
);
