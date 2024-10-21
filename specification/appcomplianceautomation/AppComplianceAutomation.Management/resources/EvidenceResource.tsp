import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation evidence resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
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
  #suppress "deprecated" "Legacy flatten"
  @Azure.ClientGenerator.Core.flattenProperty
  properties: EvidenceProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface Evidence {
  /**
   * Get the evidence metadata
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidence_Get")
  get is ArmResourceRead<
    EvidenceResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<EvidenceResource>;
    }
  >;

  /**
   * Create or Update an evidence a specified report
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidence_CreateOrUpdate")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidence_Delete")
  delete is ArmResourceDeleteSync<EvidenceResource>;

  /**
   * Returns a paginated list of evidences for a specified report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidence_ListByReport")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Evidence_Download")
  download is ArmResourceActionSync<
    EvidenceResource,
    EvidenceFileDownloadRequest,
    EvidenceFileDownloadResponse
  >;
}

@@doc(Evidence.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@encodedName(Evidence.download::parameters.body,
  "application/json",
  "parameters"
);
@@doc(Evidence.download::parameters.body, "Parameters for the query operation");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Evidence.createOrUpdate::parameters.resource,
  "application/json",
  "parameters"
);
@@clientName(Evidence.createOrUpdate::parameters.resource, "properties");
