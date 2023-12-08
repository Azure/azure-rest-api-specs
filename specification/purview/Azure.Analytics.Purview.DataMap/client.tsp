import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PurviewDataMap;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(PurviewDataMap.ApiVersions.v2023_09_01)
namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "EntityClient",
  service: PurviewDataMap,
})
interface EntityClient {
  createOrUpdate is PurviewDataMap.Entity.createOrUpdate;
  listByGuids is PurviewDataMap.Entity.listByGuids;
  bulkCreateOrUpdate is PurviewDataMap.Entity.bulkCreateOrUpdate;
  bulkDelete is PurviewDataMap.Entity.bulkDelete;
  addClassification is PurviewDataMap.Entity.addClassification;
  get is PurviewDataMap.Entity.get;
  partialUpdateAttributeByGuid is PurviewDataMap.Entity.partialUpdateAttributeByGuid;
  delete is PurviewDataMap.Entity.delete;
  getClassification is PurviewDataMap.Entity.getClassification;
  removeClassification is PurviewDataMap.Entity.removeClassification;
  getClassifications is PurviewDataMap.Entity.getClassifications;
  addClassifications is PurviewDataMap.Entity.addClassifications;
  updateClassifications is PurviewDataMap.Entity.updateClassifications;
  getByUniqueAttributes is PurviewDataMap.Entity.getByUniqueAttributes;
  partialUpdateByUniqueAttributes is PurviewDataMap.Entity.partialUpdateByUniqueAttributes;
  deleteByUniqueAttribute is PurviewDataMap.Entity.deleteByUniqueAttribute;
  removeClassificationByUniqueAttribute is PurviewDataMap.Entity.removeClassificationByUniqueAttribute;
  addClassificationsByUniqueAttribute is PurviewDataMap.Entity.addClassificationsByUniqueAttribute;
  updateClassificationsByUniqueAttribute is PurviewDataMap.Entity.updateClassificationsByUniqueAttribute;
  bulkSetClassifications is PurviewDataMap.Entity.bulkSetClassifications;
  listByUniqueAttributes is PurviewDataMap.Entity.listByUniqueAttributes;
  getHeader is PurviewDataMap.Entity.getHeader;
  removeBusinessMetadata is PurviewDataMap.Entity.removeBusinessMetadata;
  addOrUpdateBusinessMetadata is PurviewDataMap.Entity.addOrUpdateBusinessMetadata;
  removeBusinessMetadataAttributes is PurviewDataMap.Entity.removeBusinessMetadataAttributes;
  addOrUpdateBusinessMetadataAttributes is PurviewDataMap.Entity.addOrUpdateBusinessMetadataAttributes;
  getSampleBusinessMetadataTemplate is PurviewDataMap.Entity.getSampleBusinessMetadataTemplate;
  #suppress "@azure-tools/typespec-azure-core/byos" "This is Atlas API"
  importBusinessMetadata is PurviewDataMap.Entity.importBusinessMetadata;
  removeLabels is PurviewDataMap.Entity.removeLabels;
  setLabels is PurviewDataMap.Entity.setLabels;
  addLabel is PurviewDataMap.Entity.addLabel;
  removeLabelsByUniqueAttribute is PurviewDataMap.Entity.removeLabelsByUniqueAttribute;
  setLabelsByUniqueAttribute is PurviewDataMap.Entity.setLabelsByUniqueAttribute;
  addLabelsByUniqueAttribute is PurviewDataMap.Entity.addLabelsByUniqueAttribute;
  moveEntitiesToCollection is PurviewDataMap.Entity.moveEntitiesToCollection;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "GlossaryClient",
  service: PurviewDataMap,
})
interface GlossaryClient {
  list is PurviewDataMap.Glossary.list;
  create is PurviewDataMap.Glossary.create;
  createCategories is PurviewDataMap.Glossary.createCategories;
  createCategory is PurviewDataMap.Glossary.createCategory;
  getCategory is PurviewDataMap.Glossary.getCategory;
  updateCategory is PurviewDataMap.Glossary.updateCategory;
  deleteCategory is PurviewDataMap.Glossary.deleteCategory;
  partialUpdateCategory is PurviewDataMap.Glossary.partialUpdateCategory;
  listRelatedCategories is PurviewDataMap.Glossary.listRelatedCategories;
  listCategoryTerms is PurviewDataMap.Glossary.listCategoryTerms;
  createTerm is PurviewDataMap.Glossary.createTerm;
  getTerm is PurviewDataMap.Glossary.getTerm;
  updateTerm is PurviewDataMap.Glossary.updateTerm;
  deleteTerm is PurviewDataMap.Glossary.deleteTerm;
  partialUpdateTerm is PurviewDataMap.Glossary.partialUpdateTerm;
  createTerms is PurviewDataMap.Glossary.createTerms;
  listEntitiesAssignedWithTerm is PurviewDataMap.Glossary.listEntitiesAssignedWithTerm;
  assignTermToEntities is PurviewDataMap.Glossary.assignTermToEntities;
  deleteTermAssignmentFromEntities is PurviewDataMap.Glossary.deleteTermAssignmentFromEntities;
  listRelatedTerms is PurviewDataMap.Glossary.listRelatedTerms;
  get is PurviewDataMap.Glossary.get;
  update is PurviewDataMap.Glossary.update;
  delete is PurviewDataMap.Glossary.delete;
  listCategories is PurviewDataMap.Glossary.listCategories;
  listCategoriesHeaders is PurviewDataMap.Glossary.listCategoriesHeaders;
  getDetailed is PurviewDataMap.Glossary.getDetailed;
  partialUpdate is PurviewDataMap.Glossary.partialUpdate;
  listTerms is PurviewDataMap.Glossary.listTerms;
  listTermHeaders is PurviewDataMap.Glossary.listTermHeaders;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "DiscoveryClient",
  service: PurviewDataMap,
})
interface DiscoveryClient {
  query is PurviewDataMap.Discovery.query;
  suggest is PurviewDataMap.Discovery.suggest;
  autoComplete is PurviewDataMap.Discovery.autoComplete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "LineageClient",
  service: PurviewDataMap,
})
interface LineageClient {
  get is PurviewDataMap.Lineage.get;
  getNextPage is PurviewDataMap.Lineage.getNextPage;
  getByUniqueAttribute is PurviewDataMap.Lineage.getByUniqueAttribute;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "RelationshipClient",
  service: PurviewDataMap,
})
interface RelationshipClient {
  create is PurviewDataMap.Relationship.create;
  update is PurviewDataMap.Relationship.update;
  get is PurviewDataMap.Relationship.get;
  delete is PurviewDataMap.Relationship.delete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "TypeClient",
  service: PurviewDataMap,
})
interface TypeClient {
  getBusinessMetadataDefByGuid is PurviewDataMap.Type.getBusinessMetadataDefByGuid;
  getBusinessMetadataDefByName is PurviewDataMap.Type.getBusinessMetadataDefByName;
  getClassificationDefByGuid is PurviewDataMap.Type.getClassificationDefByGuid;
  getClassificationDefByName is PurviewDataMap.Type.getClassificationDefByName;
  getEntityDefByGuid is PurviewDataMap.Type.getEntityDefByGuid;
  getEntityDefByName is PurviewDataMap.Type.getEntityDefByName;
  getEnumDefByGuid is PurviewDataMap.Type.getEnumDefByGuid;
  getEnumDefByName is PurviewDataMap.Type.getEnumDefByName;
  getRelationshipDefByGuid is PurviewDataMap.Type.getRelationshipDefByGuid;
  getRelationshipDefByName is PurviewDataMap.Type.getRelationshipDefByName;
  getStructDefByGuid is PurviewDataMap.Type.getStructDefByGuid;
  getStructDefByName is PurviewDataMap.Type.getStructDefByName;
  getByGuid is PurviewDataMap.Type.getByGuid;
  getByName is PurviewDataMap.Type.getByName;
  delete is PurviewDataMap.Type.delete;
  list is PurviewDataMap.Type.list;
  bulkCreate is PurviewDataMap.Type.bulkCreate;
  bulkUpdate is PurviewDataMap.Type.bulkUpdate;
  bulkDelete is PurviewDataMap.Type.bulkDelete;
  listHeaders is PurviewDataMap.Type.listHeaders;
  getTermTemplateDefByGuid is PurviewDataMap.Type.getTermTemplateDefByGuid;
  getTermTemplateDefByName is PurviewDataMap.Type.getTermTemplateDefByName;
}
