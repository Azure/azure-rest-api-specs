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
@doc("Contains information about an application in a Batch account.")
@parentResource(BatchAccount)
model Application is ProxyResource<ApplicationProperties> {
  @doc("The name of the application. This must be unique within the account.")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+$")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface Applications {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified application.")
  @operationId("Application_Get")
  get is ArmResourceRead<Application>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Adds an application to the specified Batch account.")
  @operationId("Application_Create")
  create is ArmResourceCreateOrReplaceSync<Application>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates settings for the specified application.")
  @operationId("Application_Update")
  update is ArmCustomPatchSync<Application, Application>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an application.")
  @operationId("Application_Delete")
  delete is ArmResourceDeleteSync<Application>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the applications in the specified account.")
  @operationId("Application_List")
  list is ArmResourceListByParent<
    Application,
    {
      ...BaseParameters<Application>;

      @doc("The maximum number of items to return in the response.")
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
