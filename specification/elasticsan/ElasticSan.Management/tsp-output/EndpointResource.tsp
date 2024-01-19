import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridConnectivity;
@doc("The endpoint for the target resource.")
model EndpointResource is ExtensionResource<EndpointProperties> {
  @doc("The endpoint name.")
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface EndpointResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the endpoint to the resource.")
  @operationId("Endpoints_Get")
  get is ArmResourceRead<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the endpoint to the target resource.")
  @operationId("Endpoints_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the endpoint to the target resource.")
  @operationId("Endpoints_Update")
  update is ArmCustomPatchSync<
    EndpointResource,
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the endpoint access to the target resource.")
  @operationId("Endpoints_Delete")
  delete is ArmResourceDeleteSync<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of endpoints to the target resource.")
  @operationId("Endpoints_List")
  list is ArmResourceListByParent<
    EndpointResource,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the endpoint access credentials to the resource.")
  @operationId("Endpoints_ListCredentials")
  listCredentials is ArmResourceActionSync<
    EndpointResource,
    void,
    TargetResourceEndpointAccess,
    {
      ...BaseParameters<EndpointResource>;

      @doc("The fully qualified Azure Resource manager identifier of the resource to be connected.")
      @path
      scope: string;

      @doc("The is how long the endpoint access token is valid (in seconds).")
      @maxValue(10800)
      @minValue(600)
      @query("expiresin")
      expiresin?: int32 = 10800;
    }
  >;
}

@@projectedName(EndpointResources.createOrUpdate::parameters.resource,
  "json",
  "EndpointResource"
);
@@extension(EndpointResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "EndpointResource"
);
@@doc(EndpointResources.createOrUpdate::parameters.resource,
  "Endpoint details"
);
@@projectedName(EndpointResources.update::parameters.properties,
  "json",
  "EndpointResource"
);
@@extension(EndpointResources.update::parameters.properties,
  "x-ms-client-name",
  "EndpointResource"
);
@@doc(EndpointResources.update::parameters.properties, "Endpoint details");
