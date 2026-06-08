import "@azure-tools/typespec-client-generator-core";


using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;





@@clientName(CodeContainers.createOrUpdate::parameters.resource, "body");

@@clientName(CodeVersions.createOrUpdate::parameters.resource, "body");

@@clientName(ComponentContainers.createOrUpdate::parameters.resource, "body");

@@clientName(ComponentVersions.createOrUpdate::parameters.resource, "body");

@@clientName(DataContainers.createOrUpdate::parameters.resource, "body");

@@clientName(DataVersions.createOrUpdate::parameters.resource, "body");

@@clientName(EnvironmentContainers.createOrUpdate::parameters.resource, "body");

@@clientName(EnvironmentVersions.createOrUpdate::parameters.resource, "body");

@@clientName(ModelContainers.createOrUpdate::parameters.resource, "body");

@@clientName(ModelVersions.createOrUpdate::parameters.resource, "body");



@@clientLocation(DataReferencesOperationGroup.getBlobReferenceSAS, "DataReferences");


@@clientLocation(ResourceManagementAssetReferenceOperationGroup.`import`, "ResourceManagementAssetReference");


@@clientLocation(TemporaryDataReferencesOperationGroup.createOrGetTemporaryDataReference, "TemporaryDataReferences");


