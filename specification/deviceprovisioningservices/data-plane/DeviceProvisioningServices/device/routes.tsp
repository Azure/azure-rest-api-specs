import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@typespec/openapi";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace ProvisioningDeviceClient;

interface RuntimeRegistration {
  /**
   * Gets the registration operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "The DPS device API uses a non-standard LRO pattern; status field is on the nested RegistrationOperationStatus body"
  @summary("Gets the registration operation status.")
  @route("/{idScope}/registrations/{registrationId}/operations/{operationId}")
  @get
  operationStatusLookup is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      registrationId: string;

      /**
       * Operation ID.
       */
      @path
      operationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;
    },
    {
      @statusCode _: 200;
      @body body: RegistrationOperationStatus;
    } | {
      @statusCode _: 202;

      @header("retry-after")
      retryAfter?: int32;

      @header("Location")
      location?: string;

      @body body: RegistrationOperationStatus;
    },
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Gets the device registration status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Gets the device registration status.")
  @route("/{idScope}/registrations/{registrationId}")
  @post
  deviceRegistrationStatusLookup is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /**
       * Device registration.
       */
      @bodyRoot
      body: DeviceRegistration;
    },
    DeviceRegistrationResult,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Registers the devices.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId and x-ms-long-running-operation extension for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @removed(Versions.v2025_07_01_preview)
  @sharedRoute
  @extension("x-ms-long-running-operation", true)
  @summary("Registers the devices.")
  @route("/{idScope}/registrations/{registrationId}/register")
  @put
  registerDevice is Azure.Core.Foundations.Operation<
    {
      /**
       * The registration ID is alphanumeric, lowercase, and may contain hyphens.
       */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /**
       * Device registration request.
       */
      @bodyRoot
      body: DeviceRegistration;
    },
    RegistrationOperationStatus200 | RegistrationOperationStatus202,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Registers the devices and optionally issue operational certificates for IoT devices.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId and x-ms-long-running-operation extension for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @added(Versions.v2025_07_01_preview)
  @sharedRoute
  @summary("Registers the devices and optionally issue operational certificates for IoT devices.")
  @pollingOperation(RuntimeRegistration.operationStatusLookup)
  @route("/{idScope}/registrations/{registrationId}/register")
  @put
  registerDeviceAndIssueCertificate is Azure.Core.Foundations.Operation<
    {
      /**
       * The registration ID is alphanumeric, lowercase, and may contain hyphens.
       */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /**
       * Device registration request.
       */
      @bodyRoot
      deviceRegistration: DeviceRegistration;
    },
    {
      @statusCode _: 200;
      @body body: RegistrationOperationStatus;
    } | {
      @statusCode _: 202;

      @header("retry-after")
      retryAfter?: int32;

      @header("Location")
      location?: string;

      @body body: RegistrationOperationStatus;
    },
    {},
    ProvisioningServiceErrorDetails
  >;
}
