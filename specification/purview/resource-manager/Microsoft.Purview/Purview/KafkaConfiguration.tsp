import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Purview;
/**
 * The configuration of the event streaming service resource attached to the Purview account for kafka notifications.
 */
@parentResource(Account)
model KafkaConfiguration
  is Azure.ResourceManager.ProxyResource<KafkaConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = KafkaConfiguration,
    KeyName = "kafkaConfigurationName",
    SegmentName = "kafkaConfigurations",
    NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
  >;
}

@armResourceOperations
interface KafkaConfigurations {
  /**
   * Gets the kafka configuration for the account
   */
  @summary("Gets the kafka configuration.")
  get is ArmResourceRead<KafkaConfiguration, Error = ErrorResponseModel>;

  /**
   * Create or update Kafka Configuration
   */
  @summary("Create or update the kafka configuration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    KafkaConfiguration,
    Error = ErrorResponseModel
  >;

  /**
   * Deletes a KafkaConfiguration resource.
   */
  @summary("Deletes the kafka configuration on the account.")
  delete is ArmResourceDeleteSync<
    KafkaConfiguration,
    Error = ErrorResponseModel
  >;

  /**
   * Lists the Kafka configurations in the Account
   */
  @summary("Gets the list of Kafka configurations for the account.")
  listByAccount is ArmResourceListByParent<
    KafkaConfiguration,
    Parameters = {
      /**
       * The skip token.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<KafkaConfigurationList>,
    Error = ErrorResponseModel
  >;
}

@@maxLength(KafkaConfiguration.name, 63);
@@minLength(KafkaConfiguration.name, 3);
@@doc(KafkaConfiguration.name, "Name of kafka configuration.");
@@doc(KafkaConfiguration.properties,
  "The kafka configuration properties of the event streaming service attached to the Purview account for kafka notifications."
);
@@doc(KafkaConfigurations.createOrUpdate::parameters.resource,
  "The kafka configuration of the account."
);
