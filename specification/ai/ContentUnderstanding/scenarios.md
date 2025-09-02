# Champion Scenarios

## Automated Invoice Processing Pipeline

**Customer Value:** Transform manual invoice processing into a fully automated AP workflow that reduces processing time from hours to minutes while improving accuracy and audit trails.

**Business Scenario:** A finance team receives hundreds of invoices daily via email, web uploads, and cloud storage. They need to extract key data, validate information, and route invoices to the appropriate approval workflows based on vendor, amount, and department.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@documentUrl = https://contoso.blob.core.windows.net/invoices/invoice-2025-001.pdf

### Step 1: Create Document Classifier
# @name createClassifier
PUT {{endpoint}}/contentunderstanding/classifiers/invoice-classifier?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "categories": [
    { "name": "Invoice" },
    { "name": "Receipt" },
    { "name": "PurchaseOrder" },
    { "name": "Contract" },
    { "name": "Other" }
  ]
}

// Response: {"operationId": "classifier-create-inv-001"}

### Step 2: Classify Uploaded Document
# @name classifyDocument
POST {{endpoint}}/contentunderstanding/classifiers/invoice-classifier:classify?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{documentUrl}}"
}

// Response: {"operationId": "classify-operation-inv-001"}

### Step 3: Get Classification Result
# @name getClassificationResult
GET {{endpoint}}/contentunderstanding/classifierResults/{{classifyDocument.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {"category": "Invoice", "confidence": 0.98}

### Step 4: Extract Invoice Data (Since Classified as Invoice)
# @name analyzeInvoice
POST {{endpoint}}/contentunderstanding/analyzers/prebuilt-invoice:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{documentUrl}}"
}

// Response: {"operationId": "invoice-analysis-001"}

