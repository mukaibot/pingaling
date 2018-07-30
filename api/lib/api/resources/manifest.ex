defmodule Api.Resources.Manifest do
  @moduledoc false

  alias Api.Resources

  def apply(input) do
    validated_input = validate(input)
    case elem(validated_input, 0) do
      :ok ->
        {_, params} = validated_input
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

      :bad_request ->
        validated_input
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

      if kind == "checks/endpoint" do
        {status, params}
      else
        {:bad_request, %{message: "the only supported kind for now is 'checks/endpoint'"}}
      end
    end
  end

  defp ensure_spec_present({status, params}) do
    cond do
      status == :bad_request ->
        {status, params}
      Map.has_key?(params, "spec") ->
        {:ok, params}
      true ->
        {:bad_request, %{message: "Missing spec"}}
    end
  end

  defp ensure_spec_valid({status, params}) do
    if status == :bad_request do
      {status, params}
    else
      %{"spec" => spec} = params

      cond do
        !is_map(spec) ->
          {:bad_request, %{message: "spec is not a map"}}
        !Map.has_key?(spec, "name") ->
          {:bad_request, %{message: "spec is missing name"}}
        !Map.has_key?(spec, "url") ->
          {:bad_request, %{message: "spec is missing url"}}
        true ->
          {:ok, params}
      end
    end
  end

  defp validate(params) do
    {:ok, params}
    |> ensure_api_version
    |> ensure_kind_present
    |> ensure_kind_valid
    |> ensure_spec_present
    |> ensure_spec_valid
  end
end
