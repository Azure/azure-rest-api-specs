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
@doc("An application package which represents a particular version of an application.")
@parentResource(Application)
model ApplicationPackage is ProxyResource<ApplicationPackageProperties> {
  @doc("The version of the application.")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-][a-zA-Z0-9_.-]*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ApplicationPackages {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified application package.")
  @operationId("ApplicationPackage_Get")
  get is ArmResourceRead<ApplicationPackage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates an application package record. The record contains a storageUrl where the package should be uploaded to.  Once it is uploaded the `ApplicationPackage` needs to be activated using `ApplicationPackageActive` before it can be used. If the auto storage account was configured to use storage keys, the URL returned will contain a SAS.")
  @operationId("ApplicationPackage_Create")
  create is ArmResourceCreateOrReplaceSync<ApplicationPackage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an application package record and its associated binary file.")
  @operationId("ApplicationPackage_Delete")
  delete is ArmResourceDeleteSync<ApplicationPackage>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the application packages in the specified application.")
  @operationId("ApplicationPackage_List")
  list is ArmResourceListByParent<
    ApplicationPackage,
    {
      ...BaseParameters<ApplicationPackage>;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Activates the specified application package. This should be done after the `ApplicationPackage` was created and uploaded. This needs to be done before an `ApplicationPackage` can be used on Pools or Tasks.")
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
