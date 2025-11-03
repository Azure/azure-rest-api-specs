// Contains overrides to make the Autorest Swagger2.0 back compatible
namespace SplitIO.Experimentation;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExperimentationWorkspace.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
