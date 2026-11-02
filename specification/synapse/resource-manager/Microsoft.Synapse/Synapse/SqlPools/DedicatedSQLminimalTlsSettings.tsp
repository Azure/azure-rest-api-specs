import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Dedicated Sql Minimal Tls Settings Info
 */
model DedicatedSQLminimalTlsSettings
  is Azure.ResourceManager.ProxyResource<DedicatedSQLminimalTlsSettingsProperties> {
  ...ResourceNameParameter<
    Resource = DedicatedSQLminimalTlsSettings,
    KeyName = "dedicatedSQLminimalTlsSettingsName",
    SegmentName = "dedicatedSQLminimalTlsSettings",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings {
  /**
   * Get workspace managed sql server's minimal tls settings.
   */
  get is ArmResourceRead<DedicatedSQLminimalTlsSettings>;

  /**
   * Update workspace managed sql server's minimal tls settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  update is ArmResourceCreateOrReplaceAsync<
    DedicatedSQLminimalTlsSettings,
    Response =
      | ArmResourceUpdatedResponse<DedicatedSQLminimalTlsSettings>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = DedicatedSQLminimalTlsSettings> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List workspace managed sql server's minimal tls settings.
   */
  list is ArmResourceListByParent<DedicatedSQLminimalTlsSettings>;
}

@@doc(
  DedicatedSQLminimalTlsSettings.name,
  "The name of the dedicated sql minimal tls settings."
);
@@doc(DedicatedSQLminimalTlsSettings.properties, "Resource properties.");
@@doc(
  WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings.update::parameters.resource,
  "minimal tls settings"
);
