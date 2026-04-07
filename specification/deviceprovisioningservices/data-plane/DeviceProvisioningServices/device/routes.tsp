import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace ProvisioningDeviceClient;

interface RuntimeRegistrationOperationGroup {
  /**
   * Gets the registration operation status.
   */
  @extension("x-ms-long-running-operation", true)
  @summary("Gets the registration operation status.")
  @operationId("RuntimeRegistration_OperationStatusLookup")
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

      @path
      idScope: string;
    },
    RegistrationOperationStatus200 | RegistrationOperationStatus202,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Gets the device registration status.
   */
  @summary("Gets the device registration status.")
  @operationId("RuntimeRegistration_DeviceRegistrationStatusLookup")
  @route("/{idScope}/registrations/{registrationId}")
  @post
  deviceRegistrationStatusLookup is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      registrationId: string;

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
  @removed(Versions.v2025_07_01_preview)
  @sharedRoute
  @extension("x-ms-long-running-operation", true)
  @summary("Registers the devices.")
  @operationId("RuntimeRegistration_RegisterDevice")
  @route("/{idScope}/registrations/{registrationId}/register")
  @put
  registerDevice is Azure.Core.Foundations.Operation<
    {
      /**
       * The registration ID is alphanumeric, lowercase, and may contain hyphens.
       */
      @path
      registrationId: string;

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
  @added(Versions.v2025_07_01_preview)
  @sharedRoute
  @extension("x-ms-long-running-operation", true)
  @summary("Registers the devices and optionally issue operational certificates for IoT devices.")
  @operationId("RuntimeRegistration_RegisterDeviceAndIssueCertificate")
  @route("/{idScope}/registrations/{registrationId}/register")
  @put
  registerDeviceAndIssueCertificate is Azure.Core.Foundations.Operation<
    {
      /**
       * The registration ID is alphanumeric, lowercase, and may contain hyphens.
       */
      @path
      registrationId: string;

      @path
      idScope: string;

      /**
       * Device registration request.
       */
      @bodyRoot
      deviceRegistration: DeviceRegistration;
    },
    RegistrationOperationStatus200 | RegistrationOperationStatus202,
    {},
    ProvisioningServiceErrorDetails
  >;
}
