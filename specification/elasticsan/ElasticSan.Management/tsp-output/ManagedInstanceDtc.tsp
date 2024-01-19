import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("SQL Managed Instance DTC")
@parentResource(ManagedInstance)
model ManagedInstanceDtc is ProxyResource<ManagedInstanceDtcProperties> {
  @doc("The name of the managed instance DTC.")
  @path
  @key("dtcName")
  @segment("dtc")
  name: DtcName;
}

@armResourceOperations
interface ManagedInstanceDtcs {
  @doc("Gets managed instance DTC settings.")
  get is ArmResourceRead<ManagedInstanceDtc>;

  @doc("Updates managed instance DTC settings.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceDtc>;

  @doc("Gets a list of managed instance DTC settings.")
  listByManagedInstance is ArmResourceListByParent<ManagedInstanceDtc>;
}

@@projectedName(ManagedInstanceDtcs.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceDtcs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceDtcs.createOrUpdate::parameters.resource,
  "Managed instance DTC settings."
);
