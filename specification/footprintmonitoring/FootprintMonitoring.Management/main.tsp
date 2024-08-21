import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
// import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.FootprintMonitoring")
@service({
    title: "Microsoft.FootprintMonitoring",
})
@doc("Microsoft Footprint active monitoring system REST API version 2024-07-10-preview.")
@versioned(Versions)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.FootprintMonitoring;

enum Versions {
    @doc("2024-07-10-preview api version")
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    `2024-07-10-preview`,
}

@doc("The Footprint profile resource.")
model Profile is TrackedResource<ProfileProperties> {
    @doc("Name of the Footprint profile resource.")
    @minLength(3)
    @maxLength(64)
    @pattern("^[a-zA-Z0-9]")
    @key("profileName")
    @path
    @segment("profiles")
    name: string;
}

@doc("A model representing the Footprint profile resource.")
model ProfileProperties {
    @doc("The status of the last operation.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;

    @doc("The id of the Footprint profile.")
    @visibility("read")
    profileId?: string;

    @doc("The description of the Footprint profile.")
    description?: string;

    @doc("The delay in milliseconds that the clients should wait for until they start performing measurements.")
    @minValue(0)
    @maxValue(3600000)
    startDelayMilliseconds: int32;

    @doc("The URL where the script for the Footprint profile.")
    @visibility("read")
    scriptUri?: string;

    @doc("The number of measurements to perform.")
    measurementCount: int32;

    @doc("The default sampling percentage for cold path measurement storage.")
    @minValue(0)
    @maxValue(100)
    coldPathSamplingPercentageRate?: float32;

    @doc("The endpoints which to perform measurements to.")
    @visibility("read")
    measurementEndpoints?: Array<MeasurementEndpoint>;

    @doc("The endpoints which to upload measurements to.")
    reportingEndpoints?: Array<string>;

    @doc("The experiments currently associated to this Footprint profile.")
    @visibility("read")
    experiments?: Array<Experiment>;
}

@doc("Name of the Footprint measurement endpoint resource.")
@parentResource(Profile)
model MeasurementEndpoint is ProxyResource<MeasurementEndpointProperties> {
    @doc("Name of the Footprint profile resource.")
    @minLength(5)
    @maxLength(64)
    @pattern("^[a-zA-Z0-9]")
    @key("measurementEndpointName")
    @path
    @segment("measurementEndpoints")
    name: string;
}

@doc("A model representing the Footprint Measurement Endpoint resource.")
model MeasurementEndpointProperties {
    @doc("The status of the last operation.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;

    @doc("The id of a measurement endpoint.")
    @visibility("read")
    @minLength(32)
    @maxLength(32)
    @pattern("[a-f0-9]{32}")
    endpointId?: string;

    @doc("The description of a measurement endpoint.")
    description?: string;

    @doc("The value of a measurement endpoint.")
    @minLength(0)
    @maxLength(1024)
    // TODO: this is an issue
    @pattern("^[a-z0-9\\*]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?$")
    endpoint: string;

    @doc("The type of a measurement endpoint.")
    measurementType: int32;

    @doc("The weight of a measurement endpoint, higher weight means higher priority.")
    @minValue(0)
    @maxValue(2147483647)
    weight: int32;

    @doc("The id of an experiment that a measurement endpoint is part of.")
    @minLength(32)
    @maxLength(32)
    @pattern("[a-f0-9]{32}")
    experimentId?: string;

    @doc("The path of the object that a measurement endpoint points to.")
    @minLength(0)
    @maxLength(1024)
    @pattern("^/[a-zA-Z0-9-._~%!$&()*+,;=@/]*$")
    objectPath?: string;

    @doc("The conditions of a measurement endpoint.")
    @visibility("read")
    conditions?: Array<MeasurementEndpointCondition>;

    @doc("The start time that a measurement endpoint should be served.")
    startTimeUtc?: utcDateTime;

    @doc("The end time that a measurement endpoint should be served.")
    endTimeUtc?: utcDateTime;

    @doc("The sampling rate, in percent, for the hot path logging of a measurement endpoint.")
    @minValue(0)
    @maxValue(100)
    hotPathSamplingPercentageRate?: float32;

    @doc("The sampling rate, in percent, for the warm path logging of a measurement endpoint.")
    @minValue(0)
    @maxValue(100)
    warmPathSamplingPercentageRate?: float32;

    @doc("The sampling rate, in percent, for the cold path logging of a measurement endpoint.")
    @minValue(0)
    @maxValue(100)
    coldPathSamplingPercentageRateOverride?: float32;

    @doc("The metadata of a measurement endpoint.")
    metadata: string;
}

@doc("A model representing the Footprint Measurement Endpoint Condition resource.")
@parentResource(MeasurementEndpoint)
model MeasurementEndpointCondition
    is ProxyResource<MeasurementEndpointConditionProperties> {
    @doc("Name of the Footprint measurement endpoint condition resource.")
    @minLength(5)
    @maxLength(64)
    @pattern("^[a-zA-Z0-9]")
    @key("conditionName")
    @path
    @segment("conditions")
    name: string;
}

@doc("A model representing the Footprint Measurement Endpoint Condition resource.")
model MeasurementEndpointConditionProperties {
    @doc("The status of the last operation.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;

    @doc("The id of a Footprint measurement endpoint condition.")
    @visibility("read")
    @minLength(32)
    @maxLength(32)
    @pattern("[a-f0-9]{32}")
    conditionId?: string;

    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
    @doc("The type of a Footprint measurement endpoint condition.")
    type: Type;

    @doc("The variable of a Footprint measurement endpoint condition.")
    variable: string;

    @doc("The operator of a Footprint measurement endpoint condition.")
    operator: Operator;

    @doc("The constant of a Footprint measurement endpoint condition.")
    constant: string;
}

@doc("A model representing the Footprint experiment.")
@parentResource(Profile)
model Experiment is ProxyResource<ExperimentProperties> {
    @doc("Name of the Footprint experiment resource.")
    @minLength(3)
    @maxLength(64)
    @pattern("^[a-zA-Z0-9]")
    @key("experimentName")
    @path
    @segment("experiments")
    name: string;
}

@doc("A model representing the Footprint Experiment resource.")
model ExperimentProperties {
    @doc("The status of the last operation.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;

    @doc("The id of a Footprint experiment.")
    @visibility("read")
    @minLength(32)
    @maxLength(32)
    @pattern("[a-f0-9]{32}")
    experimentId?: string;

    @doc("The description of a Footprint experiment.")
    description?: string;

    @doc("The status of a Footprint experiment.")
    @visibility("read")
    status?: string;
}

@doc("The type of a Footprint measurement endpoint condition.")
@summary("The type of a Footprint measurement endpoint condition.")
model Type {
    @doc("The condition is a requestHeader.")
    requestHeader: string;
}

@doc("The operator of a Footprint measurement endpoint condition.")
model Operator {
    @doc("The condition is an exact value.")
    isExactValue: "IsExactValue";

    @doc("The condition is a match value ignore casing.")
    matchValueIgnoreCasing: "MatchValueIgnoreCasing";

    @doc("The condition is a contains value.")
    containsValue: "ContainsValue";

    @doc("The condition is a contains value ignore casing.")
    containsValueIgnoreCasing: "ContainsValueIgnoreCasing";

    @doc("The condition is a does not contain value.")
    doesNotContainValue: "DoesNotContainValue";

    @doc("The condition is a does not contain value ignore casing.")
    doesNotContainValueIgnoreCasing: "DoesNotContainValueIgnoreCasing";
}

interface Operations {
    @tag("Operations")
    @autoRoute
    @doc("List the operations for the provider")
    @segment("operations")
    @armResourceRead(Azure.ResourceManager.Foundations.OperationListResult)
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `List all operations (maximum).`: {
                $ref: "./examples/Operations_List_MaximumSet_Gen.json",
            },
        }
    )
    @get
    list(
        ...ApiVersionParameter,

        @path
        @segment("providers")
        @doc("The provider namespace (this parameter will not show up in operations).")
        provider: "Microsoft.ThisWillBeReplaced",
    ): ArmResponse<Azure.ResourceManager.Foundations.OperationListResult> | ErrorResponse;
}
@armResourceOperations
interface Profiles {
    @tag("Footprint Profiles")
    @summary("Get a Footprint profile resource.")
    @doc("Retrieves the information about a single Footprint profile.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Get the details of a Footprint profile.`: {
                $ref: "./examples/Profiles_Get_MaximumSet_Gen.json",
            },
        }
    )
    get is ArmResourceRead<Profile>;

    @tag("Footprint Profiles")
    @summary("Creates or updates a Footprint profile resource.")
    @doc("Creates or updates a Footprint profile with the specified properties.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Create or update a Footprint profile.`: {
                $ref: "./examples/Profiles_CreateOrUpdate_MaximumSet_Gen.json",
            },
        }
    )
    createOrUpdate is ArmResourceCreateOrReplaceSync<Profile>;

    @tag("Footprint Profiles")
    @summary("Updates a Footprint profile resource.")
    @doc("Updates an existing Footprint profile resource.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Update a Footprint profile.`: {
                $ref: "./examples/Profiles_Update_MaximumSet_Gen.json",
            },
        }
    )
    update is ArmResourcePatchSync<Profile, ProfileProperties>;

    @tag("Footprint Profiles")
    @summary("Deletes a Footprint profile resource.")
    @doc("Deletes an existing Footprint profile.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Delete a Footprint profile.`: {
                $ref: "./examples/Profiles_Delete_MaximumSet_Gen.json",
            },
        }
    )
    delete is ArmResourceDeleteSync<Profile>;

    @tag("Footprint Profiles")
    @summary("Get all Footprint profiles under a resource group.")
    @doc("Retrieves the information about all Footprint profiles under a resource group.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `List all profiles under a Resource Group.`: {
                $ref: "./examples/Profiles_ListByResourceGroup_MaximumSet_Gen.json",
            },
        }
    )
    listByResourceGroup is ArmResourceListByParent<Profile>;

    @tag("Footprint Profiles")
    @summary("Get all Footprint profiles under a subscription.")
    @doc("Retrieves the information about all Footprint profiles under a subscription.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `List all profiles under a subscription.`: {
                $ref: "./examples/Profiles_ListBySubscription_MaximumSet_Gen.json",
            },
        }
    )
    listBySubscription is ArmListBySubscription<Profile>;
}

