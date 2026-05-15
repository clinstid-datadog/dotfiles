---
name: RAPIDORG-13 Target Overrides
description: Project to add dd-target-overrides header support to the web app's Test Drives configurator with type-aware form (public-http, http, grpc, atlas)
type: project
originSessionId: 0dc27fea-40aa-4cd2-bbb0-5b965e947d74
---
Chris is working on RAPIDORG-13: adding `dd-target-overrides` header support to the Datadog web app. This extends the configurator modal (Internal Tools) with a new "Target Overrides" tab.

**Header format:** protojson `{"overrides":[{"src":"...","dst":"...","proto":"..."}]}` — note field is `dst` not `dest`.

**Override types decided:**
- Public HTTP (`public-http`): service name + TD name, auto-adds `test-drive-{NAME}: 1` header too
- Internal HTTP (`http`): full `service.namespace:port` addresses
- gRPC (`grpc`): full `service.namespace:port` addresses
- Atlas (`atlas`): full addresses

**Why:** Enable in-call-chain gRPC and Atlas Test Drives via Target Overrides from the web app UI.

**How to apply:** Key files: `packages/api/http/http-request/test-drives.ts`, `packages/api/http/http-request/http-request.ts`, `packages/apps/spa/private/runtime/configurator/`. Project docs at `~/Notes/Projects/web-app-target-overrides/`.
