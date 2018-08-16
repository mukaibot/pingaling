import EctoEnum

defenum HealthStatusEnum, :health_status, [:pending, :healthy, :unhealthy]
defenum CheckTypeEnum, :check_type, [:endpoint, :cron]
defenum IncidentStatusEnum, :incident_status, [:open, :closed, :resolved, :auto_resolved]
