defmodule Api.Resources.Manifest do
  @moduledoc false

  alias Api.Resources.Manifests.V1.Endpoint
  alias Api.Resources.Manifests.V1.Slack

  @acceptable_kinds ["checks/endpoint", "notifications/slack"]

  def apply(input) do
    case validate(input) do
      {:ok, "checks/endpoint", params} -> Endpoint.upsert(Map.get(params, "spec"))
      {:ok, "notifications/slack", params} -> Slack.upsert(Map.get(params, "spec"))
      {:bad_request, message} -> {:bad_request, message}
    end
  end

  defp ensure_api_version({_, params}) do
    cond do
      !is_map(params) ->
        {:bad_request, %{message: "params is not a map"}}
      !Map.has_key?(params, "apiVersion") ->
        {:bad_request, %{message: "params is missing apiVersion"}}
      Map.get(params, "apiVersion") == 1 ->
        {:ok, params}
      true ->
        {:bad_request, %{message: "only 'apiVersion: 1' is supported for now"}}
    end
  end

  defp ensure_kind_present({status, params}) do
    cond do
      status == :bad_request ->
        {status, params}
      Map.has_key?(params, "kind") ->
        {:ok, params}
      true ->
        {:bad_request, %{message: "Missing kind"}}
    end
  end

  defp ensure_kind_valid({status, params}) do
    if status == :bad_request do
      {status, params}
    else
      %{"kind" => kind} = params

      if Enum.member?(@acceptable_kinds, kind) do
        {status, kind, params}
      else
        {:bad_request, %{message: "Invalid kind '#{kind}'. Acceptable values are #{Enum.join(@acceptable_kinds, ", ")}"}}
      end
    end
  end

  defp ensure_spec_present({status, kind, params}) do
    cond do
      status == :bad_request ->
        {status, kind, params}
      Map.has_key?(params, "spec") ->
        {:ok, kind, params}
      true ->
        {:bad_request, %{message: "Missing spec"}}
    end
  end

  defp ensure_spec_present({:bad_request, message}) do
    {:bad_request, message}
  end

  defp validate(params) do
    {:ok, params}
    |> ensure_api_version
    |> ensure_kind_present
    |> ensure_kind_valid
    |> ensure_spec_present
  end
end