@armResourceOperations
interface MeasurementEndpoints {
    @tag("Footprint Measurement Endpoints")
    @summary("Get a measurement endpoint under a Footprint profile resource.")
    @doc("Retrieves the information about a single measurement endpoint under a Footprint profile.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Get the details of a measurement endpoint.`: {
                $ref: "./examples/MeasurementEndpoints_Get_MaximumSet_Gen.json",
            },
        }
    )
    get is ArmResourceRead<MeasurementEndpoint>;

    @tag("Footprint Measurement Endpoints")
    @summary("Creates or updates a single measurement endpoint under a Footprint profile resource.")
    @doc("Creates or updates a single measurement endpoint under a Footprint profile with the specified properties.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Create or update a measurement endpoint.`: {
                $ref: "./examples/MeasurementEndpoints_CreateOrUpdate_MaximumSet_Gen.json",
            },
        }
    )
    createOrUpdate is ArmResourceCreateOrReplaceSync<MeasurementEndpoint>;

    @tag("Footprint Measurement Endpoints")
    @summary("Deletes a measurement endpoint under a Footprint profile resource.")
    @doc("Deletes an existing measurement endpoint under a Footprint profile.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Delete a measurement endpoint.`: {
                $ref: "./examples/MeasurementEndpoints_Delete_MaximumSet_Gen.json",
            },
        }
    )
    delete is ArmResourceDeleteSync<MeasurementEndpoint>;

    @tag("Footprint Measurement Endpoints")
    @summary("Get all measurement endpoints under a resource group.")
    @doc("Retrieves the information about all measurement endpoints under a resource group.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `List all the measurement endpoints under a resource group.`: {
                $ref: "./examples/MeasurementEndpoints_ListByResourceGroup_MaximumSet_Gen.json",
            },
        }
    )
    listByResourceGroup is ArmResourceListByParent<MeasurementEndpoint>;
}

