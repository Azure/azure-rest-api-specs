import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * SQL Managed Instance DTC
 */
@parentResource(ManagedInstance)
model ManagedInstanceDtc
  is Azure.ResourceManager.ProxyResource<ManagedInstanceDtcProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceDtc,
    KeyName = "dtcName",
    SegmentName = "dtc",
    NamePattern = "",
    Type = DtcName
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceDtc,
    Response = ArmResourceUpdatedResponse<ManagedInstanceDtc>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceDtc> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of managed instance DTC settings.
   */
  listByManagedInstance is ArmResourceListByParent<ManagedInstanceDtc>;
}

@@doc(ManagedInstanceDtc.name, "The name of the managed instance DTC.");
@@doc(ManagedInstanceDtc.properties, "Resource properties.");
@@doc(ManagedInstanceDtcs.createOrUpdate::parameters.resource,
  "Managed instance DTC settings."
);
