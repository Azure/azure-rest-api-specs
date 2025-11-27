import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Application.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * An application package which represents a particular version of an application.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Application)
model ApplicationPackage extends AzureProxyResource {
  properties?: ApplicationPackageProperties;
}

alias ApplicationPackageOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the application. This must be unique within the account. */
    @path
    @segment("applications")
    @key
    @pattern("^[a-zA-Z0-9_-]+$")
    @maxLength(64)
    @minLength(1)
    applicationName: string;
  },
  {
    /** The version of the application. */
    @path
    @segment("versions")
    @key
    @pattern("^[a-zA-Z0-9_-][a-zA-Z0-9_.-]*$")
    @maxLength(64)
    @minLength(1)
    versionName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface ApplicationPackages {
  /**
   * Gets information about the specified application package.
   */
  get is ApplicationPackageOps.Read<ApplicationPackage>;

  /**
   * Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ApplicationPackageOps.CreateOrUpdateSync<
    ApplicationPackage,
    Response = ArmResourceUpdatedResponse<ApplicationPackage>
  >;

  /**
   * Deletes an application package record and its associated binary file.
   */
  delete is ApplicationPackageOps.DeleteSync<ApplicationPackage>;

  /**
   * Lists all of the application packages in the specified application.
   */
  list is ApplicationPackageOps.List<
    ApplicationPackage,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListApplicationPackagesResult>
  >;

  /**
   * Activates the specified application package. This should be done after the `ApplicationPackage` was created and uploaded. This needs to be done before an `ApplicationPackage` can be used on Pools or Tasks.
   */
  activate is ApplicationPackageOps.ActionSync<
    ApplicationPackage,
    ActivateApplicationPackageParameters,
    ArmResponse<ApplicationPackage>
  >;
}

@@doc(ApplicationPackage.properties,
  "The properties associated with the Application Package."
);
@@doc(ApplicationPackages.create::parameters.resource,
  "The parameters for the request."
);
@@doc(ApplicationPackages.activate::parameters.body,
  "The parameters for the request."
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@extension(Applications.create::parameters.resource, "required", false);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@extension(ApplicationPackages.create::parameters.resource, "required", false);
