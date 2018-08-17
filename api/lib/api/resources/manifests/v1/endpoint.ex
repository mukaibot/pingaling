defmodule Api.Resources.Manifests.V1.Endpoint do
  defstruct apiVersion: nil, kind: nil, spec: nil

  alias Api.Resources
  alias Api.Resources.Manifests.V1.Endpoint

  def validate(%Endpoint{apiVersion: nil}), do: {:bad_request, %{message: "missing apiVersion"}}
  def validate(%Endpoint{kind: nil}), do: {:bad_request, %{message: "missing kind"}}
  def validate(%Endpoint{spec: nil}), do: {:bad_request, %{message: "missing spec"}}

  def validate(%Endpoint{spec: spec}) do
    if !is_map(spec) do
      {:bad_request, %{message: "spec is not a map"}}
    end
  end

  def validate(%Endpoint{apiVersion: version}) do
    if version != 1 do
      {:bad_request, %{message: "unknown apiVersion. Supported apiVersion is 1"}}
    end
  end

  def upsert(params) do
    endpoint = Resources.get_endpoint(params["spec"]["name"])

    status = if endpoint == nil do
      Resources.create_endpoint(params["spec"])
      :created
    else
      Resources.update_endpoint(endpoint, params["spec"])
      :ok
    end

    {
      status,
      Resources.get_endpoint!(params["spec"]["name"])
    }
  end
end

