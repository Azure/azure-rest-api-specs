import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation scoping configuration resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ReportResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ScopingConfigurationProperties
)
model ScopingConfigurationResource extends Azure.ResourceManager.Foundations.ProxyResource {
  @key("scopingConfiguration")
  @segment("scopingConfigurations")
  @visibility("read")
  @doc("The scoping configuration of the specific report.")
  @pattern("^[a-zA-Z0-9_]*$")
  @path
  name: string;

  /**
   * ScopingConfiguration property.
   */
  @extension("x-ms-client-flatten", true)
  @extension("x-ms-client-name", "properties")
  properties: ScopingConfigurationProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface ScopingConfigurationResources {
  /**
   * Get the AppComplianceAutomation scoping configuration of the specific report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScopingConfiguration_Get")
  get is ArmResourceRead<ScopingConfigurationResource>;

  /**
   * Get the AppComplianceAutomation scoping configuration of the specific report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScopingConfiguration_CreateOrUpdate")
  createOrUpdate is AcatOperations.AcatResourceCreateOrReplaceSync<ScopingConfigurationResource>;

  /**
   * Clean the AppComplianceAutomation scoping configuration of the specific report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScopingConfiguration_Delete")
  delete is ArmResourceDeleteSync<ScopingConfigurationResource>;

  /**
   * Returns a list format of the singleton scopingConfiguration for a specified report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScopingConfigurations_List")
  list is ArmResourceListByParent<ScopingConfigurationResource>;
}

@@doc(ScopingConfigurationResources.createOrUpdate::parameters.parameters,
  "Parameters for the create or update operation"
);

