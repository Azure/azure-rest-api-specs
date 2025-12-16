import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImageUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImageVersionUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryApplicationUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryApplicationVersionUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GallerySoftDeletedResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryInVMAccessControlProfileVersionUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PirSharedGalleryResource.identifier
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PirCommunityGalleryResource.identifier
);

@@clientName(Galleries.createOrUpdate::parameters.resource, "gallery");
@@clientName(Galleries.update::parameters.properties, "gallery");
@@clientName(Galleries.gallerySharingProfileUpdate::parameters.body,
  "sharingUpdate"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gallery.properties);

@@clientName(GalleryImages.createOrUpdate::parameters.resource, "galleryImage");
@@clientName(GalleryImages.update::parameters.properties, "galleryImage");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImage.properties);

@@clientName(GalleryImageVersions.createOrUpdate::parameters.resource,
  "galleryImageVersion"
);
@@clientName(GalleryImageVersions.update::parameters.properties,
  "galleryImageVersion"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImageVersion.properties
);

@@clientName(GalleryApplications.createOrUpdate::parameters.resource,
  "galleryApplication"
);
@@clientName(GalleryApplications.update::parameters.properties,
  "galleryApplication"
);

@@clientName(GalleryScripts.createOrUpdate::parameters.resource,
  "galleryScript"
);
@@clientName(GalleryScripts.update::parameters.properties, "galleryScript");

@@clientName(GalleryScriptVersions.createOrUpdate::parameters.resource,
  "galleryScriptVersion"
);
@@clientName(GalleryScriptVersions.update::parameters.properties,
  "galleryScriptVersion"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten retained for backward compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryApplication.properties
);

@@clientName(GalleryApplicationVersions.createOrUpdate::parameters.resource,
  "galleryApplicationVersion"
);
@@clientName(GalleryApplicationVersions.update::parameters.properties,
  "galleryApplicationVersion"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryApplicationVersion.properties
);

@@clientName(GalleryInVMAccessControlProfiles.createOrUpdate::parameters.resource,
  "galleryInVMAccessControlProfile"
);
@@clientName(GalleryInVMAccessControlProfiles.update::parameters.properties,
  "galleryInVMAccessControlProfile"
);

@@clientName(GalleryInVMAccessControlProfileVersions.createOrUpdate::parameters.resource,
  "galleryInVMAccessControlProfileVersion"
);
@@clientName(GalleryInVMAccessControlProfileVersions.update::parameters.properties,
  "galleryInVMAccessControlProfileVersion"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryInVMAccessControlProfileVersion.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SharedGallery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SharedGalleryImage.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SharedGalleryImageVersion.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityGallery.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityGalleryImage.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityGalleryImageVersion.properties
);

@@clientLocation(Galleries.listByArtifactName,
  "SoftDeletedResource",
  "!csharp"
);
@@clientLocation(Galleries.gallerySharingProfileUpdate,
  "GallerySharingProfile",
  "!csharp"
);
@@clientName(Galleries.gallerySharingProfileUpdate, "update", "!csharp");
