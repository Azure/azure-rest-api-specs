import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
@doc("Single sign-on configurations for a given monitor resource.")
@parentResource(MonitorResource)
model DynatraceSingleSignOnResource
  is ProxyResource<DynatraceSingleSignOnProperties> {
  @doc("Single Sign On Configuration Name")
  @path
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  name: string;
}

@armResourceOperations
interface DynatraceSingleSignOnResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a DynatraceSingleSignOnResource")
  @operationId("SingleSignOn_Get")
  get is ArmResourceRead<DynatraceSingleSignOnResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a DynatraceSingleSignOnResource")
  @operationId("SingleSignOn_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DynatraceSingleSignOnResource,
    BaseParameters<DynatraceSingleSignOnResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all DynatraceSingleSignOnResource by monitorName")
  @operationId("SingleSignOn_List")
  list is ArmResourceListByParent<DynatraceSingleSignOnResource>;
}
