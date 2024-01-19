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

namespace Microsoft.Security;
@doc("The connector setting")
@subscriptionResource
model ConnectorSetting is ProxyResource<ConnectorSettingProperties> {
  @doc("Name of the cloud account connector")
  @path
  @key("connectorName")
  @segment("connectors")
  name: string;
}

@armResourceOperations
interface ConnectorSettings {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Details of a specific cloud account connector")
  @operationId("Connectors_Get")
  get is ArmResourceRead<ConnectorSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a cloud account connector or update an existing one. Connect to your cloud account. For AWS, use either account credentials or role-based authentication. For GCP, use account organization credentials.")
  @operationId("Connectors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a cloud account connector from a subscription")
  @operationId("Connectors_Delete")
  delete is ArmResourceDeleteSync<ConnectorSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Cloud accounts connectors of a subscription")
  @operationId("Connectors_List")
  list is ArmResourceListByParent<ConnectorSetting>;
}

@@projectedName(ConnectorSettings.createOrUpdate::parameters.resource,
  "json",
  "connectorSetting"
);
@@extension(ConnectorSettings.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "connectorSetting"
);
@@doc(ConnectorSettings.createOrUpdate::parameters.resource,
  "Settings for the cloud account connector"
);
