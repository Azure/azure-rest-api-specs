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
@doc("The springbootapps envelope resource definition.")
@parentResource(SpringbootsitesModel)
model SpringbootappsModel is ProxyResource<SpringbootappsProperties> {
  @doc("The springbootapps name.")
  @maxLength(64)
  @minLength(3)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]*$")
  @path
  @key("springbootappsName")
  @segment("springbootapps")
  name: string;
}

@armResourceOperations
interface SpringbootappsModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a springbootapps resource.")
  @operationId("springbootapps_Get")
  get is ArmResourceRead<SpringbootappsModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a springbootapps resource.")
  @operationId("springbootapps_Update")
  update is ArmCustomPatchAsync<
    SpringbootappsModel,
    SpringbootappsPatch,
    BaseParameters<SpringbootappsModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootapps resource by resourceGroup")
  @operationId("springbootapps_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootappsModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootapps resource by subscription")
  @operationId("springbootapps_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootappsModel>;
}

@@projectedName(SpringbootappsModels.update::parameters.properties,
  "json",
  "springbootapps"
);
@@extension(SpringbootappsModels.update::parameters.properties,
  "x-ms-client-name",
  "springbootapps"
);
@@doc(SpringbootappsModels.update::parameters.properties,
  "Update a springbootapps payload."
);
