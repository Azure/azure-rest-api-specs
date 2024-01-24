import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about an application in a Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BatchAccount)
@Azure.ResourceManager.Private.armResourceInternal(ApplicationProperties)
@includeInapplicableMetadataInPayload(false)
model Application extends ProxyResource {
  /**
   * The name of the application. This must be unique within the account.
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+$")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  /**
   * The properties associated with the Application.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApplicationProperties;
}

@armResourceOperations
interface Applications {
  /**
   * Gets information about the specified application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Application_Get")
  get is ArmResourceRead<Application>;

  /**
   * Adds an application to the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Application_Create")
  create is ArmResourceCreateOrReplaceSync<Application>;

  /**
   * Updates settings for the specified application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Application_Update")
  update is ArmCustomPatchSync<Application, Application>;

  /**
   * Deletes an application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Application_Delete")
  delete is ArmResourceDeleteSync<Application>;

  /**
   * Lists all of the applications in the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Application_List")
  list is ArmResourceListByParent<
    Application,
    {
      ...BaseParameters<Application>;

      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    }
  >;
}

@@projectedName(Applications.create::parameters.resource, "json", "parameters");
@@extension(Applications.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Applications.create::parameters.resource,
  "The parameters for the request."
);
@@projectedName(Applications.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Applications.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Applications.update::parameters.properties,
  "The parameters for the request."
);
