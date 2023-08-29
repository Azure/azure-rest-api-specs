import "./ApiVersions.tsp";

import "../operationsTemp.tsp";

import "./WebModels/Common/DownloadUrl.tsp";

import "./WebModels/AssessmentProject.tsp";
import "./WebModels/AssessmentProjectSummary.tsp";
import "./WebModels/AssessmentOptions.tsp";
import "./WebModels/AvsAssessmentOptions.tsp";

import "./WebModels/Collectors/HyperVCollector.tsp";
import "./WebModels/Collectors/VmwareCollector.tsp";
import "./WebModels/Collectors/ServerCollector.tsp";
import "./WebModels/Collectors/SqlCollector.tsp";

import "./WebModels/Group.tsp";

import "./WebModels/PrivateEndpointConnection.tsp";
import "./WebModels/PrivateLinkResource.tsp";

import "./WebModels/AssessibleEntities/Machine.tsp";

import "./WebModels/Assessments/Assessment.tsp";
import "./WebModels/Assessments/AvsAssessment.tsp";

import "./WebModels/AssessedEntities/AssessedMachine.tsp";
import "./WebModels/AssessedEntities/AvsAssessedMachine.tsp";

import "./WebModels/Sql/AssessedSqlDatabaseV2.tsp";
import "./WebModels/Sql/AssessedSqlInstanceV2.tsp";
import "./WebModels/Sql/AssessedSqlMachine.tsp";
import "./WebModels/Sql/AssessedSqlRecommendedEntity.tsp";
import "./WebModels/Sql/SqlAssessmentV2.tsp";
import "./WebModels/Sql/SqlAssessmentV2Summary.tsp";
import "./WebModels/Sql/SqlAssessmentOptions.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface AssessmentProjectsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<AssessmentProject>;

    @added(ApiVersions.v2019_10_01)
    create is ArmResourceCreateOrUpdateAsync<AssessmentProject>;

    @added(ApiVersions.v2019_10_01)
    update is ArmResourcePatchAsync<AssessmentProject, ProjectProperties>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<AssessmentProject>;

    // @added(Versions.v2019_10_01)
    // ListBySubscription is ArmListBySubscription<AssessmentProjectResource>;

    // listByResourGRoup is ArmResourceListByParent
}

@armResourceOperations
interface AssessmentProjectSummaryOperations {
    @added(ApiVersions.v2020_05_01_preview)
    listByParent is ArmResourceListByParent<AssessmentProjectSummary>;
}

@armResourceOperations
interface MachinesOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<Machine>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParentUpdated<
        Machine,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface GroupsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<Group>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<Group>;

    @added(ApiVersions.v2019_10_01)
    create is ArmResourceCreateOrUpdateAsync<Group>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<Group>;

    @summary("Update machines in group.")
    @doc("Update machines in group by adding or removing machines.")
    @added(ApiVersions.v2019_10_01)
    updateMachines is ArmResourceActionAsync<Group, UpdateGroupBody, Group>;
}

@armResourceOperations
interface AssessmentsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<Assessment>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<Assessment>;

    // @added(ApiVersions.v2019_10_01)
    // listByProject is ArmResourceListAtScope<AssessmentResource>;

    @added(ApiVersions.v2019_10_01)
    create is ArmResourceCreateOrUpdateAsync<Assessment>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<Assessment>;

    @summary("Get download URL for the assessment report.")
    @doc("Get the URL for downloading the assessment in a report format.")
    @added(ApiVersions.v2019_10_01)
    getReportDownloadUrl is ArmResourceActionAsync<Assessment, {}, DownloadUrl>;
}

@armResourceOperations
interface AssessmentOptionsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<AssessmentOptions>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<AssessmentOptions>;
}

@armResourceOperations
interface AssessedMachinesOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<AssessedMachine>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParentUpdated<
        AssessedMachine,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface HypervCollectorsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<HypervCollector>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<HypervCollector>;

    @added(ApiVersions.v2019_10_01)
    create is ArmResourceCreateOrUpdateAsync<HypervCollector>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<HypervCollector>;
}

@armResourceOperations
interface VmwareCollectorsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<VmwareCollector>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<VmwareCollector>;

    @added(ApiVersions.v2019_10_01)
    create is ArmResourceCreateOrUpdateAsync<VmwareCollector>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<VmwareCollector>;
}

@armResourceOperations
interface ServerCollectorsOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<ServerCollector>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<ServerCollector>;

    @added(ApiVersions.v2019_10_01)
    create is ArmResourceCreateOrUpdateAsync<ServerCollector>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<ServerCollector>;
}

