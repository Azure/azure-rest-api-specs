import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Application.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "legacy design"
  tags?: Record<string>;
}

/**
 * An application package which represents a particular version of an application, excluding the storage URL details.
 */
@parentResource(Application)
model ApplicationPackageInfo
  is Azure.ResourceManager.ProxyResource<ApplicationPackageInfoProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationPackageInfo,
    KeyName = "versionName",
    SegmentName = "versions",
    NamePattern = "^[a-zA-Z0-9_-][a-zA-Z0-9_.-]*$"
  >;

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy design"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "legacy design"
  tags?: Record<string>;
}

@armResourceOperations
@tag("ApplicationPackage")
interface ApplicationPackages {
  /**
   * Gets information about the specified application package.
   */
  @returnTypeChangedFrom(
    Versions.v2026_08_01,
    ArmResponse<ApplicationPackage> | CloudError
  )
  get is ArmResourceRead<ApplicationPackageInfo, Error = CloudError>;

  /**
   * Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy behavior"
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
  @returnTypeChangedFrom(
    Versions.v2026_08_01,
    ArmResponse<ListApplicationPackagesResult> | CloudError
  )
  list is ArmResourceListByParent<
    ApplicationPackageInfo,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ApplicationPackageInfoListResult>,
    Error = CloudError
  >;

  /**
   * Activates the specified application package. This should be done after the `ApplicationPackage` was created and uploaded. This needs to be done before an `ApplicationPackage` can be used on Pools or Tasks.
   */
  @returnTypeChangedFrom(
    Versions.v2026_08_01,
    ArmResponse<ApplicationPackage> | CloudError
  )
  activate is ArmResourceActionSync<
    ApplicationPackageInfo,
    ActivateApplicationPackageParameters,
    ArmResponse<ApplicationPackageInfo>,
    Error = CloudError
  >;
}

@@maxLength(ApplicationPackage.name, 64);
@@minLength(ApplicationPackage.name, 1);
@@doc(ApplicationPackage.name, "The version of the application.");
@@maxLength(ApplicationPackageInfo.name, 64);
@@minLength(ApplicationPackageInfo.name, 1);
@@doc(ApplicationPackageInfo.name, "The version of the application.");
@@doc(
  ApplicationPackage.properties,
  "The properties associated with the Application Package."
);
@@doc(
  ApplicationPackages.create::parameters.resource,
  "The parameters for the request."
);
@@doc(
  ApplicationPackages.activate::parameters.body,
  "The parameters for the request."
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy design that typespec didn't have a direct translation for"
@@extension(Applications.create::parameters.resource, "required", false);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy design that typespec didn't have a direct translation for"
@@extension(ApplicationPackages.create::parameters.resource, "required", false);
