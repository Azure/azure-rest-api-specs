import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
@doc("The springbootservers envelope resource definition.")
@parentResource(SpringbootsitesModel)
model SpringbootserversModel is ProxyResource<SpringbootserversProperties> {
  @doc("The springbootservers name.")
  @maxLength(64)
  @minLength(3)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]*$")
  @path
  @key("springbootserversName")
  @segment("springbootservers")
  name: string;
}

@armResourceOperations
interface SpringbootserversModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootservers resource.")
  @operationId("springbootservers_Get")
  get is ArmResourceRead<SpringbootserversModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create springbootservers resource.")
  @operationId("springbootservers_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SpringbootserversModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update springbootservers resource.")
  @operationId("springbootservers_Update")
  update is ArmCustomPatchAsync<
    SpringbootserversModel,
    SpringbootserversPatch,
    BaseParameters<SpringbootserversModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete springbootservers resource.")
  @operationId("springbootservers_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SpringbootserversModel,
    BaseParameters<SpringbootserversModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootservers resource by resourceGroup")
  @operationId("springbootservers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootserversModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootservers resource by subscription")
  @operationId("springbootservers_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootserversModel>;
}

@@projectedName(SpringbootserversModels.createOrUpdate::parameters.resource,
  "json",
  "springbootservers"
);
@@extension(SpringbootserversModels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "springbootservers"
);
@@doc(SpringbootserversModels.createOrUpdate::parameters.resource,
  "Create a springbootservers payload."
);
@@projectedName(SpringbootserversModels.update::parameters.properties,
  "json",
  "springbootservers"
);
@@extension(SpringbootserversModels.update::parameters.properties,
  "x-ms-client-name",
  "springbootservers"
);
@@doc(SpringbootserversModels.update::parameters.properties,
  "Update a springbootservers payload."
);