### Step 5: Retrieve Extracted Invoice Fields
# @name getInvoiceResults
GET {{endpoint}}/contentunderstanding/analyzerResults/{{analyzeInvoice.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "fields": {
//     "InvoiceId": "INV-2025-001",
//     "InvoiceDate": "2025-08-15", 
//     "DueDate": "2025-09-14",
//     "VendorName": "Contoso Supplies Ltd",
//     "VendorAddress": "123 Business Park, Seattle, WA 98101",
//     "BillToName": "Fabrikam Corp",
//     "SubTotal": 1250.00,
//     "TotalTax": 125.00,
//     "InvoiceTotal": 1375.00,
//     "Currency": "USD"
//   },
//   "lineItems": [
//     {
//       "Description": "Office Supplies - Paper & Pens",
//       "Quantity": 50,
//       "UnitPrice": 15.00,
//       "Amount": 750.00
//     },
//     {
//       "Description": "Printer Cartridges - HP LaserJet", 
//       "Quantity": 10,
//       "UnitPrice": 50.00,
//       "Amount": 500.00
//     }
//   ],
//   "confidence": {
//     "InvoiceTotal": 0.99,
//     "VendorName": 0.96,
//     "InvoiceDate": 0.98
//   }
// }
```

---

## Custom Document Understanding for HR Employee Onboarding

**Customer Value:** Streamline employee onboarding by automatically extracting data from diverse HR documents (contracts, forms, certifications) and populating HRIS systems without manual data entry.

**Business Scenario:** An HR department processes employment contracts, background check forms, tax documents, and certifications. Each document type has different fields, and manual extraction is error-prone and time-consuming.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@analyzerId = employment-contract-analyzer

### Step 1: Create Custom Employment Contract Analyzer
# @name createHRAnalyzer
PUT {{endpoint}}/contentunderstanding/analyzers/{{analyzerId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "config": {
    "schema": {
      "fields": {
        "EmployeeId": { "type": "string" },
        "FullName": { "type": "string" },
        "Position": { "type": "string" },
        "Department": { "type": "string" },
        "StartDate": { "type": "date" },
        "Salary": { "type": "number" },
        "ManagerName": { "type": "string" },
        "WorkLocation": { "type": "string" },
        "EmploymentType": { "type": "string" },
        "Benefits": { "type": "array" }
      }
    },
    "analysisMode": "document",
    "processingLocation": "global"
  }
}

// Response: {"operationId": "analyzer-create-hr-001"}

### Step 2: Analyze Employment Contract
# @name analyzeContract
POST {{endpoint}}/contentunderstanding/analyzers/{{analyzerId}}:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/pdf

< ./employment-contract-sarah-johnson.pdf

// Response: {"operationId": "contract-analysis-emp-001"}

### Step 3: Poll Analysis Status
# @name checkAnalysisStatus
GET {{endpoint}}/contentunderstanding/analyzers/{{analyzerId}}/operations/{{analyzeContract.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "status": "succeeded",
//   "createdDateTime": "2025-09-02T14:30:00Z",
//   "lastUpdatedDateTime": "2025-09-02T14:30:45Z"
// }

### Step 4: Retrieve Extracted Employee Data
# @name getEmployeeData
GET {{endpoint}}/contentunderstanding/analyzerResults/{{analyzeContract.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "fields": {
//     "EmployeeId": "EMP-2025-0847",
//     "FullName": "Sarah Johnson",
//     "Position": "Senior Software Engineer",
//     "Department": "Engineering",
//     "StartDate": "2025-09-15",
//     "Salary": 125000,
//     "ManagerName": "Michael Chen",
//     "WorkLocation": "Seattle, WA / Remote Hybrid",
//     "EmploymentType": "Full-time",
//     "Benefits": [
//       "Health Insurance",
//       "401k Match", 
//       "Stock Options",
//       "Flexible PTO"
//     ]
//   },
//   "confidence": {
//     "EmployeeId": 0.99,
//     "FullName": 0.98,
//     "Salary": 0.96,
//     "StartDate": 0.99
//   }
// }
```

---

## Intelligent Security & Identity Verification

**Customer Value:** Build secure, automated identity verification systems for access control, visitor management, and compliance monitoring using face detection and person identification.

**Business Scenario:** A corporate office needs to manage employee access, track visitor entry, and monitor compliance with security protocols. The system should identify known employees, flag unknown persons, and maintain audit logs.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@securityImageUrl = https://security.contoso.com/camera-feed/entrance-001/2025-09-02-14-30-15.jpg

### Step 1: Create Employee Directory
# @name createDirectory
POST {{endpoint}}/contentunderstanding/personDirectories?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "name": "Corporate-Employees-2025"
}

// Response: {"personDirectoryId": "dir-corp-emp-2025", "name": "Corporate-Employees-2025"}

### Step 2: Add Employee to Directory
# @name addEmployee
POST {{endpoint}}/contentunderstanding/personDirectories/{{createDirectory.response.body.personDirectoryId}}/persons?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "name": "John Smith - EMP001",
  "userData": {
    "employeeId": "EMP001",
    "department": "Engineering",
    "accessLevel": "Level-3"
  }
}

// Response: {"personId": "person-emp-001", "name": "John Smith - EMP001"}

### Step 3: Add Employee Face Profile
# @name addFaceProfile
POST {{endpoint}}/contentunderstanding/personDirectories/{{createDirectory.response.body.personDirectoryId}}/persons/{{addEmployee.response.body.personId}}/faces?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: image/jpeg

< ./employee-photos/john-smith-emp001.jpg

// Response: {"faceId": "face-emp-001-primary", "boundingBox": {"x": 120, "y": 80, "width": 200, "height": 240}}

### Step 4: Detect Faces in Security Camera Feed
# @name detectFaces
POST {{endpoint}}/contentunderstanding/faces:detect?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: image/jpeg

< ./security-camera-captures/entrance-001-current.jpg

// Response: {
//   "faces": [
//     {
//       "faceId": "detected-face-001",
//       "boundingBox": {"x": 150, "y": 100, "width": 180, "height": 220},
//       "attributes": {
//         "age": 32,
//         "gender": "male",
//         "confidence": 0.94
//       }
//     }
//   ]
// }

### Step 5: Identify Person Against Employee Directory
# @name identifyPerson
POST {{endpoint}}/contentunderstanding/personDirectories/{{createDirectory.response.body.personDirectoryId}}/persons:identify?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "faceImageUrl": "{{securityImageUrl}}"
}

