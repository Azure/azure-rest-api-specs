import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace iotHubClient;

interface OperationsOperations {
  @doc("Lists all of the available IoT Hub REST API operations.")
  @route("/providers/Microsoft.Devices/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface IotHubResourceOperations {
  @summary("Get the non-security related metadata of an IoT hub")
  @doc("Get the non-security related metadata of an IoT hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    IotHubDescription
  >;

  @summary("Create or update the metadata of an IoT hub.")
  @doc("""
Create or update the metadata of an Iot hub. The usual pattern to modify a
property is to retrieve the IoT hub metadata and security metadata, and then
combine them with the modified values in a new body to update the IoT hub. If
certain properties are missing in the JSON, updating IoT Hub may cause these
values to fallback to default, which may lead to unexpected behavior.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("""
ETag of the IoT Hub. Do not specify for creating a brand new IoT Hub. Required
to update an existing IoT Hub.
""")
      @header
      `If-Match`: string;

      @doc("The IoT hub metadata and security metadata.")
      @body
      iotHubDescription: IotHubDescription;
    },
    IotHubDescription
  >;

  @summary("Update an existing IoT Hubs tags.")
  @doc("""
Update an existing IoT Hub tags. to update other fields use the CreateOrUpdate
method
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("Name of iot hub to update.")
      @path
      resourceName: string;

      @doc("Updated tag information to set into the iot hub instance.")
      @body
      IotHubTags: TagsResource;
    },
    IotHubDescription
  >;

  @summary("Delete an IoT hub")
  @doc("Delete an IoT hub.")
  // FIXME: (multi-response) Swagger defines multiple requests and responses.
  //      This needs to be revisited as CADL supports linking specific responses to each request
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    IotHubDescription | void | ErrorDetails
  >;

  @summary("Get all the IoT hubs in a subscription")
  @doc("Get all the IoT hubs in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Devices/IotHubs")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    IotHubDescriptionListResult
  >;

  @summary("Get all the IoT hubs in a resource group")
  @doc("Get all the IoT hubs in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;
    },
    IotHubDescriptionListResult
  >;

  @summary("Get the statistics from an IoT hub")
  @doc("Get the statistics from an IoT hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/IotHubStats")
  @get
  GetStats is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    RegistryStatistics
  >;

  @summary("Get the list of valid SKUs for an IoT hub")
  @doc("Get the list of valid SKUs for an IoT hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/skus")
  @get
  GetValidSkus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    IotHubSkuDescriptionListResult
  >;

  @summary("""
Get a list of the consumer groups in the Event Hub-compatible device-to-cloud
endpoint in an IoT hub
""")
  @doc("""
Get a list of the consumer groups in the Event Hub-compatible device-to-cloud
endpoint in an IoT hub.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups")
  @get
  ListEventHubConsumerGroups is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the Event Hub-compatible endpoint.")
      @path
      eventHubEndpointName: string;
    },
    EventHubConsumerGroupsListResult
  >;

  @summary("""
Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for
an IoT hub
""")
  @doc("""
Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for
an IoT hub.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups/{name}")
  @get
  GetEventHubConsumerGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the Event Hub-compatible endpoint in the IoT hub.")
      @path
      eventHubEndpointName: string;

      @doc("The name of the consumer group to retrieve.")
      @path
      name: string;
    },
    EventHubConsumerGroupInfo
  >;

  @summary("Add a consumer group to an Event Hub-compatible endpoint in an IoT hub")
  @doc("Add a consumer group to an Event Hub-compatible endpoint in an IoT hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups/{name}")
  @put
  CreateEventHubConsumerGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the Event Hub-compatible endpoint in the IoT hub.")
      @path
      eventHubEndpointName: string;

      @doc("The name of the consumer group to add.")
      @path
      name: string;

      @doc("The consumer group to add.")
      @body
      consumerGroupBody: EventHubConsumerGroupBodyDescription;
    },
    EventHubConsumerGroupInfo
  >;

  @summary("Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub")
  @doc("Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/eventHubEndpoints/{eventHubEndpointName}/ConsumerGroups/{name}")
  @delete
  DeleteEventHubConsumerGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the Event Hub-compatible endpoint in the IoT hub.")
      @path
      eventHubEndpointName: string;

      @doc("The name of the consumer group to delete.")
      @path
      name: string;
    },
    void
  >;

