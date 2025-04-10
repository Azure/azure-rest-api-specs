import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AppPlatform;

@@clientName(ServiceResources.update::parameters.properties, "resource");
@@clientName(ServiceResources.regenerateTestKey::parameters.body,
  "regenerateTestKeyRequest"
);
@@clientName(ServiceResources.enableApmGlobally::parameters.body, "apm");
@@clientName(ServiceResources.disableApmGlobally::parameters.body, "apm");
@@clientName(ServiceResources.validate::parameters.body,
  "configServerSettings"
);

@@clientName(ApmResources.createOrUpdate::parameters.resource, "apmResource");

@@clientName(EurekaServerResources.updatePut::parameters.resource,
  "eurekaServerResource"
);
@@clientName(EurekaServerResources.updatePatch::parameters.properties,
  "eurekaServerResource"
);

@@clientName(ConfigServerResources.updatePut::parameters.resource,
  "configServerResource"
);
@@clientName(ConfigServerResources.updatePatch::parameters.properties,
  "configServerResource"
);

@@clientName(ConfigurationServiceResources.createOrUpdate::parameters.resource,
  "configurationServiceResource"
);
@@clientName(ConfigurationServiceResources.validate::parameters.body,
  "settings"
);
@@clientName(ConfigurationServiceResources.validateResource::parameters.body,
  "configurationServiceResource"
);

@@clientName(ApplicationLiveViewResources.createOrUpdate::parameters.resource,
  "applicationLiveViewResource"
);

@@clientName(DevToolPortalResources.createOrUpdate::parameters.resource,
  "DevToolPortalResource"
);

@@clientName(ContainerRegistryResources.createOrUpdate::parameters.resource,
  "containerRegistryResource"
);
@@clientName(ContainerRegistryResources.validate::parameters.body,
  "ContainerRegistryProperties"
);

@@clientName(BuildServices.createOrUpdate::parameters.resource, "buildService");

@@clientName(Builds.createOrUpdateBuild::parameters.resource, "build");

@@clientName(BuildpackBindingResources.createOrUpdate::parameters.resource,
  "buildpackBinding"
);

@@clientName(BuilderResources.createOrUpdate::parameters.resource,
  "builderResource"
);

@@clientName(BuildServiceAgentPoolResources.updatePut::parameters.resource,
  "agentPoolResource"
);

@@clientName(MonitoringSettingResources.updatePut::parameters.resource,
  "monitoringSettingResource"
);
@@clientName(MonitoringSettingResources.updatePatch::parameters.properties,
  "monitoringSettingResource"
);

@@clientName(AppResources.createOrUpdate::parameters.resource, "appResource");
@@clientName(AppResources.update::parameters.properties, "appResource");
@@clientName(AppResources.setActiveDeployments::parameters.body,
  "activeDeploymentCollection"
);
@@clientName(AppResources.validateDomain::parameters.body, "validatePayload");

@@clientName(BindingResources.createOrUpdate::parameters.resource,
  "bindingResource"
);
@@clientName(BindingResources.update::parameters.properties, "bindingResource");

@@clientName(StorageResources.createOrUpdate::parameters.resource,
  "storageResource"
);

@@clientName(CertificateResources.createOrUpdate::parameters.resource,
  "certificateResource"
);

@@clientName(CustomDomainResources.createOrUpdate::parameters.resource,
  "domainResource"
);
@@clientName(CustomDomainResources.update::parameters.properties,
  "domainResource"
);

@@clientName(DeploymentResources.createOrUpdate::parameters.resource,
  "deploymentResource"
);
@@clientName(DeploymentResources.update::parameters.properties,
  "deploymentResource"
);
@@clientName(DeploymentResources.generateHeapDump::parameters.body,
  "diagnosticParameters"
);
@@clientName(DeploymentResources.generateThreadDump::parameters.body,
  "diagnosticParameters"
);
@@clientName(DeploymentResources.startJFR::parameters.body,
  "diagnosticParameters"
);

@@clientName(GatewayResources.createOrUpdate::parameters.resource,
  "gatewayResource"
);
@@clientName(GatewayResources.updateCapacity::parameters.properties,
  "gatewayCapacityResource"
);
@@clientName(GatewayResources.validateDomain::parameters.body,
  "validatePayload"
);

@@clientName(GatewayRouteConfigResources.createOrUpdate::parameters.resource,
  "gatewayRouteConfigResource"
);

@@clientName(GatewayCustomDomainResources.createOrUpdate::parameters.resource,
  "gatewayCustomDomainResource"
);

@@clientName(ApiPortalResources.createOrUpdate::parameters.resource,
  "apiPortalResource"
);
@@clientName(ApiPortalResources.validateDomain::parameters.body,
  "validatePayload"
);

@@clientName(ApiPortalCustomDomainResources.createOrUpdate::parameters.resource,
  "apiPortalCustomDomainResource"
);

@@clientName(ApplicationAcceleratorResources.createOrUpdate::parameters.resource,
  "applicationAcceleratorResource"
);

@@clientName(CustomizedAcceleratorResources.createOrUpdate::parameters.resource,
  "customizedAcceleratorResource"
);
@@clientName(CustomizedAcceleratorResources.validate::parameters.body,
  "properties"
);

@@clientName(JobResources.createOrUpdate::parameters.resource, "jobResource");
