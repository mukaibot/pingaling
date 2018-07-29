defmodule Api.Resources.Manifest do
  @moduledoc false

  alias Api.Resources

  def apply(params) do
    endpoint = Resources.get_endpoint(params["spec"]["name"])

    if endpoint == nil do
      Resources.create_endpoint(params["spec"])
      status = :created
    else
      Resources.update_endpoint(endpoint, params["spec"])
      status = :ok
    end

    %{status: status, resource: Resources.get_endpoint!(params["spec"]["name"])
    }
  end
end
