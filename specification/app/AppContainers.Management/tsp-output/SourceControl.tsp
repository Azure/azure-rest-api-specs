import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
@doc("Container App SourceControl.")
@parentResource(ContainerApp)
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("Name of the Container App SourceControl.")
  @path
  @key("sourceControlName")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface SourceControls {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a SourceControl of a Container App.")
  @operationId("ContainerAppsSourceControls_Get")
  get is ArmResourceRead<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the SourceControl for a Container App.")
  @operationId("ContainerAppsSourceControls_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Container App SourceControl.")
  @operationId("ContainerAppsSourceControls_Delete")
  delete is ArmResourceDeleteAsync<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Container App SourceControls in a given resource group.")
  @operationId("ContainerAppsSourceControls_ListByContainerApp")
  listByContainerApp is ArmResourceListByParent<SourceControl>;
}

@@projectedName(SourceControls.createOrUpdate::parameters.resource,
  "json",
  "sourceControlEnvelope"
);
@@extension(SourceControls.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "sourceControlEnvelope"
);
@@doc(SourceControls.createOrUpdate::parameters.resource,
  "Properties used to create a Container App SourceControl"
);
