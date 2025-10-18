# Microsoft Genome Data Plane APIs

This directory will contain the Data Plane APIs for Microsoft Genome service.

## Planned APIs

_To be defined by the team_

### Potential Data Plane Operations
- Genomic data upload/download
- Analysis job management  
- Results retrieval
- Data querying and filtering

## Structure

When adding data-plane APIs, follow this structure:
```
data-plane/
├── Microsoft.Genome/
│   ├── stable/
│   │   └── [version]/
│   └── preview/  
│       └── [version]/
└── readme.md
```

## Getting Started

For SDK generation and API documentation, see the main [readme.md](../readme.md) file.

## Contributing

Please coordinate with the team before adding data-plane API definitions to ensure consistency with the overall service architecture.
