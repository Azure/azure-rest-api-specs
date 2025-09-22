import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about an application in a Batch account.
 */
@parentResource(BatchAccount)
model Application
  is Azure.ResourceManager.ProxyResource<ApplicationProperties> {
  ...ResourceNameParameter<
    Resource = Application,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = "^[a-zA-Z0-9_-]+$"
  >;
}

@armResourceOperations
interface Applications {
  /**
   * Gets information about the specified application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Application_Get")
  get is ArmResourceRead<Application>;

  /**
   * Adds an application to the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Application_Create")
  create is ArmResourceCreateOrReplaceSync<
    Application,
    Response = ArmResourceUpdatedResponse<Application>
  >;

  /**
   * Updates settings for the specified application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Application_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Application, PatchModel = Application>;

  /**
   * Deletes an application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Application_Delete")
  delete is ArmResourceDeleteSync<Application>;

  /**
   * Lists all of the applications in the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Application_List")
  list is ArmResourceListByParent<
    Application,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListApplicationsResult>
  >;
}

@@maxLength(Application.name, 64);
@@minLength(Application.name, 1);
@@doc(Application.name,
  "The name of the application. This must be unique within the account."
);
@@doc(Application.properties,
  "The properties associated with the Application."
);
@@doc(Applications.create::parameters.resource,
  "The parameters for the request."
);
@@doc(Applications.update::parameters.properties,
  "The parameters for the request."
);
