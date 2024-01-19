import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("The diagnostic setting resource.")
model DiagnosticSettingsResource is ExtensionResource<DiagnosticSettings> {
  @doc("The name of the diagnostic setting.")
  @path
  @key("name")
  @segment("diagnosticSettings")
  name: string;
}

@armResourceOperations
interface DiagnosticSettingsResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the active diagnostic settings for the specified resource.")
  @operationId("DiagnosticSettings_Get")
  get is ArmResourceRead<DiagnosticSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates diagnostic settings for the specified resource.")
  @operationId("DiagnosticSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiagnosticSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes existing diagnostic settings for the specified resource.")
  @operationId("DiagnosticSettings_Delete")
  delete is ArmResourceDeleteSync<DiagnosticSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the active diagnostic settings list for the specified resource.")
  @operationId("DiagnosticSettings_List")
  list is ArmResourceListByParent<DiagnosticSettingsResource>;
}

@@projectedName(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
