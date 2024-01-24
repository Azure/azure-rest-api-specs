import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The KPI resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@Azure.ResourceManager.Private.armResourceInternal(KpiDefinition)
@includeInapplicableMetadataInPayload(false)
model KpiResourceFormat extends ProxyResource {
  /**
   * The name of the KPI.
   */
  @path
  @key("kpiName")
  @segment("kpi")
  name: string;

  /**
   * Defines the KPI Threshold limits.
   */
  @extension("x-ms-client-flatten", true)
  properties?: KpiDefinition;
}

@armResourceOperations
interface KpiResourceFormats {
  /**
   * Gets a KPI in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Kpi_Get")
  get is ArmResourceRead<KpiResourceFormat>;

  /**
   * Creates a KPI or updates an existing KPI in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Kpi_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<KpiResourceFormat>;

  /**
   * Deletes a KPI in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Kpi_Delete")
  delete is ArmResourceDeleteAsync<KpiResourceFormat>;

  /**
   * Gets all the KPIs in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Kpi_ListByHub")
  listByHub is ArmResourceListByParent<KpiResourceFormat>;

  /**
   * Reprocesses the Kpi values of the specified KPI.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Kpi_Reprocess")
  reprocess is ArmResourceActionNoContentSync<KpiResourceFormat, void>;
}

@@projectedName(KpiResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(KpiResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(KpiResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/update KPI operation."
);
