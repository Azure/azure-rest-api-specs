import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation evidence resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Referencing elements inside Private namespace"
@parentResource(ReportResource)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(EvidenceProperties)
model EvidenceResource extends Foundations.ProxyResource {
  /**
   * The evidence name.
   */
  @path
  @key("evidenceName")
  @segment("evidences")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-_.]+$")
  name: string;

  /**
   * Evidence property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  @extension("x-ms-client-name", "properties")
  properties: EvidenceProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface EvidenceResources {
  /**
   * Get the evidence metadata
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidences_Get")
  get is ArmResourceRead<
    EvidenceResource,
    {
      ...BaseParameters<EvidenceResource>;

      /**
       * The offerGuid which mapping to the reports.
       */
      @minLength(1)
      @query("offerGuid")
      offerGuid?: string;

      /**
       * The tenant id of the report creator.
       */
      @minLength(1)
      @query("reportCreatorTenantId")
      reportCreatorTenantId?: string;
    }
  >;

  /**
   * Create or Update an evidence a specified report
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidences_CreateOrUpdate")
  createOrUpdate is AcatOperations.AcatResourceCreateOrReplaceSync<
    EvidenceResource,
    {
      ...BaseParameters<EvidenceResource>;
      ...ExtraParameter;
    }
  >;

  /**
   * Delete an existent evidence from a specified report
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidences_Delete")
  delete is ArmResourceDeleteSync<EvidenceResource>;

  /**
   * Returns a paginated list of evidences for a specified report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidences_ListByReport")
  listByReport is ArmResourceListByParent<
    EvidenceResource,
    {
      ...BaseParameters<EvidenceResource>;
      ...QueryParameters;
    }
  >;

  /**
   * Download evidence file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidences_Download")
  download is ArmResourceActionSync<
    EvidenceResource,
    EvidenceFileDownloadRequest,
    EvidenceFileDownloadResponse
  >;
}

@@doc(EvidenceResources.createOrUpdate::parameters.parameters,
  "Parameters for the create or update operation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Deprecated: Using encodedName for the body property is meaningless."
@@encodedName(EvidenceResources.download::parameters.body,
  "application/json",
  "parameters"
);
@@doc(EvidenceResources.download::parameters.body,
  "Parameters for the query operation"
);
