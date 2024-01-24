import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Application.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * An application package which represents a particular version of an application.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Application)
@Azure.ResourceManager.Private.armResourceInternal(ApplicationPackageProperties)
@includeInapplicableMetadataInPayload(false)
model ApplicationPackage extends ProxyResource {
  /**
   * The version of the application.
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-][a-zA-Z0-9_.-]*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  /**
   * The properties associated with the Application Package.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApplicationPackageProperties;
}

@armResourceOperations
interface ApplicationPackages {
  /**
   * Gets information about the specified application package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationPackage_Get")
  get is ArmResourceRead<ApplicationPackage>;

  /**
   * Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationPackage_Create")
  create is ArmResourceCreateOrReplaceSync<ApplicationPackage>;

  /**
   * Deletes an application package record and its associated binary file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationPackage_Delete")
  delete is ArmResourceDeleteSync<ApplicationPackage>;

  /**
   * Lists all of the application packages in the specified application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationPackage_List")
  list is ArmResourceListByParent<
    ApplicationPackage,
    {
      ...BaseParameters<ApplicationPackage>;

      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    }
  >;

  /**
   * Activates the specified application package. This should be done after the `ApplicationPackage` was created and uploaded. This needs to be done before an `ApplicationPackage` can be used on Pools or Tasks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationPackage_Activate")
  activate is ArmResourceActionSync<
    ApplicationPackage,
    ActivateApplicationPackageParameters,
    ApplicationPackage
  >;
}

@@projectedName(ApplicationPackages.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(ApplicationPackages.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationPackages.create::parameters.resource,
  "The parameters for the request."
);
@@projectedName(ApplicationPackages.activate::parameters.body,
  "json",
  "parameters"
);
@@extension(ApplicationPackages.activate::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationPackages.activate::parameters.body,
  "The parameters for the request."
);