  @summary("""
Get a list of all the jobs in an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry
""")
  @doc("""
Get a list of all the jobs in an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs")
  @get
  ListJobs is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    JobResponseListResult
  >;

  @summary("""
Get the details of a job from an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry
""")
  @doc("""
Get the details of a job from an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs/{jobId}")
  @get
  GetJob is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The job identifier.")
      @path
      jobId: string;
    },
    JobResponse
  >;

  @summary("Get the quota metrics for an IoT hub")
  @doc("Get the quota metrics for an IoT hub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/quotaMetrics")
  @get
  GetQuotaMetrics is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    IotHubQuotaMetricInfoListResult
  >;

  @summary("Get the health for routing endpoints")
  @doc("Get the health for routing endpoints.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{iotHubName}/routingEndpointsHealth")
  @get
  GetEndpointHealth is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @path resourceGroupName: string;
      @path iotHubName: string;
    },
    EndpointHealthDataListResult
  >;

  @summary("Check if an IoT hub name is available")
  @doc("Check if an IoT hub name is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Devices/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("""
Set the name parameter in the OperationInputs structure to the name of the IoT
hub to check.
""")
      @body
      operationInputs: OperationInputs;
    },
    IotHubNameAvailabilityInfo
  >;

  @summary("Test all routes")
  @doc("Test all routes configured in this Iot Hub")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{iotHubName}/routing/routes/$testall")
  @post
  TestAllRoutes is Azure.Core.Foundations.Operation<
    {
      @doc("IotHub to be tested")
      @path
      iotHubName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("resource group which Iot Hub belongs to")
      @path
      resourceGroupName: string;

      @doc("Input for testing all routes")
      @body
      input: TestAllRoutesInput;
    },
    TestAllRoutesResult
  >;

  @summary("Test the new route")
  @doc("Test the new route for this Iot Hub")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{iotHubName}/routing/routes/$testnew")
  @post
  TestRoute is Azure.Core.Foundations.Operation<
    {
      @doc("IotHub to be tested")
      @path
      iotHubName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("resource group which Iot Hub belongs to")
      @path
      resourceGroupName: string;

      @doc("Route that needs to be tested")
      @body
      input: TestRouteInput;
    },
    TestRouteResult
  >;

  @summary("""
Get the security metadata for an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security
""")
  @doc("""
Get the security metadata for an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/listkeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    SharedAccessSignatureAuthorizationRuleListResult
  >;

  @summary("""
Get a shared access policy by name from an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security
""")
  @doc("""
Get a shared access policy by name from an IoT hub. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/IotHubKeys/{keyName}/listkeys")
  @post
  GetKeysForKeyName is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the shared access policy.")
      @path
      keyName: string;
    },
    SharedAccessSignatureAuthorizationRule
  >;

  @summary("""
Exports all the device identities in the IoT hub identity registry to an Azure
Storage blob container. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities
""")
  @doc("""
Exports all the device identities in the IoT hub identity registry to an Azure
Storage blob container. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/exportDevices")
  @post
  ExportDevices is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The parameters that specify the export devices operation.")
      @body
      exportDevicesParameters: ExportDevicesRequest;
    },
    JobResponse
  >;

  @summary("""
Import, update, or delete device identities in the IoT hub identity registry
from a blob. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities
""")
  @doc("""
Import, update, or delete device identities in the IoT hub identity registry
from a blob. For more information, see:
https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/importDevices")
  @post
  ImportDevices is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The parameters that specify the import devices operation.")
      @body
      importDevicesParameters: ImportDevicesRequest;
    },
    JobResponse
  >;
}

interface ResourceProviderCommonOperations {
  @summary("Get the number of iot hubs in the subscription")
  @doc("Get the number of free and paid iot hubs in the subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Devices/usages")
  @get
  GetSubscriptionQuota is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    UserSubscriptionQuotaListResult
  >;
}

interface CertificatesOperations {
  @summary("Get the certificate list.")
  @doc("Returns the list of certificates.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates")
  @get
  ListByIotHub is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    CertificateListDescription
  >;

  @summary("Get the certificate.")
  @doc("Returns the certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the certificate")
      @path
      certificateName: string;
    },
    CertificateDescription
  >;

  @summary("Upload the certificate to the IoT hub.")
  @doc("Adds new or replaces existing certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the certificate")
      @path
      certificateName: string;

      @doc("""
ETag of the Certificate. Do not specify for creating a brand new certificate.
Required to update an existing certificate.
""")
      @header
      `If-Match`: string;

      @doc("The certificate body.")
      @body
      certificateDescription: CertificateDescription;
    },
    CertificateDescription
  >;

  @summary("Delete an X509 certificate.")
  @doc("Deletes an existing X509 certificate or does nothing if it does not exist.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the certificate")
      @path
      certificateName: string;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    },
    void
  >;

  @summary("Generate verification code for proof of possession flow.")
  @doc("""
Generates verification code for proof of possession flow. The verification code
will be used to generate a leaf certificate.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}/generateVerificationCode")
  @post
  GenerateVerificationCode is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the certificate")
      @path
      certificateName: string;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    },
    CertificateWithNonceDescription
  >;

  @summary("Verify certificate's private key possession.")
  @doc("""
Verifies the certificate's private key possession by providing the leaf cert
issued by the verifying pre uploaded certificate.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}/verify")
  @post
  Verify is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the certificate")
      @path
      certificateName: string;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;

      @doc("The name of the certificate")
      @body
      certificateVerificationBody: CertificateVerificationDescription;
    },
    CertificateDescription
  >;
}

interface IotHubOperations {
  @summary("Manually initiate a failover for the IoT Hub to its secondary region")
  @doc("""
Manually initiate a failover for the IoT Hub to its secondary region. To learn
more, see https://aka.ms/manualfailover
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{iotHubName}/failover")
  @post
  ManualFailover is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the IoT hub to failover")
      @path
      iotHubName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group containing the IoT hub resource")
      @path
      resourceGroupName: string;

      @doc("""
Region to failover to. Must be the Azure paired region. Get the value from the
secondary location in the locations property. To learn more, see
https://aka.ms/manualfailover/region
""")
      @body
      failoverInput: FailoverInput;
    },
    void
  >;
}

interface PrivateLinkResourcesOperations {
  @summary("List private link resources")
  @doc("List private link resources for the given IotHub")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/iotHubs/{resourceName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    PrivateLinkResources
  >;

  @summary("Get the specified private link resource")
  @doc("Get the specified private link resource for the given IotHub")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/iotHubs/{resourceName}/privateLinkResources/{groupId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the private link resource")
      @path
      groupId: string;
    },
    GroupIdInformation
  >;
}

interface PrivateEndpointConnectionsOperations {
  @summary("List private endpoint connections")
  @doc("List private endpoint connection properties")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/iotHubs/{resourceName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    void
  >;

  @summary("Get private endpoint connection")
  @doc("Get private endpoint connection properties")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/iotHubs/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @summary("Update private endpoint connection")
  @doc("Update the status of a private endpoint connection with the specified name")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/iotHubs/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection with updated properties")
      @body
      privateEndpointConnection: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @summary("Delete private endpoint connection")
  @doc("Delete private endpoint connection with the specified name")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/iotHubs/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection | void
  >;
}
