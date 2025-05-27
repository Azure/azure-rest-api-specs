import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

/** ******************* */
/**
 * MQ diagnosticService resource type model details.
 *
 * Azure Resource - mq/diagnosticService
 * CRD - DiagnosticService
 * CRD Version - v1alpha4
 */
@doc("MQ diagnostic services resource")
@parentResource(MqResource)
model DiagnosticServiceResource
  is TrackedResource<DiagnosticServiceProperties> {
  @doc("Name of MQ diagnostic resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("diagnosticServiceName")
  @path
  @segment("diagnosticService")
  name: string;

  ...ExtendedLocation;
}

@doc("MQ Diagnostic Services Resource properties")
model DiagnosticServiceProperties {
  @doc("The frequency at which the data will be exported.")
  @minValue(0)
  @maxValue(65535)
  dataExportFrequencySeconds?: int32 = 10;

  @doc("The details of Diagnostic Service Docker Image.")
  image: ContainerImage;

  @doc("The format for the logs generated.")
  logFormat?: string = "json";

  @doc("The format for the logs generated.")
  logLevel?: string = "info";

  @doc("The maximum data stored in MiB.")
  @minValue(0)
  @maxValue(4294967295)
  maxDataStorageSize?: int64 = 16;

  @doc("The port at which metrics is exposed.")
  @minValue(0)
  @maxValue(65535)
  metricsPort?: int32 = 9600;

  @doc("The destination to collect traces. Diagnostic service will push traces to this endpoint")
  openTelemetryTracesCollectorAddr?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Metric inactivity timeout.")
  @minValue(0)
  @maxValue(65535)
  staleDataTimeoutSeconds?: int32 = 600;
}
