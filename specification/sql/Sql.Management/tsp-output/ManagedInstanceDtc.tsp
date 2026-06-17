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
/**
 * SQL Managed Instance DTC
 */
@parentResource(ManagedInstance)
model ManagedInstanceDtc is ProxyResource<ManagedInstanceDtcProperties> {
  /**
   * The name of the managed instance DTC.
   */
  @path
  @key("dtcName")
  @segment("dtc")
  name: DtcName;
}

@armResourceOperations
interface ManagedInstanceDtcs {
  /**
   * Gets managed instance DTC settings.
   */
  get is ArmResourceRead<ManagedInstanceDtc>;

  /**
   * Updates managed instance DTC settings.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceDtc>;

  /**
   * Gets a list of managed instance DTC settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceDtcs_ListByManagedInstance")
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
