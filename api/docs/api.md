# API Documentation

  * [API /api/endpoints](#api-api-endpoints)
    * [show](#api-api-endpoints-show)
    * [delete](#api-api-endpoints-delete)
  * [API /api/health](#api-api-health)
    * [index](#api-api-health-index)
  * [API /api/incidents](#api-api-incidents)
    * [index](#api-api-incidents-index)
  * [API /api/manifest](#api-api-manifest)
    * [apply](#api-api-manifest-apply)
  * [API /api/notification_channels](#api-api-notification_channels)
    * [index](#api-api-notification_channels-index)
    * [delete](#api-api-notification_channels-delete)
  * [API /api/notification_policies](#api-api-notification_policies)
    * [index](#api-api-notification_policies-index)
    * [delete](#api-api-notification_policies-delete)

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

### <a id=api-api-endpoints-delete></a>delete
#### deleting an endpoint it deletes the endpoint
##### Request
* __Method:__ DELETE
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
  "message": "Deleted endpoint some-name"
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
      "name": "my-service28"
    },
    {
      "url": "https://dingbats.svc.local/boop",
      "updated": null,
      "type": "endpoint",
      "status": "pending",
      "name": "my-service29"
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
      "updated_at": "2018-09-02T21:52:12.860557Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service24",
      "id": 623
    },
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-09-02T21:52:12.861696Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service24",
      "id": 624
    },
    {
      "url": "https://service.svc.local/healthz",
      "updated_at": "2018-09-02T21:52:12.862339Z",
      "status": "open",
      "next_attempt": null,
      "name": "my-service24",
      "id": 625
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
      "endpoint": "my-service4",
      "channel": "channel5"
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
  "message": "Created new policy linking Endpoint 'my-service4' to Slack channel 'foobar'"
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
      "endpoint": "my-service1",
      "description": "non-critical errors",
      "channel": "channel2"
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
  "message": "Updated policy linking Endpoint 'my-service1' to Slack channel 'foobar'"
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
      "updated_at": "2018-09-02T21:52:12.681863Z",
      "type": "pagerduty",
      "name": "channel16"
    },
    {
      "updated_at": "2018-09-02T21:52:12.682945Z",
      "type": "slack",
      "name": "channel17"
    }
  ]
}
```

### <a id=api-api-notification_channels-delete></a>delete
#### deleting channel is deleted
##### Request
* __Method:__ DELETE
* __Path:__ /api/notification_channels/channel15
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
  "message": "Deleted notification channel channel15"
}
```

## API /api/notification_policies
### <a id=api-api-notification_policies-index></a>index
#### listing all policies
##### Request
* __Method:__ GET
* __Path:__ /api/notification_policies
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
      "updated_at": "2018-09-02T21:52:12.667798Z",
      "type": "pagerduty",
      "name": "notification_policy12",
      "endpoint": "my-service13",
      "channel": "channel14"
    },
    {
      "updated_at": "2018-09-02T21:52:12.664611Z",
      "type": "slack",
      "name": "notification_policy9",
      "endpoint": "my-service10",
      "channel": "channel11"
    }
  ]
}
```

### <a id=api-api-notification_policies-delete></a>delete
#### deleting policy is deleted
##### Request
* __Method:__ DELETE
* __Path:__ /api/notification_policies/notification_policy6
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
  "message": "Deleted notification policy notification_policy6"
}
```

