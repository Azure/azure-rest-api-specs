import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
@doc("An application type version resource for the specified application type name resource.")
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is TrackedResource<ApplicationTypeVersionResourceProperties> {
  @doc("The application type version.")
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ApplicationTypeVersionResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Service Fabric managed application type version resource created or in the process of being created in the Service Fabric managed application type name resource.")
  @operationId("ApplicationTypeVersions_Get")
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Service Fabric managed application type version resource with the specified name.")
  @operationId("ApplicationTypeVersions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ApplicationTypeVersionResource,
    BaseParameters<ApplicationTypeVersionResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the tags of an application type version resource of a given managed cluster.")
  @operationId("ApplicationTypeVersions_Update")
  update is ArmCustomPatchSync<
    ApplicationTypeVersionResource,
    ApplicationTypeVersionUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Service Fabric managed application type version resource with the specified name.")
  @operationId("ApplicationTypeVersions_Delete")
  delete is ArmResourceDeleteAsync<
    ApplicationTypeVersionResource,
    BaseParameters<ApplicationTypeVersionResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all application type version resources created or in the process of being created in the Service Fabric managed application type name resource.")
  @operationId("ApplicationTypeVersions_ListByApplicationTypes")
  listByApplicationTypes is ArmResourceListByParent<ApplicationTypeVersionResource>;
}

@@projectedName(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "The application type version resource."
);
@@projectedName(ApplicationTypeVersionResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ApplicationTypeVersionResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationTypeVersionResources.update::parameters.properties,
  "The application type version resource updated tags."
);
