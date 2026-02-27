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

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
@tag("Application")
interface Applications {
  /**
   * Gets information about the specified application.
   */
  get is ArmResourceRead<Application, Error = CloudError>;

  /**
   * Adds an application to the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    Application,
    Response = ArmResourceUpdatedResponse<Application>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Updates settings for the specified application.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Application,
    PatchModel = Application,
    Error = CloudError
  >;

  /**
   * Deletes an application.
   */
  delete is ArmResourceDeleteSync<Application, Error = CloudError>;

  /**
   * Lists all of the applications in the specified account.
   */
  list is ArmResourceListByParent<
    Application,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListApplicationsResult>,
    Error = CloudError
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
