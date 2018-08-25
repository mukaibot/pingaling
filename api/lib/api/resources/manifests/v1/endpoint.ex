defmodule Api.Resources.Manifests.V1.Endpoint do
  alias Api.Resources

  defp ensure_spec_valid(spec) do
    cond do
      !is_map(spec) ->
        {:bad_request, %{message: "spec is not a map"}}
      !Map.has_key?(spec, "name") ->
        {:bad_request, %{message: "spec is missing name"}}
      !Map.has_key?(spec, "url") ->
        {:bad_request, %{message: "spec is missing url"}}
      true ->
        {:ok, spec}
    end
  end

  def upsert(params) do
    {status, spec} = ensure_spec_valid(params)

    if status == :bad_request do
      {status, spec}
    else
      endpoint = Resources.get_endpoint(spec["name"])
      status = if endpoint == nil do
        Resources.create_endpoint(spec)
        :created
      else
        Resources.update_endpoint(endpoint, spec)
        :ok
      end

      resource = Resources.get_endpoint!(spec["name"])
      {
        status,
        %{
          description: resource.description,
          name: resource.name,
          url: resource.url
        }
      }
    end
  end
end
