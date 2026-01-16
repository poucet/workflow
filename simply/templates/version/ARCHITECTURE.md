# {Project} Architecture

Last updated: {date}

## Overview

{One paragraph describing what this system does and its primary purpose}

## Key Concepts

| Concept | Description |
|---------|-------------|
| | |

## Structure

```
{directory tree of key paths}
```

## Component Graph

```mermaid
graph TD
    A[Component A] --> B[Component B]
    A --> C[Component C]
    B --> D[Shared Service]
    C --> D
```

## Components

### {Component Name}

**Purpose**: {What it does}

**Key files**:
- `path/to/file.ts` — {role}

**Depends on**: {other components}

**Exposes**: {APIs, exports, interfaces}

---

## Data Flow

```mermaid
flowchart LR
    Input --> Process --> Output
    Process --> Store[(Database)]
    Store --> Process
```

## Patterns

| Pattern | Where Used | Notes |
|---------|------------|-------|
| | | |

## Conventions

- {Naming conventions}
- {File organization rules}
- {Error handling approach}

## External Dependencies

| Dependency | Purpose | Version |
|------------|---------|---------|
| | | |
