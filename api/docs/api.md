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
      "url": "https://service.svc.local/healthz",
      "updated": null,
      "type": "endpoint",
      "status": "pending",
      "name": "my-service19"
    },
    {
      "url": "http://foobar.com.au/diagnostic",
      "updated": null,
      "type": "endpoint",
      "status": "pending",
      "name": "my-service20"
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
      "url": "https://dingbats.svc.local/boop",
      "updated_at": "2018-08-21T10:54:54.084053Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service12",
      "id": 96
    },
    {
      "url": "https://dingbats.svc.local/boop",
      "updated_at": "2018-08-21T10:54:54.085110Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service12",
      "id": 97
    },
    {
      "url": "https://dingbats.svc.local/boop",
      "updated_at": "2018-08-21T10:54:54.085859Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service12",
      "id": 98
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
      "endpoint": "my-service2",
      "channel": "channel3"
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
      "name": "foobar",
      "endpoint": "my-service0",
      "description": "non-critical errors",
      "channel": "channel1"
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
  "message": "Updated Slack channel foobar"
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
      "updated_at": "2018-08-21T10:54:53.884995Z",
      "type": "slack",
      "name": "channel4"
    },
    {
      "updated_at": "2018-08-21T10:54:53.886888Z",
      "type": "pagerduty",
      "name": "channel5"
    }
  ]
}
```

