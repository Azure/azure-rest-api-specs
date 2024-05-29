import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation evidence resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ReportResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(EvidenceProperties)
model EvidenceResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * The evidence name.
   */
  @key("evidenceName")
  @segment("evidences")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-_.]+$")
  @path
  name: string;

  /**
   * Evidence property.
   */
  @extension("x-ms-client-flatten", true)
  @extension("x-ms-client-name", "properties")
  properties: EvidenceProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface EvidenceResources {
  /**
   * Get the evidence metadata
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Evidences_Get")
  get is ArmResourceRead<
    EvidenceResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<EvidenceResource>;
    }
  >;

  /**
   * Create or Update an evidence a specified report
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Evidences_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    EvidenceResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<EvidenceResource>;
      ...ExtraParameter;
    }
  >;

  /**
   *  Delete an existent evidence from a specified report
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Evidences_Delete")
  delete is ArmResourceDeleteSync<EvidenceResource>;

  /**
   * Returns a paginated list of evidences for a specified report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Evidences_ListByReport")
  listByReport is ArmResourceListByParent<
    EvidenceResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<EvidenceResource>;
      ...QueryParameters;
    }
  >;

  /**
   * Download evidence file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Evidences_Download")
  download is ArmResourceActionSync<
    EvidenceResource,
    EvidenceFileDownloadRequest,
    EvidenceFileDownloadResponse
  >;
}

@@doc(EvidenceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@encodedName(EvidenceResources.download::parameters.body,
  "application/json",
  "parameters"
);
@@OpenAPI.extension(EvidenceResources.download::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@clientName(EvidenceResources.download::parameters.body,
  "parameters"
);
@@doc(EvidenceResources.download::parameters.body,
  "Parameters for the query operation"
);

@@encodedName(EvidenceResources.createOrUpdate::parameters.resource,
  "application/json",
  "parameters"
);
