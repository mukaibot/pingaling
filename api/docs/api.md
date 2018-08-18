# API Documentation

  * [API /api/endpoints](#api-api-endpoints)
    * [show](#api-api-endpoints-show)
  * [API /api/health](#api-api-health)
    * [index](#api-api-health-index)
  * [API /api/incidents](#api-api-incidents)
    * [index](#api-api-incidents-index)
  * [API /api/manifest](#api-api-manifest)
    * [apply](#api-api-manifest-apply)
  * [API /api/notification_channels](#api-api-notification_channels)
    * [index](#api-api-notification_channels-index)

## API /api/endpoints
### <a id=api-api-endpoints-show></a>show
#### getting an endpoint by name
##### Request
* __Method:__ GET
* __Path:__ /api/endpoints/some-name
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "data": {
    "url": "http://my-service/healthz",
    "next_check": "2010-04-17T14:00:00.000000Z",
    "name": "some-name",
    "description": "some description"
  }
}
```

## API /api/health
### <a id=api-api-health-index></a>index
#### returning health summaries for all endpoints
##### Request
* __Method:__ GET
* __Path:__ /api/health/summary
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "data": [
    {
      "url": "http://foobar.com.au/diagnostic",
      "updated": null,
      "type": "endpoint",
      "status": "pending",
      "name": "my-service15"
    },
    {
      "url": "https://dingbats.svc.local/boop",
      "updated": null,
      "type": "endpoint",
      "status": "pending",
      "name": "my-service16"
    }
  ]
}
```

## API /api/incidents
### <a id=api-api-incidents-index></a>index
#### getting all incidents ordered by least to most recent
##### Request
* __Method:__ GET
* __Path:__ /api/incidents
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "data": [
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-08-17T05:17:28.611846Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service6",
      "id": 324
    },
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-08-17T05:17:28.613516Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service6",
      "id": 325
    },
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-08-17T05:17:28.614488Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service6",
      "id": 326
    }
  ]
}
```

## API /api/manifest
### <a id=api-api-manifest-apply></a>apply
#### applying a manifest creates an endpoint
##### Request
* __Method:__ POST
* __Path:__ /api/manifest
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "manifest": {
    "spec": {
      "url": "https://google.com",
      "name": "foobar-svc"
    },
    "kind": "checks/endpoint",
    "apiVersion": 1
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "url": "https://google.com",
  "next_check": null,
  "name": "foobar-svc",
  "description": null
}
```

#### applying a manifest updates an endpoint
##### Request
* __Method:__ POST
* __Path:__ /api/manifest
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "manifest": {
    "spec": {
      "url": "https://google.com",
      "name": "foobar-svc",
      "description": "an excellent service"
    },
    "kind": "checks/endpoint",
    "apiVersion": 1
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "url": "https://google.com",
  "next_check": null,
  "name": "foobar-svc",
  "description": "an excellent service"
}
```

## API /api/notification_channels
### <a id=api-api-notification_channels-index></a>index
#### listing all channels
##### Request
* __Method:__ GET
* __Path:__ /api/notification_channels
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
```
* __Response body:__
```json
{
  "data": [
    {
      "updated_at": "2018-08-17T05:17:28.624174Z",
      "type": "slack",
      "name": "channel10"
    },
    {
      "updated_at": "2018-08-17T05:17:28.626179Z",
      "type": "pagerduty",
      "name": "channel11"
    }
  ]
}
```
