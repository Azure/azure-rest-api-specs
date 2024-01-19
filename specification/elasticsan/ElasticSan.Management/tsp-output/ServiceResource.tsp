import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
@doc("The service resource.")
@parentResource(ApplicationResource)
model ServiceResource is TrackedResource<ServiceResourceProperties> {
  @doc("The name of the service resource in the format of {applicationName}~{serviceName}.")
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface ServiceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.")
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Service Fabric managed service resource with the specified name.")
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ServiceResource,
    BaseParameters<ServiceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the tags of a service resource of a given managed cluster.")
  @operationId("Services_Update")
  update is ArmCustomPatchSync<ServiceResource, ServiceUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Service Fabric managed service resource with the specified name.")
  @operationId("Services_Delete")
  delete is ArmResourceDeleteAsync<
    ServiceResource,
    BaseParameters<ServiceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all service resources created or in the process of being created in the Service Fabric managed application resource.")
  @operationId("Services_ListByApplications")
  listByApplications is ArmResourceListByParent<ServiceResource>;
}

@@projectedName(ServiceResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "The service resource."
);
@@projectedName(ServiceResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ServiceResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceResources.update::parameters.properties,
  "The service resource updated tags."
);
