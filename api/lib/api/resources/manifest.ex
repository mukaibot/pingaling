defmodule Api.Resources.Manifest do
  @moduledoc false

  alias Api.Resources.Manifests.V1.Endpoint
  alias Api.Resources.Manifests.V1.Slack
  alias Api.Resources.Manifests.V1.NotificationPolicy

  @acceptable_kinds ["checks/endpoint", "notifications/policy", "notifications/slack"]

  def apply(input) do
    case validate(input) do
      {:ok, "checks/endpoint", params} -> Endpoint.upsert(Map.get(params, "spec"))
      {:ok, "notifications/policy", params} -> NotificationPolicy.apply(Map.get(params, "spec"))
      {:ok, "notifications/slack", params} -> Slack.upsert(Map.get(params, "spec"))
      {:bad_request, message} -> {:bad_request, message}
    end
  end

  defp ensure_api_version({:ok, %{"apiVersion" => nil} = _}), do: {:bad_request, %{message: "Missing apiVersion"}}
  defp ensure_api_version({:ok, %{"apiVersion" => 1} = params}), do: {:ok, params}
  defp ensure_api_version({_, _}), do: {:bad_request, %{message: "only 'apiVersion: 1' is supported for now"}}

  defp ensure_kind_present({:ok, %{"kind" => _} = params}), do: {:ok, params}
  defp ensure_kind_present({:bad_request, params}), do: {:bad_request, params}
  defp ensure_kind_present({_, _}), do: {:bad_request, %{message: "Missing kind"}}

  defp ensure_kind_valid({:bad_request, params}), do: {:bad_request, params}
  defp ensure_kind_valid({_, %{"kind" => kind} = params}) when kind in @acceptable_kinds, do:
    {:ok, kind, params}
  defp ensure_kind_valid({_, %{"kind" => kind}}) do
    {
      :bad_request,
      %{
        message: "Invalid kind '#{kind}'. Acceptable values are #{
          Enum.join(@acceptable_kinds, ",")
        }"
      }
    }
  end

  defp ensure_spec_present({:bad_request, kind, params}), do: {:bad_request, kind, params}
  defp ensure_spec_present({:bad_request, message}), do: {:bad_request, message}
  defp ensure_spec_present({status, kind, %{"spec" => spec} = params}) when is_map(spec), do: {status, kind, params}
  defp ensure_spec_present({_, _, _}), do: {:bad_request, %{message: "Missing spec"}}

  defp validate(params) do
    {:ok, params}
    |> ensure_api_version
    |> ensure_kind_present
    |> ensure_kind_valid
    |> ensure_spec_present
  end
end
