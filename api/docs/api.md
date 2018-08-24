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
      "name": "my-service21"
    },
    {
      "url": "https://dingbats.svc.local/boop",
      "updated": null,
      "type": "endpoint",
      "status": "pending",
      "name": "my-service22"
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
      "updated_at": "2018-08-24T10:06:40.703663Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service14",
      "id": 251
    },
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-08-24T10:06:40.704857Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service14",
      "id": 252
    },
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-08-24T10:06:40.706780Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service14",
      "id": 253
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
  "name": "foobar-svc",
  "description": "an excellent service"
}
```

#### applying a manifest creates a notification policy
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
      "webhook_url": "https://hooks.slack.com/services/Z027TX47K/ABC1C7WUC/yT8EZZquxq4uEHkfE4gzrBoI",
      "name": "foobar"
    },
    "kind": "notifications/slack",
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
  "message": "Created Slack channel foobar"
}
```

#### applying a manifest updates a notification policy
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
      "webhook_url": "https://hooks.slack.com/services/Z027TX47K/ABC1C7WUC/yT8EZZquxq4uEHkfE4gzrBoI",
      "name": "foobar",
      "description": "non-critical errors"
    },
    "kind": "notifications/slack",
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
  "message": "Updated Slack channel foobar"
}
```

#### applying a manifest creates a notification policy
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
      "name": "foobar",
      "endpoint": "my-service1",
      "channel": "channel2"
    },
    "kind": "notifications/policy",
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
  "message": "Created new policy linking Endpoint 'my-service1' to Slack channel 'foobar'"
}
```

#### applying a manifest updates a notification policy
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
      "name": "foobar",
      "endpoint": "my-service3",
      "description": "non-critical errors",
      "channel": "channel4"
    },
    "kind": "notifications/policy",
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
  "message": "Updated policy linking Endpoint 'my-service3' to Pagerduty channel 'foobar'"
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
      "updated_at": "2018-08-24T10:06:40.509631Z",
      "type": "pagerduty",
      "name": "channel6"
    },
    {
      "updated_at": "2018-08-24T10:06:40.510929Z",
      "type": "slack",
      "name": "channel7"
    }
  ]
}
```

