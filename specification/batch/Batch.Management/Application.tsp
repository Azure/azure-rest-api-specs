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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BatchAccount)
model Application extends AzureProxyResource {
  properties?: ApplicationProperties;
}

alias ApplicationsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<Application>;

    /** The name of the Batch account. */
    @path
    @segment("batchAccounts")
    @key
    @pattern("^[a-zA-Z0-9]+$")
    @maxLength(24)
    @minLength(3)
    accountName: string;
  },
  {
    /** The name of the application. This must be unique within the account. */
    @path
    @segment("applications")
    @key
    @pattern("^[a-zA-Z0-9_-]+$")
    @maxLength(64)
    @minLength(1)
    applicationName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface Applications {
  /**
   * Gets information about the specified application.
   */
  get is ApplicationsOps.Read<Application>;

  /**
   * Adds an application to the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ApplicationsOps.CreateOrUpdateSync<
    Application,
    Response = ArmResourceUpdatedResponse<Application>
  >;

  /**
   * Updates settings for the specified application.
   */
  @patch(#{ implicitOptionality: false })
  update is ApplicationsOps.CustomPatchSync<
    Application,
    PatchModel = Application
  >;

  /**
   * Deletes an application.
   */
  delete is ApplicationsOps.DeleteSync<Application>;

  /**
   * Lists all of the applications in the specified account.
   */
  list is ApplicationsOps.List<
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

@@doc(Application.properties,
  "The properties associated with the Application."
);
@@doc(Applications.create::parameters.resource,
  "The parameters for the request."
);
@@doc(Applications.update::parameters.properties,
  "The parameters for the request."
);
