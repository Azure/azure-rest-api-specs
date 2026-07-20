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
@removed(Versions.v2026_10_01)
@renamedFrom(Versions.v2026_10_01, "ApplicationPackage")
model ApplicationPackagePrev
  is Azure.ResourceManager.ProxyResource<ApplicationPackagePropertiesPrev> {
  ...ResourceNameParameter<
    Resource = ApplicationPackagePrev,
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
 * An application package which represents a particular version of an application.
 */
@parentResource(Application)
@added(Versions.v2026_10_01)
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

@armResourceOperations
@tag("ApplicationPackage")
interface ApplicationPackages {
  /**
   * Gets information about the specified application package.
   */
  @sharedRoute
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "get")
  getPrev is ArmResourceRead<ApplicationPackagePrev, Error = CloudError>;

  /**
   * Gets information about the specified application package.
   */
  @sharedRoute
  @added(Versions.v2026_10_01)
  get is ArmResourceRead<ApplicationPackage, Error = CloudError>;

  /**
   * Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy behavior"
  @sharedRoute
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "create")
  createPrev is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    ApplicationPackagePrev,
    Response = ArmResourceUpdatedResponse<ApplicationPackagePrev>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy behavior"
  @sharedRoute
  @added(Versions.v2026_10_01)
  create is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    ApplicationPackage,
    Response = ArmResourceUpdatedResponse<ApplicationPackage>,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Deletes an application package record and its associated binary file.
   */
  @sharedRoute
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "delete")
  deletePrev is ArmResourceDeleteSync<
    ApplicationPackagePrev,
    Error = CloudError
  >;

  /**
   * Deletes an application package record and its associated binary file.
   */
  @sharedRoute
  @added(Versions.v2026_10_01)
  delete is ArmResourceDeleteSync<ApplicationPackage, Error = CloudError>;

  /**
   * Lists all of the application packages in the specified application.
   */
  @sharedRoute
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "list")
  listPrev is ArmResourceListByParent<
    ApplicationPackagePrev,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListApplicationPackagesResultPrev>,
    Error = CloudError
  >;

  /**
   * Lists all of the application packages in the specified application.
   */
  @sharedRoute
  @added(Versions.v2026_10_01)
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
  @sharedRoute
  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "activate")
  @action("activate")
  activatePrev is ArmResourceActionSync<
    ApplicationPackagePrev,
    ActivateApplicationPackageParameters,
    ArmResponse<ApplicationPackagePrev>,
    Error = CloudError
  >;

  /**
   * Activates the specified application package. This should be done after the `ApplicationPackage` was created and uploaded. This needs to be done before an `ApplicationPackage` can be used on Pools or Tasks.
   */
  @sharedRoute
  @added(Versions.v2026_10_01)
  activate is ArmResourceActionSync<
    ApplicationPackage,
    ActivateApplicationPackageParameters,
    ArmResponse<ApplicationPackage>,
    Error = CloudError
  >;
}

@@maxLength(ApplicationPackagePrev.name, 64);
@@minLength(ApplicationPackagePrev.name, 1);
@@doc(ApplicationPackagePrev.name, "The version of the application.");
@@doc(
  ApplicationPackagePrev.properties,
  "The properties associated with the Application Package."
);

@@maxLength(ApplicationPackage.name, 64);
@@minLength(ApplicationPackage.name, 1);
@@doc(ApplicationPackage.name, "The version of the application.");
@@doc(
  ApplicationPackage.properties,
  "The properties associated with the Application Package."
);

@@doc(
  ApplicationPackages.createPrev::parameters.resource,
  "The parameters for the request."
);
@@doc(
  ApplicationPackages.activatePrev::parameters.body,
  "The parameters for the request."
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
@@extension(
  ApplicationPackages.createPrev::parameters.resource,
  "required",
  false
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy design that typespec didn't have a direct translation for"
@@extension(ApplicationPackages.create::parameters.resource, "required", false);