@armResourceOperations
interface MeasurementEndpointConditions {
    @tag("Footprint Measurement Endpoint Conditions")
    @summary("Get a measurement endpoint condition under a Footprint measurement endpoint resource.")
    @doc("Retrieves the information about a single measurement endpoint condition under a Footprint measurement endpoint.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Get the details of a measurement endpoint condition.`: {
                $ref: "./examples/MeasurementEndpointConditions_Get_MaximumSet_Gen.json",
            },
        }
    )
    get is ArmResourceRead<MeasurementEndpointCondition>;

    @tag("Footprint Measurement Endpoint Conditions")
    @summary("Creates or updates a measurement endpoint condition under a Footprint measurement resource.")
    @doc("Creates or updates a measurement endpoint condition under a Footprint measurement with the specified properties.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Create or update a measurement endpoint condition.`: {
                $ref: "./examples/MeasurementEndpointConditions_CreateOrUpdate_MaximumSet_Gen.json",
            },
        }
    )
    createOrUpdate is ArmResourceCreateOrReplaceSync<MeasurementEndpointCondition>;

    @tag("Footprint Measurement Endpoint Conditions")
    @summary("Deletes a measurement endpoint condition under a Footprint measurement resource.")
    @doc("Deletes an existing measurement endpoint condition under a Footprint measurement.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Delete a measurement endpoint condition.`: {
                $ref: "./examples/MeasurementEndpointConditions_Delete_MaximumSet_Gen.json",
            },
        }
    )
    delete is ArmResourceDeleteSync<MeasurementEndpointCondition>;

    @tag("Footprint Measurement Endpoint Conditions")
    @summary("Get all measurement endpoint conditions under a Footprint measurement resource.")
    @doc("Retrieves the information about all measurement endpoint conditions under a Footprint measurement resource.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `List all conditions under a measurement endpoint.`: {
                $ref: "./examples/MeasurementEndpointConditions_ListByResourceGroup_MaximumSet_Gen.json",
            },
        }
    )
    listByResourceGroup is ArmResourceListByParent<MeasurementEndpointCondition>;
}

