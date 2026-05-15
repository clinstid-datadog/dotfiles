# Personal Static App Development Patterns

This file captures key patterns and decisions from building static apps in the DataDog web-ui monorepo.

## CSS Modules Patterns

**Use CSS modules for structural/container styles:**

- Use PascalCase naming (`.Layout`, `.Container`, `.Main`)
- Create files matching component names: `Layout.tsx` → `layout.module.css`
- Use for layout, positioning, and dimensions
- Use inline styles or DRUIDS helper props for one-off styling, spacing, and colors
- Add new static apps to `.eslintrc.js` gate-css-modules `allowedPaths`

## DRUIDS Component Patterns

### Facet Components

- Clear button only appears when `selectionType='included'` or `selectionType='excluded'` is explicitly set
- Set `selectionType` based on whether filters are active to show/hide clear button
- The `onClear` prop does not exist on Facet components

### Text Capitalization

- Some DRUIDS components like `TabList` apply text-transform deep in their implementation
- The `textTransform` prop on child components like `Title` has no effect in these cases
- Accept the default capitalization rather than fighting it

### Layout Components

- Use `FlexItem` components instead of hardcoded widths and inline flex properties
- Use `shrink={false}` with `minWidth` for fixed-width items (like labels)
- Use `grow` for flexible items
- This provides better consistency with DRUIDS layout patterns

## Data Fetching (Rapid Service Viewer)

### Service Details API

- Service details are fetched from storage proxy API using `domain/service` from serviceId format
- Use `staleTime: 0` and `cacheTime: 0` for data that should always be fresh
- Enable queries only when all required dependencies are available (`serviceId`, `apiBaseUrl`, `storageKey`)
- This avoids initial load issues with query params

## Table Configuration (Rapid Service Viewer)

### Stable Column Widths

- Use `resizableColumns` with `initialValue` for stable column widths
- Use `resizeBehavior: 'auto'` for smooth resizing
- Use `isScrollable="vertical"` for better UX
- Set default sorting with `sorting.initialValue` configuration

### Workload Field

- Protocol and visibility are combined into "Workload" field throughout the app
- Used consistently in table, facets, and details views
- Format: `'public http'` or `'internal http'` for HTTP services, just protocol for others

## URL State Management (Rapid Service Viewer)

### OIDC Authentication Redirect

- Preserve complete URL state including `location.pathname`, `location.search`, and `location.hash`
- Include all parts in the 'next' parameter when redirecting to `/oidc/login`
- This ensures filters, selections, and other query params survive authentication

### Filter State

- Use `use-query-params` for URL-based filter state
- Auto-expand facets when their filter arrays have `length > 0`
- Set `isOpenByDefault` dynamically to provide visual feedback about active filters

## Search Functionality (Rapid Service Viewer)

### Multi-Facet Search

- Search across all facets: name, domain, owner, language, workload, environments
- Combine searchable text into single lowercase string and use `includes()` for matching
- Workload search must handle conditional format:
  - `'public http'` or `'internal http'` for HTTP services
  - Just protocol for other protocols

## User Preferences

### LocalStorage Patterns

- Use `localStorage` to persist user preferences (e.g., dismissed warnings)
- Wrap in try-catch to handle localStorage access errors gracefully
- Use descriptive keys like `'rapid-service-viewer-prototype-warning-dismissed'`
