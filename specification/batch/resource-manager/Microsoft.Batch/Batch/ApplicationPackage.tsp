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
@parentResource(Application)
model ApplicationPackage
  is Azure.ResourceManager.ProxyResource<ApplicationPackageProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationPackage,
    KeyName = "versionName",
    SegmentName = "versions",
    NamePattern = "^[a-zA-Z0-9_-][a-zA-Z0-9_.-]*$"
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
@tag("ApplicationPackage")
interface ApplicationPackages {
  /**
   * Gets information about the specified application package.
   */
  get is ArmResourceRead<ApplicationPackage, Error = CloudError>;

  /**
   * Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    ApplicationPackage,
    Response = ArmResourceUpdatedResponse<ApplicationPackage>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Deletes an application package record and its associated binary file.
   */
  delete is ArmResourceDeleteSync<ApplicationPackage, Error = CloudError>;

  /**
   * Lists all of the application packages in the specified application.
   */
  list is ArmResourceListByParent<
    ApplicationPackage,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListApplicationPackagesResult>,
    Error = CloudError
  >;

  /**
   * Activates the specified application package. This should be done after the `ApplicationPackage` was created and uploaded. This needs to be done before an `ApplicationPackage` can be used on Pools or Tasks.
   */
  activate is ArmResourceActionSync<
    ApplicationPackage,
    ActivateApplicationPackageParameters,
    ArmResponse<ApplicationPackage>,
    Error = CloudError
  >;
}

@@maxLength(ApplicationPackage.name, 64);
@@minLength(ApplicationPackage.name, 1);
@@doc(ApplicationPackage.name, "The version of the application.");
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