// Response: {
//   "candidates": [
//     {
//       "personId": "{{addEmployee.response.body.personId}}",
//       "confidence": 0.96
//     }
//   ],
//   "identificationResult": {
//     "employeeId": "EMP001",
//     "name": "John Smith",
//     "department": "Engineering",
//     "accessLevel": "Level-3",
//     "accessGranted": true
//   }
// }
```

---

## Multi-Modal Content Analysis for Digital Asset Management

**Customer Value:** Automatically organize, categorize, and extract metadata from diverse digital content (documents, images, videos) to build searchable digital asset libraries and enable content governance.

**Business Scenario:** A marketing team manages thousands of digital assets including campaign materials, product photos, legal documents, and brand guidelines. They need automated tagging, content extraction, and compliance monitoring.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@classifierId = digital-asset-classifier
@campaignImageUrl = https://assets.contoso.com/campaigns/summer-2025/hero-image.jpg
@brandGuidelinesUrl = https://assets.contoso.com/brand/brand-guidelines-2025.pdf

### Step 1: Create Content Type Classifier
# @name createContentClassifier
PUT {{endpoint}}/contentunderstanding/classifiers/{{classifierId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "categories": [
    { "name": "Marketing-Material" },
    { "name": "Product-Photo" },
    { "name": "Legal-Document" },
    { "name": "Brand-Guidelines" },
    { "name": "Technical-Specification" },
    { "name": "Customer-Content" }
  ]
}

// Response: {"operationId": "classifier-create-dam-001"}

### Step 2: Classify Marketing Campaign Image
# @name classifyImage
POST {{endpoint}}/contentunderstanding/classifiers/{{classifierId}}:classify?_overload=classifyBinary&api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: image/jpeg

< ./marketing-assets/summer-2025-hero-image.jpg

// Response: {"operationId": "classify-campaign-img-001"}

### Step 3: Get Content Classification
# @name getContentClassification
GET {{endpoint}}/contentunderstanding/classifierResults/{{classifyImage.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "category": "Marketing-Material",
//   "confidence": 0.95,
//   "metadata": {
//     "contentType": "image/jpeg",
//     "analysisDateTime": "2025-09-02T15:45:00Z"
//   }
// }

### Step 4: Detect People in Marketing Image
# @name detectPeopleInImage
POST {{endpoint}}/contentunderstanding/faces:detect?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{campaignImageUrl}}"
}

// Response: {
//   "faces": [
//     {
//       "boundingBox": {"x": 200, "y": 150, "width": 180, "height": 220},
//       "attributes": {
//         "age": 28,
//         "gender": "female",
//         "emotion": "happiness",
//         "confidence": 0.92
//       }
//     },
//     {
//       "boundingBox": {"x": 450, "y": 180, "width": 160, "height": 200},
//       "attributes": {
//         "age": 35,
//         "gender": "male", 
//         "emotion": "confidence",
//         "confidence": 0.89
//       }
//     }
//   ],
//   "analysisMetadata": {
//     "totalFaces": 2,
//     "averageAge": 31.5,
//     "genderDistribution": {"female": 1, "male": 1},
//     "emotionalTone": "positive"
//   }
// }

### Step 5: Analyze Associated Brand Guidelines Document
# @name analyzeBrandDoc
POST {{endpoint}}/contentunderstanding/analyzers/prebuilt-documentAnalyzer:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{brandGuidelinesUrl}}"
}

// Response: {"operationId": "brand-doc-analysis-001"}

### Step 6: Retrieve Brand Guidelines Analysis
# @name getBrandAnalysis
GET {{endpoint}}/contentunderstanding/analyzerResults/{{analyzeBrandDoc.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "fields": {
//     "DocumentTitle": "Contoso Brand Guidelines 2025",
//     "Version": "v3.2",
//     "LastUpdated": "2025-08-01",
//     "BrandColors": ["#FF6B35", "#004E89", "#FFFFFF"],
//     "Typography": ["Segoe UI", "Arial", "Helvetica"],
//     "LogoUsage": "Primary logo must maintain 1:1 aspect ratio"
//   },
//   "pages": [
//     {
//       "pageNumber": 1,
//       "content": "Brand identity standards and visual guidelines...",
//       "sections": ["Logo Usage", "Color Palette", "Typography", "Photography Style"]
//     }
//   ],
//   "complianceCheck": {
//     "campaignImageCompliance": {
//       "colorPalette": "compliant",
//       "logoUsage": "not-applicable",
//       "photographyStyle": "compliant"
//     }
//   }
// }
```

---

## Regulatory Compliance & Document Audit Pipeline

**Customer Value:** Ensure regulatory compliance by automatically scanning, classifying, and monitoring documents for compliance violations, sensitive data, and audit trail requirements.

