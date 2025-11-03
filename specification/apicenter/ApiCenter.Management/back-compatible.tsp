// Contains overrides to make the Autorest Swagger2.0 back compatible
namespace Microsoft.ApiCenter;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Api.properties, "autorest");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApiDefinition.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApiVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeletedService.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Deployment.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Environment.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MetadataSchema.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Service.properties,
  "autorest"
);
// For ServiceUpdate
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workspace.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApiSource.properties,
  "autorest"
);