@armResourceOperations
interface PrivateEndpointConnectionOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<PrivateEndpointConnection>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<PrivateEndpointConnection>;

    @added(ApiVersions.v2019_10_01)
    update is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;

    @added(ApiVersions.v2019_10_01)
    delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
}

@armResourceOperations
interface PrivateLinkResourceOperations {
    @added(ApiVersions.v2019_10_01)
    get is ArmResourceRead<PrivateLinkResource>;

    @added(ApiVersions.v2019_10_01)
    listByParent is ArmResourceListByParent<PrivateLinkResource>;
}

@armResourceOperations
interface AvsAssessmentsOperations {
    @added(ApiVersions.v2020_05_01_preview)
    get is ArmResourceRead<AvsAssessment>;

    @added(ApiVersions.v2020_05_01_preview)
    listByParent is ArmResourceListByParent<AvsAssessment>;

    // @added(ApiVersions.v2019_10_01)
    // listByProject is ArmResourceListAtScope<AvsAssessmentResource>;

    @added(ApiVersions.v2020_05_01_preview)
    create is ArmResourceCreateOrUpdateAsync<AvsAssessment>;

    @added(ApiVersions.v2020_05_01_preview)
    delete is ArmResourceDeleteAsync<AvsAssessment>;

    @summary("Get download URL for the assessment report.")
    @doc("Get the URL for downloading the assessment in a report format.")
    @added(ApiVersions.v2020_05_01_preview)
    getReportDownloadUrl is ArmResourceActionAsync<
        AvsAssessment,
        {},
        DownloadUrl
    >;
}

@armResourceOperations
interface AvsAssessmentOptionsOperations {
    @added(ApiVersions.v2020_05_01_preview)
    get is ArmResourceRead<AvsAssessmentOptions>;

    @added(ApiVersions.v2020_05_01_preview)
    listByParent is ArmResourceListByParent<AvsAssessmentOptions>;
}

@armResourceOperations
interface AvsAssessedMachinesOperations {
    @added(ApiVersions.v2020_05_01_preview)
    get is ArmResourceRead<AvsAssessedMachine>;

    @added(ApiVersions.v2020_05_01_preview)
    listByParent is ArmResourceListByParentUpdated<
        AvsAssessedMachine,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface SqlAssessmentV2SummaryOperations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<SqlAssessmentV2Summary>;
}

@armResourceOperations
interface SqlAssessmentV2Operations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<SqlAssessmentV2>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParent<SqlAssessmentV2>;

    @added(ApiVersions.v2023_03_03)
    create is ArmResourceCreateOrUpdateAsync<SqlAssessmentV2>;

    @added(ApiVersions.v2023_03_03)
    delete is ArmResourceDeleteAsync<SqlAssessmentV2>;

    @summary("Get download URL for the assessment report.")
    @doc("Get the URL for downloading the assessment in a report format.")
    @added(ApiVersions.v2023_03_03)
    downloadUrl is ArmResourceActionAsync<SqlAssessmentV2, {}, DownloadUrl>;
}

@armResourceOperations
interface SqlAssessmentOptionsOperations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<SqlAssessmentOptions>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParent<SqlAssessmentOptions>;
}

@armResourceOperations
interface AssessedSqlMachinesOperations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<AssessedSqlMachine>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParentUpdated<
        AssessedSqlMachine,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface AssessedSqlRecommendedEntityOperations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<AssessedSqlRecommendedEntity>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParentUpdated<
        AssessedSqlRecommendedEntity,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface AssessedSqlInstanceV2Operations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<AssessedSqlInstanceV2>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParentUpdated<
        AssessedSqlInstanceV2,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface AssessedSqlDatabaseV2Operations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<AssessedSqlDatabaseV2>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParentUpdated<
        AssessedSqlDatabaseV2,
        {
            ...ApiVersionParameter;
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;

            #suppress "@azure-tools/cadl-azure-core/casing-style"
            @doc("Filter query.")
            @query
            $filter?: string;

            @doc("Optional parameter for page size.")
            @query
            pageSize?: integer;

            @doc("Optional parameter for continuation token.")
            @query
            continuationToken?: string;

            @doc("Total record count.")
            @query
            totalRecordCount?: integer;
        }
    >;
}

@armResourceOperations
interface SqlCollectorOperations {
    @added(ApiVersions.v2023_03_03)
    get is ArmResourceRead<SqlCollector>;

    @added(ApiVersions.v2023_03_03)
    listByParent is ArmResourceListByParent<SqlCollector>;

    @added(ApiVersions.v2023_03_03)
    create is ArmResourceCreateOrUpdateAsync<SqlCollector>;

    @added(ApiVersions.v2023_03_03)
    delete is ArmResourceDeleteAsync<SqlCollector>;
}