**Business Scenario:** A financial services company must maintain compliance with regulations like SOX, GDPR, and industry standards. They need to scan thousands of documents, identify sensitive information, ensure proper retention, and generate audit reports.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@complianceClassifier = compliance-classifier
@financialAnalyzer = financial-document-analyzer
@financialDocUrl = https://compliance.contoso.com/q3-2025/financial-statement.pdf

### Step 1: Create Compliance Document Classifier
# @name createComplianceClassifier
PUT {{endpoint}}/contentunderstanding/classifiers/{{complianceClassifier}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "categories": [
    { "name": "Financial-Statement" },
    { "name": "Customer-Agreement" },
    { "name": "Privacy-Policy" },
    { "name": "Audit-Report" },
    { "name": "Employee-Record" },
    { "name": "Regulatory-Filing" }
  ]
}

// Response: {"operationId": "classifier-create-compliance-001"}

### Step 2: Create Custom Analyzer for Financial Documents
# @name createFinancialAnalyzer
PUT {{endpoint}}/contentunderstanding/analyzers/{{financialAnalyzer}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "config": {
    "schema": {
      "fields": {
        "DocumentType": { "type": "string" },
        "CompanyName": { "type": "string" },
        "ReportingPeriod": { "type": "string" },
        "AuditorName": { "type": "string" },
        "ComplianceStatus": { "type": "string" },
        "RevenueFigures": { "type": "array" },
        "SignatoryNames": { "type": "array" },
        "ConfidentialityLevel": { "type": "string" },
        "RetentionPeriod": { "type": "string" }
      }
    },
    "analysisMode": "document",
    "processingLocation": "global",
    "complianceFeatures": {
      "piiDetection": true,
      "sensitiveDataMasking": true,
      "auditLogging": true
    }
  }
}

// Response: {"operationId": "analyzer-create-financial-001"}

### Step 3: Classify Uploaded Financial Document
# @name classifyFinancialDoc
POST {{endpoint}}/contentunderstanding/classifiers/{{complianceClassifier}}:classify?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{financialDocUrl}}"
}

// Response: {"operationId": "classify-financial-doc-001"}

### Step 4: Get Document Classification
# @name getDocumentClassification
GET {{endpoint}}/contentunderstanding/classifierResults/{{classifyFinancialDoc.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "category": "Financial-Statement",
//   "confidence": 0.97,
//   "complianceFlags": {
//     "sensitivityLevel": "high",
//     "regulatoryScope": ["SOX", "SEC"],
//     "retentionRequired": "7-years"
//   }
// }

### Step 5: Analyze Financial Document for Compliance Data
# @name analyzeFinancialDoc
POST {{endpoint}}/contentunderstanding/analyzers/{{financialAnalyzer}}:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{financialDocUrl}}"
}

// Response: {"operationId": "financial-analysis-q3-001"}

### Step 6: Retrieve Compliance Analysis Results
# @name getComplianceResults
GET {{endpoint}}/contentunderstanding/analyzerResults/{{analyzeFinancialDoc.response.body.operationId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}

// Response: {
//   "fields": {
//     "DocumentType": "Quarterly Financial Statement",
//     "CompanyName": "Contoso Financial Services Inc.",
//     "ReportingPeriod": "Q3 2025 (Jul-Sep 2025)",
//     "AuditorName": "Deloitte & Touche LLP",
//     "ComplianceStatus": "SOX Compliant",
//     "RevenueFigures": [
//       {"Q3-2025": "$45.2M"},
//       {"Q2-2025": "$42.8M"},
//       {"Q3-2024": "$38.9M"}
//     ],
//     "SignatoryNames": [
//       "John Anderson - CEO",
//       "Sarah Kim - CFO",
//       "Michael Rodriguez - Controller"
//     ],
//     "ConfidentialityLevel": "Internal - Financial",
//     "RetentionPeriod": "7 years per SOX requirements"
//   },
//   "complianceValidation": {
//     "requiredSignatures": "complete",
//     "auditTrail": "verified",
//     "dataIntegrity": "passed",
//     "retentionPolicy": "enforced"
//   },
//   "sensitiveDataDetected": {
//     "financialFigures": 12,
//     "executiveNames": 3,
//     "confidentialMarkings": 8
//   },
//   "auditMetadata": {
//     "processedDateTime": "2025-09-02T16:20:00Z",
//     "complianceFrameworks": ["SOX", "SEC-10Q"],
//     "riskAssessment": "low",
//     "nextReviewDate": "2026-09-02"
//   }
// }
```

