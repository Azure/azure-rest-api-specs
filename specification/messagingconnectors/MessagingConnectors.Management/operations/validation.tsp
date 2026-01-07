import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/validationModels/validationModels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service(#{ title: "Microsoft.MessagingConnectors management service" })
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@singleton("default")
@parentResource(SubscriptionLocationResource)
@doc("A validation resource Azure")
model Validation is TrackedResource<Models.Validation.ValidationRequest> {
  @doc("The default validation resource")
  @path
  @key("validation")
  @segment("validation")
  @visibility(Lifecycle.Read)
  @pattern("^default$")
  name: string;
}

@armResourceOperations
interface ConfigOperations {
  @doc("create one validation task for connector config")
  connectorValidation is ArmResourceActionAsync<
    Validation,
    Models.Validation.ConnectorConfigurationValidationRequest,
    Models.Validation.ValidationResult
  >;

  @doc("create one validation task for datapreview config")
  dataPreviewValidation is ArmResourceActionAsync<
    Validation,
    Models.Validation.DataPreviewConfigurationValidationRequest,
    Models.Validation.ValidationResult
  >;
}