@armResourceOperations
interface Experiments {
    @tag("Footprint Experiments")
    @summary("Get a Footprint experiment resource.")
    @doc("Retrieves the information about a single Footprint experiment.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Get the details of an experiment.`: {
                $ref: "./examples/Experiments_Get_MaximumSet_Gen.json",
            },
        }
    )
    get is ArmResourceRead<Experiment>;

    @tag("Footprint Experiments")
    @summary("Creates or updates a Footprint experiment resource.")
    @doc("Creates or updates a Footprint experiment with the specified properties.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Create or update an experiment.`: {
                $ref: "./examples/Experiments_CreateOrUpdate_MaximumSet_Gen.json",
            },
        }
    )
    createOrUpdate is ArmResourceCreateOrReplaceSync<Experiment>;

    @tag("Footprint Experiments")
    @summary("Deletes a Footprint experiment resource.")
    @doc("Deletes an existing Footprint experiment.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `Delete an experiment.`: {
                $ref: "./examples/Experiments_Delete_MaximumSet_Gen.json",
            },
        }
    )
    delete is ArmResourceDeleteSync<Experiment>;

    @tag("Footprint Experiments")
    @summary("Get all experiments under a resource group.")
    @doc("Retrieves the information about all experiments under a resource group.")
    @OpenAPI.extension(
        "x-ms-examples",
        {
            `List all experiments under a Footprint profile.`: {
                $ref: "./examples/Experiments_ListByResourceGroup_MaximumSet_Gen.json",
            },
        }
    )
    listByResourceGroup is ArmResourceListByParent<Experiment>;
}
